import { query } from "../utils/query.js";
import { uuid } from "../utils/tools.cjs"; // Menggunakan uuid dari tools Anda

export const performLuckyDipDraw = async (req, res) => {
  const { prizeIdsForLuckyDip } = req.body; // Array of prize IDs from frontend

  if (!Array.isArray(prizeIdsForLuckyDip) || prizeIdsForLuckyDip.length === 0) {
    return res.status(400).json({
      success: false,
      message: "Tidak ada hadiah yang dipilih untuk Lucky Dip.",
    });
  }

  try {
    // Sangat disarankan untuk menggunakan transaksi database di sini
    // await query("START TRANSACTION");

    // 1. Validasi dan kumpulkan unit hadiah yang benar-benar tersedia untuk Lucky Dip ini
    let availablePrizeUnits = [];
    for (const prizeId of prizeIdsForLuckyDip) {
      const prizeResult = await query(
        "SELECT id, name, qty FROM prize WHERE id = ?",
        [prizeId]
      );
      if (prizeResult && prizeResult.length > 0) {
        const prize = prizeResult[0];
        // Hitung berapa kali hadiah ini sudah diklaim KHUSUS untuk lucky_dip
        const claimedInLuckyDip = await query(
          "SELECT COUNT(*) as count FROM lucky_dip WHERE id_prize = ?",
          [prizeId]
        );
        const claimedCount = claimedInLuckyDip[0]?.count || 0;
        const remainingForThisPrize = prize.qty - claimedCount;

        for (let i = 0; i < remainingForThisPrize; i++) {
          availablePrizeUnits.push({ id: prize.id, name: prize.name });
        }
      }
    }

    if (availablePrizeUnits.length === 0) {
      // await query("ROLLBACK");
      return res.status(400).json({
        success: false,
        message:
          "Hadiah yang dipilih untuk Lucky Dip sudah habis atau tidak valid.",
      });
    }

    // 2. Dapatkan SEMUA karyawan yang BELUM PERNAH MENANG Lucky Dip
    //    Kondisi status_register = 1 DAN status_kedatangan = 1 DIHILANGKAN
    const existingLuckyDipWinners = await query(
      "SELECT DISTINCT no_emp FROM lucky_dip"
    );
    const excludedEmpNosLD = existingLuckyDipWinners.map((w) => w.no_emp);

    let eligibleKaryawanQuery = `
      SELECT no_emp, nama FROM karyawan`; // Mengambil semua karyawan
    const queryParamsLD = [];

    if (excludedEmpNosLD.length > 0) {
      // Jika sudah ada pemenang Lucky Dip, kecualikan mereka
      eligibleKaryawanQuery += ` WHERE no_emp NOT IN (${excludedEmpNosLD
        .map(() => "?")
        .join(",")})`;
      queryParamsLD.push(...excludedEmpNosLD);
    }

    let eligibleEmployees = await query(eligibleKaryawanQuery, queryParamsLD);

    if (eligibleEmployees.length === 0) {
      // await query("ROLLBACK");
      return res.status(400).json({
        success: false,
        message:
          "Tidak ada karyawan eligible yang tersisa untuk Lucky Dip (semua sudah pernah menang atau tidak ada karyawan).",
      });
    }

    // Acak hadiah dan karyawan
    availablePrizeUnits.sort(() => 0.5 - Math.random());
    eligibleEmployees.sort(() => 0.5 - Math.random());

    // 3. Tentukan jumlah pemenang (minimum dari hadiah tersedia atau karyawan eligible)
    const numWinnersToDraw = Math.min(
      availablePrizeUnits.length,
      eligibleEmployees.length
    );
    const drawnWinnersWithPrizes = [];

    if (
      numWinnersToDraw === 0 &&
      availablePrizeUnits.length > 0 &&
      eligibleEmployees.length > 0
    ) {
      // Kasus ini seharusnya tidak terjadi jika validasi di atas sudah benar,
      // tapi sebagai pengaman tambahan.
      // await query("ROLLBACK");
      return res
        .status(400)
        .json({ success: false, message: "Tidak dapat menentukan pemenang." });
    }

    for (let i = 0; i < numWinnersToDraw; i++) {
      const winner = eligibleEmployees[i];
      const prizeToGive = availablePrizeUnits[i];

      await query(
        "INSERT INTO lucky_dip (id_lucky_dip, no_emp, id_prize) VALUES (?, ?, ?)",
        [uuid(), winner.no_emp, prizeToGive.id]
      );
      drawnWinnersWithPrizes.push({
        no_emp: winner.no_emp,
        nama_karyawan: winner.nama, // Menggunakan 'nama' dari tabel karyawan
        id_prize: prizeToGive.id,
        nama_hadiah: prizeToGive.name,
      });
    }

    // await query("COMMIT");
    res.status(201).json({
      success: true,
      message: `${numWinnersToDraw} pemenang Lucky Dip berhasil diundi!`,
      winners: drawnWinnersWithPrizes,
    });
  } catch (error) {
    // await query("ROLLBACK");
    console.error("Error in performLuckyDipDraw:", error);
    res.status(500).json({
      success: false,
      message: "Terjadi kesalahan saat undian Lucky Dip.",
      error: error.message,
    });
  }
};

export const performStandardDraw = async (req, res) => {
  const { prizeId, numToDraw, drawType } = req.body;

  if (!prizeId || !numToDraw || !drawType) {
    return res.status(400).json({
      success: false,
      message: "Prize ID, jumlah pemenang, dan tipe undian diperlukan.",
    });
  }
  const requestedDrawCount = parseInt(numToDraw, 10);
  if (requestedDrawCount <= 0) {
    return res
      .status(400)
      .json({ success: false, message: "Jumlah pemenang harus lebih dari 0." });
  }

  let winnerTableName = "";
  let idFieldName = "";

  if (drawType === "LUCKY_DRAW") {
    winnerTableName = "lucky_draw";
    idFieldName = "id_lucky_draw";
  } else if (drawType === "GRAND_PRIZE") {
    winnerTableName = "grand_prize";
    idFieldName = "id_grand_prize";
  } else {
    return res
      .status(400)
      .json({ success: false, message: "Tipe undian tidak valid." });
  }

  try {
    // await query("START TRANSACTION");

    // 1. Get Prize Details and Available Quantity for THIS specific prize
    const prizeResult = await query(
      "SELECT id, name, qty FROM prize WHERE id = ?",
      [prizeId]
    );
    if (!prizeResult || prizeResult.length === 0) {
      // await query("ROLLBACK");
      return res
        .status(404)
        .json({ success: false, message: "Hadiah tidak ditemukan." });
    }
    const prize = prizeResult[0];
    const initialPrizeQty = prize.qty;

    // Hitung berapa kali hadiah ini sudah diklaim KHUSUS untuk jenis undian ini
    const claimedResult = await query(
      `SELECT COUNT(*) as count FROM ${winnerTableName} WHERE id_prize = ?`,
      [prizeId]
    );
    const claimedQtyForThisDrawType = claimedResult[0]?.count || 0;
    const availableQtyForThisDraw = initialPrizeQty - claimedQtyForThisDrawType;

    if (availableQtyForThisDraw <= 0) {
      // await query("ROLLBACK");
      return res.status(400).json({
        success: false,
        message: `Hadiah "${prize.name}" untuk ${drawType} sudah habis.`,
      });
    }

    const actualNumToDraw = Math.min(
      requestedDrawCount,
      availableQtyForThisDraw
    );

    // 2. Get Eligible Employees
    // Karyawan yang eligible (hadir, terdaftar) DAN belum pernah menang APAPUN di KATEGORI undian ini (LUCKY_DRAW atau GRAND_PRIZE).
    const existingWinnersInThisCategory = await query(
      `SELECT DISTINCT no_emp FROM ${winnerTableName}` // Ambil semua pemenang dari kategori ini
    );
    const excludedEmpNos = existingWinnersInThisCategory.map((w) => w.no_emp);

    let eligibleQuery = `
      SELECT no_emp, nama FROM karyawan
      WHERE status_register = 1 AND status_kedatangan = 1`;
    const queryParams = [];

    if (excludedEmpNos.length > 0) {
      eligibleQuery += ` AND no_emp NOT IN (${excludedEmpNos
        .map(() => "?")
        .join(",")})`;
      queryParams.push(...excludedEmpNos);
    }

    let eligibleEmployees = await query(eligibleQuery, queryParams);

    // Acak di Node.js
    eligibleEmployees.sort(() => 0.5 - Math.random());

    if (eligibleEmployees.length === 0) {
      // await query("ROLLBACK");
      return res.status(400).json({
        success: false,
        message: `Tidak ada karyawan eligible yang tersisa untuk ${drawType}.`,
      });
    }

    const finalDrawCount = Math.min(actualNumToDraw, eligibleEmployees.length);

    if (finalDrawCount === 0) {
      // await query("ROLLBACK");
      return res.status(400).json({
        success: false,
        message:
          "Tidak cukup karyawan eligible untuk diundi (setelah filter pemenang sebelumnya di kategori ini).",
      });
    }

    const drawnWinners = eligibleEmployees.slice(0, finalDrawCount);

    // 3. Insert Winners
    for (const winner of drawnWinners) {
      await query(
        `INSERT INTO ${winnerTableName} (${idFieldName}, no_emp, id_prize) VALUES (?, ?, ?)`,
        [uuid(), winner.no_emp, prizeId]
      );
    }

    // await query("COMMIT");

    return res.status(201).json({
      success: true,
      message: `${finalDrawCount} pemenang berhasil diundi untuk hadiah ${prize.name}!`,
      winners: drawnWinners.map((w) => ({ no_emp: w.no_emp, nama: w.nama })),
      prizeName: prize.name,
      drawnCountThisTurn: finalDrawCount,
      newAvailableQtyForThisPrize: availableQtyForThisDraw - finalDrawCount, // Sisa untuk hadiah spesifik ini
    });
  } catch (error) {
    // await query("ROLLBACK");
    console.error(`Error in performStandardDraw for ${drawType}:`, error);
    return res.status(500).json({
      success: false,
      message: error.message || "Terjadi kesalahan pada server.",
    });
  }
};
