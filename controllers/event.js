import { query } from "../utils/query.js";

export const registerEvent = async (req, res) => {
  const { email, noHp, transportasi, keluargaUpdates } = req.body;

  const { noEmp } = req.params;

  if (!noEmp) {
    return res
      .status(400)
      .json({ message: "No employee ID (no_emp) provided." });
  }

  try {
    const userExist = await query(
      `SELECT no_emp FROM karyawan WHERE no_emp = ?`,
      [noEmp]
    );

    if (!userExist.length) {
      return res
        .status(400)
        .json({ message: "Anda tidak terdaftar sebagai karyawan!" });
    }

    const validateRegister = await query(
      `SELECT status_register FROM karyawan WHERE no_emp = ?`,
      [noEmp]
    );

    if (validateRegister[0]?.status_register === 1) {
      return res
        .status(400)
        .json({ message: "Anda sudah pernah melakukan register!" });
    }

    let jumlahKeluarga = 0;
    let anakDibawahUmur = 0;
    let anakDiatasUmur = 0;

    if (Array.isArray(keluargaUpdates)) {
      jumlahKeluarga = keluargaUpdates.length;

      for (const anggota of keluargaUpdates) {
        if (
          anggota.umur <= 12 &&
          anggota.status_keluarga?.toLowerCase() === "anak"
        ) {
          anakDibawahUmur++;
        } else if (
          anggota.umur > 12 &&
          anggota.status_keluarga?.toLowerCase() === "anak"
        ) {
          anakDiatasUmur++;
        }

        await query(
          `UPDATE karyawan_keluarga 
           SET umur = ?, status_register = ? 
           WHERE no_emp = ? AND nama = ?`,
          [anggota.umur, anggota.status_register, noEmp, anggota.nama]
        );
      }
    }

    await query(
      `UPDATE karyawan 
       SET email = ?, no_hp = ?, transportasi = ?, jumlah_keluarga = ?, anak_bawah_umur = ?, anak_diatas_umur = ?, status_register = ?
       WHERE no_emp = ?`,
      [
        email,
        noHp,
        transportasi,
        jumlahKeluarga,
        anakDibawahUmur,
        anakDiatasUmur,
        1,
        noEmp,
      ]
    );

    return res.status(200).json({
      message: "Registrasi berhasil",
    });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

export const getDataPieChart = async (req, res) => {
  try {
    const totalTerdaftarResult = await query(
      "SELECT COUNT(no_emp) AS total FROM karyawan"
    );
    const totalTerdaftar = totalTerdaftarResult[0]?.total || 0;

    if (totalTerdaftar === 0) {
      return res.status(200).json({
        success: true,
        message: "Tidak ada karyawan yang terdaftar pada event ini.",
        totalTerdaftar: 0,
        data: {
          register: [
            { label: "Sudah Register", value: 0 },
            { label: "Belum Register", value: 0 },
          ],
          kedatangan: [
            { label: "Sudah Datang", value: 0 },
            { label: "Belum Datang", value: 0 },
          ],
          snackDewasa: [
            { label: "Sudah Scan Snack Dewasa", value: 0 },
            { label: "Belum Scan Snack Dewasa", value: 0 },
          ],
          dinner: [
            { label: "Sudah Scan Dinner", value: 0 },
            { label: "Belum Scan Dinner", value: 0 },
          ],
        },
      });
    }

    const sudahRegisterResult = await query(
      "SELECT COUNT(DISTINCT no_emp) AS terdaftar FROM karyawan WHERE status_register = 1"
    );
    const karyawanSudahRegister = sudahRegisterResult[0]?.terdaftar || 0;

    const sudahDatangResult = await query(
      "SELECT COUNT(DISTINCT no_emp) AS jumlah FROM karyawan WHERE status_kedatangan = 1"
    );
    const jumlahSudahDatang = sudahDatangResult[0]?.jumlah || 0;

    const sudahScanSnackResult = await query(
      "SELECT COUNT(DISTINCT no_emp) AS jumlah FROM karyawan WHERE status_snack_dewasa = 1"
    );
    const jumlahSudahScanSnack = sudahScanSnackResult[0]?.jumlah || 0;

    const sudahScanDinnerResult = await query(
      "SELECT COUNT(DISTINCT no_emp) AS jumlah FROM karyawan WHERE status_dinner = 1"
    );
    const jumlahSudahScanDinner = sudahScanDinnerResult[0]?.jumlah || 0;

    const responseData = {
      register: [
        { label: "Sudah register", value: karyawanSudahRegister },
        {
          label: "Belum register",
          value: totalTerdaftar - karyawanSudahRegister,
        },
      ],
      kedatangan: [
        { label: "Sudah Datang", value: jumlahSudahDatang },
        {
          label: "Belum Datang",
          value: karyawanSudahRegister - jumlahSudahDatang,
        },
      ],
      snackDewasa: [
        { label: "Sudah Scan Snack Dewasa", value: jumlahSudahScanSnack },
        {
          label: "Belum Scan Snack Dewasa",
          value: karyawanSudahRegister - jumlahSudahScanSnack,
        },
      ],
      dinner: [
        { label: "Sudah Scan Dinner", value: jumlahSudahScanDinner },
        {
          label: "Belum Scan Dinner",
          value: karyawanSudahRegister - jumlahSudahScanDinner,
        },
      ],
    };

    return res.status(200).json({
      success: true,
      message: "Data statistik aktivitas karyawan terdaftar berhasil diambil.",
      totalTerdaftar: totalTerdaftar,
      data: responseData,
    });
  } catch (error) {
    console.error("Error in getPieRegister:", error);
    return res.status(500).json({
      success: false,
      message:
        error.message ||
        "Terjadi kesalahan pada server saat mengambil data statistik.",
    });
  }
};
