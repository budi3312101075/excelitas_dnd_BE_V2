import { query } from "../utils/query.js";
import { uuid } from "../utils/tools.cjs";
import xlsx from "xlsx";
import fs from "fs";

export const getKeluarga = async (req, res) => {
  const { noEmp } = req.params;
  try {
    const resultPasangan = await query(
      `SELECT nama FROM karyawan_keluarga WHERE no_emp = ? AND status_keluarga != ? `,
      [noEmp, "anak"]
    );

    const resultAnak = await query(
      `SELECT nama FROM karyawan_keluarga WHERE no_emp = ? AND status_keluarga = ?`,
      [noEmp, "anak"]
    );

    let pasanganData = null;

    if (resultPasangan && resultPasangan.length > 0) {
      pasanganData = {
        nama: resultPasangan[0].nama,
        usia: null,
        hadir: null,
      };
    } else {
      pasanganData = {
        nama: "",
        usia: null,
        hadir: false,
      };
    }

    const anakArray = resultAnak.map((anakFromDb, index) => {
      return {
        nama: anakFromDb.nama,
        usia: null,
        hadir: null,
      };
    });
    return res.status(200).json({
      data: {
        pasangan: pasanganData,
        anak: anakArray,
      },
    });
  } catch (error) {
    console.error("Error in getKeluarga:", error);
    return res.status(400).json({ message: error.message });
  }
};

export const getAllKeluarga = async (req, res) => {
  try {
    const data = await query(
      `SELECT kg.id_karyawan_keluarga AS id, 
      k.no_emp, k.nama as namaKaryawan, 
      kg.nama as namaKeluarga, kg.status_keluarga, 
      kg.umur, kg.status_register 
      FROM karyawan_keluarga kg 
      INNER JOIN karyawan k 
      ON kg.no_emp = k.no_emp`
    );
    return res.status(200).json({ success: true, data });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

export const updateKeluarga = async (req, res) => {
  const { id } = req.params;
  const { namaKeluarga, statusKeluarga, umur, statusRegister } = req.body;
  try {
    if (!id || !namaKeluarga || !statusKeluarga || !umur || !statusRegister) {
      return res.status(400).json({ message: "Invalid data!" });
    }

    await query(
      `UPDATE karyawan_keluarga SET 
      nama = ?,
      status_keluarga = ?,
      umur = ?,
      status_register = ?
      WHERE id_karyawan_keluarga = ?`,
      [namaKeluarga, statusKeluarga, umur, statusRegister, id]
    );
    return res
      .status(200)
      .json({ success: true, message: "Data Successfully Updated 🎊" });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

export const uploadExcelKeluarga = async (req, res) => {
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
      if (!Array.isArray(row) || row.length < 3) {
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
            reason:
              "Baris tidak lengkap (membutuhkan minimal 3 kolom: No. Emp, Nama, Status Keluarga).",
          });
        }
        continue;
      }

      const no_emp_raw = row[0];
      const nama_raw = row[1];
      const status_keluarga_raw = row[2];

      const no_emp = no_emp_raw ? String(no_emp_raw).trim() : null;
      const nama_anggota_keluarga = nama_raw ? String(nama_raw).trim() : null;
      const status_keluarga = status_keluarga_raw
        ? String(status_keluarga_raw).trim()
        : null;

      if (!no_emp || !nama_anggota_keluarga || !status_keluarga) {
        failCount++;
        results.push({
          no_emp: no_emp || "KOSONG",
          nama: nama_anggota_keluarga || "KOSONG",
          status_keluarga_excel: status_keluarga_raw || "KOSONG",
          status: "failed",
          reason:
            "No. Karyawan, Nama Anggota Keluarga, atau Status Keluarga tidak boleh kosong.",
        });
        continue;
      }

      try {
        const id_keluarga = uuid();
        await query(
          "INSERT INTO karyawan_keluarga (id_karyawan_keluarga, no_emp, nama, status_keluarga) VALUES (?, ?, ?, ?)",
          [id_keluarga, no_emp, nama_anggota_keluarga, status_keluarga]
        );
        successCount++;
        results.push({
          no_emp,
          nama: nama_anggota_keluarga,
          status_keluarga: status_keluarga,
          status: "success",
        });
      } catch (dbError) {
        failCount++;
        let reason = dbError.message;
        if (
          dbError.code === "ER_DUP_ENTRY" ||
          dbError.message.toLowerCase().includes("duplicate entry")
        ) {
          reason = `Data keluarga untuk No. Emp: ${no_emp} dengan nama: ${nama_anggota_keluarga} mungkin sudah ada atau ada data unik lain yang berkonflik.`;
        }
        results.push({
          no_emp,
          nama: nama_anggota_keluarga,
          status_keluarga_excel: status_keluarga_raw,
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
        totalRowsProcessed: jsonData.filter(
          (row) =>
            Array.isArray(row) &&
            row.length >= 1 &&
            Object.values(row).some((cell) => cell !== null && cell !== "")
        ).length,
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

export const deletedKeluarga = async (req, res) => {
  const { id } = req.params;
  try {
    await query(
      `DELETE FROM karyawan_keluarga WHERE id_karyawan_keluarga = ?`,
      [id]
    );
    return res
      .status(200)
      .json({ success: true, message: "Data Successfully Deleted 🎊" });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};
