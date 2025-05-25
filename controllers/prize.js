// controllers/prizeController.js
import { query } from "../utils/query.js";

export const getPrize = async (req, res) => {
  try {
    // Ambil semua hadiah beserta kuantitas awal
    const prizesFromDb = await query(
      "SELECT id, name, qty AS initial_qty FROM prize"
    );

    if (!prizesFromDb || prizesFromDb.length === 0) {
      return res.status(200).json({ success: true, prizes: [] });
    }

    const prizesWithAvailability = [];

    for (const prize of prizesFromDb) {
      // Hitung total berapa kali hadiah ini sudah diklaim dari SEMUA jenis undian
      const luckyDipRes = await query(
        "SELECT COUNT(*) as count FROM lucky_dip WHERE id_prize = ?",
        [prize.id]
      );
      const luckyDrawRes = await query(
        "SELECT COUNT(*) as count FROM lucky_draw WHERE id_prize = ?",
        [prize.id]
      );
      const grandPrizeRes = await query(
        "SELECT COUNT(*) as count FROM grand_prize WHERE id_prize = ?",
        [prize.id]
      );

      const totalClaimed =
        (luckyDipRes[0]?.count || 0) +
        (luckyDrawRes[0]?.count || 0) +
        (grandPrizeRes[0]?.count || 0);

      const available_qty = prize.initial_qty - totalClaimed;

      // Hanya sertakan hadiah jika masih tersedia atau qty awalnya memang ada
      if (prize.initial_qty > 0) {
        prizesWithAvailability.push({
          id: prize.id,
          name: prize.name,
          initial_qty: prize.initial_qty,
          available_qty: Math.max(0, available_qty), // Pastikan tidak negatif
        });
      }
    }

    res.status(200).json({ success: true, prizes: prizesWithAvailability });
  } catch (error) {
    console.error("Error fetching all prizes with availability:", error);
    res
      .status(500)
      .json({
        success: false,
        message: "Gagal mengambil daftar hadiah.",
        error: error.message,
      });
  }
};
