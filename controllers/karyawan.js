import { query } from "../utils/query.js";
import xlsx from "xlsx";
import fs from "fs";

export const getKaryawan = async (req, res) => {
  try {
    const getKaryawan = await query(`SELECT * FROM karyawan `);
    return res.status(200).json({ success: true, data: getKaryawan });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

export const getKaryawanById = async (req, res) => {
  const { noEmp } = req.params;
  try {
    const getKaryawan = await query(`SELECT * FROM karyawan WHERE no_emp = ?`, [
      noEmp,
    ]);
    return res.status(200).json({ success: true, data: getKaryawan });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

export const updateKaryawan = async (req, res) => {
  const {
    nama,
    join_date,
    email,
    no_hp,
    transportasi,
    jumlah_keluarga,
    anak_bawah_umur,
    anak_diatas_umur,
    status_register,
    status_kedatangan,
    status_snack_anak,
    status_snack_dewasa,
    status_dinner,
    jam_dinner,
  } = req.body;
  const { noEmp } = req.params;
  try {
    await query(
      `UPDATE karyawan SET 
      nama = ?,
      join_date = ?,
      email = ?,
      no_hp = ?,
      transportasi = ?,
      jumlah_keluarga = ?,
      anak_bawah_umur = ?,
      anak_diatas_umur = ?,
      status_register = ?,
      status_kedatangan = ?,
      status_snack_anak = ?,
      status_snack_dewasa = ?,
      status_dinner = ?,
      jam_dinner = ?
      WHERE no_emp = ?`,
      [
        nama,
        join_date,
        email,
        no_hp,
        transportasi,
        jumlah_keluarga,
        anak_bawah_umur,
        anak_diatas_umur,
        status_register,
        status_kedatangan,
        status_snack_anak,
        status_snack_dewasa,
        status_dinner,
        jam_dinner,
        noEmp,
      ]
    );
    return res
      .status(200)
      .json({ success: true, message: "Data updated successfully." });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

export const uploadExcelKaryawan = async (req, res) => {
  let filePath = null;

  try {
    const uploadedFileObject = req.files?.file_excel?.[0];

    if (!uploadedFileObject) {
      return res.status(400).json({
        success: false,
        message:
          "Tidak ada file yang diunggah. Pastikan fieldname adalah 'file_excel'.",
      });
    }

    filePath = uploadedFileObject.path;

    const workbook = xlsx.readFile(filePath);
    const sheetName = workbook.SheetNames[0];
    const worksheet = workbook.Sheets[sheetName];

    const jsonData = xlsx.utils.sheet_to_json(worksheet, {
      header: 1,
      range: 1,
      defval: null,
    });

    const results = [];
    let successCount = 0;
    let failCount = 0;

    if (!jsonData || jsonData.length === 0) {
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
      return res.status(400).json({
        success: false,
        message: "File Excel kosong atau tidak ada data setelah header.",
      });
    }

    for (const row of jsonData) {
      if (!Array.isArray(row) || row.length < 1) {
        if (
          row &&
          Object.values(row).some((cell) => cell !== null && cell !== "")
        ) {
          failCount++;
          results.push({
            rowData: Array.isArray(row)
              ? row.slice(0, 3).join(", ")
              : "Format baris tidak valid",
            status: "failed",
            reason: "Baris tidak lengkap atau format tidak sesuai.",
          });
        }
        continue;
      }

      const no_emp_raw = row[0];
      const nama_raw = row[1];
      const join_date_raw = row[2];

      const no_emp = no_emp_raw ? String(no_emp_raw).trim() : null;
      const nama = nama_raw ? String(nama_raw).trim() : null;

      if (!no_emp || !nama) {
        failCount++;
        results.push({
          no_emp: no_emp || "KOSONG",
          nama: nama || "KOSONG",
          join_date_excel: join_date_raw,
          status: "failed",
          reason: "No. Karyawan atau Nama tidak boleh kosong pada baris ini.",
        });
        continue;
      }

      let formattedJoinDate = null;
      if (
        join_date_raw !== null &&
        join_date_raw !== undefined &&
        join_date_raw !== ""
      ) {
        let jsDate;
        if (typeof join_date_raw === "number") {
          const dateObj = xlsx.SSF.parse_date_code(join_date_raw);
          if (dateObj) {
            jsDate = new Date(
              Date.UTC(
                dateObj.y,
                dateObj.m - 1,
                dateObj.d,
                dateObj.H || 0,
                dateObj.M || 0,
                dateObj.S || 0
              )
            );
          }
        } else {
          jsDate = new Date(join_date_raw);
        }

        if (jsDate && !isNaN(jsDate.getTime())) {
          const year = jsDate.getUTCFullYear();
          const month = String(jsDate.getUTCMonth() + 1).padStart(2, "0");
          const day = String(jsDate.getUTCDate()).padStart(2, "0");
          formattedJoinDate = `${year}-${month}-${day}`;
        } else {
          failCount++;
          results.push({
            no_emp,
            nama,
            join_date_excel: join_date_raw,
            status: "failed",
            reason: `Format Tanggal Bergabung tidak valid: "${join_date_raw}"`,
          });
          continue;
        }
      }

      try {
        await query(
          "INSERT INTO karyawan (no_emp, nama, join_date) VALUES (?, ?, ?)",
          [no_emp, nama, formattedJoinDate]
        );
        successCount++;
        results.push({
          no_emp,
          nama,
          join_date: formattedJoinDate,
          status: "success",
        });
      } catch (dbError) {
        failCount++;
        let reason = dbError.message;
        if (
          dbError.code === "ER_DUP_ENTRY" ||
          dbError.message.toLowerCase().includes("duplicate entry")
        ) {
          reason = "No. Karyawan sudah ada di database.";
        } else if (
          dbError.message.toLowerCase().includes("cannot be null") &&
          !formattedJoinDate &&
          join_date_raw !== null &&
          join_date_raw !== ""
        ) {
          reason = `Format Tanggal Bergabung tidak valid (${join_date_raw}) dan kolom join_date di database tidak boleh kosong.`;
        }
        results.push({
          no_emp,
          nama,
          join_date_excel: join_date_raw,
          status: "failed",
          reason,
        });
      }
    }

    if (filePath && fs.existsSync(filePath)) {
      fs.unlinkSync(filePath);
    }

    return res.status(200).json({
      success: true,
      message: `Proses upload selesai. Berhasil: ${successCount} data, Gagal: ${failCount} data.`,
      summary: {
        totalRowsInExcel: jsonData.length,
        successfullyInserted: successCount,
        failedToInsert: failCount,
      },
      details: results,
    });
  } catch (error) {
    console.error("Error processing Excel file:", error);
    if (filePath && fs.existsSync(filePath)) {
      try {
        fs.unlinkSync(filePath);
        console.log("File temporary dihapus karena error:", filePath);
      } catch (e) {
        console.error("Error deleting temp file on failure:", e);
      }
    }
    return res.status(500).json({
      success: false,
      message: error.message || "Terjadi kesalahan saat memproses file Excel.",
    });
  }
};

export const deletedKaryawan = async (req, res) => {
  const { noEmp } = req.params;
  try {
    const deletedKaryawan = await query(
      `DELETE FROM karyawan WHERE no_emp = ?`,
      [noEmp]
    );
    return res
      .status(200)
      .json({ success: true, message: "Data Successfully Deleted 🎊" });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};
