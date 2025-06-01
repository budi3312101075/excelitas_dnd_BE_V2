import { query } from "../utils/query.js";
import dayjs from "dayjs";

export const scan = async (req, res) => {
  const { type, noEmp } = req.query;
  try {
    if (type === "scanKedatangan") {
      const validateRegister = await query(
        `SELECT status_register, status_kedatangan FROM karyawan WHERE no_emp = ?`,
        [noEmp]
      );

      if (validateRegister[0]?.status_kedatangan === 1) {
        return res.status(400).json({
          success: false,
          message: "Karyawan sudah melakukan scan kedatangan",
        });
      }

      if (validateRegister[0]?.status_register === 1) {
        await query(
          `UPDATE karyawan SET status_kedatangan = ?, status_snack_anak = ? WHERE no_emp = ?`,
          [1, 1, noEmp]
        );
        return res
          .status(200)
          .json({ success: true, message: "Scan Kedatangan Berhasil" });
      }

      return res.status(400).json({
        success: false,
        message: "Karyawan belum melakukan registrasi",
      });
    } else if (type === "scanSnackDewasa") {
      const validateKedatangan = await query(
        `SELECT status_kedatangan, status_snack_dewasa FROM karyawan WHERE no_emp = ?`,
        [noEmp]
      );

      if (validateKedatangan[0]?.status_snack_dewasa === 1) {
        return res.status(400).json({
          success: false,
          message: "Karyawan sudah melakukan scan snack dewasa",
        });
      }

      if (validateKedatangan[0]?.status_kedatangan === 1) {
        await query(
          `UPDATE karyawan SET status_snack_dewasa = ? WHERE no_emp = ?`,
          [1, noEmp]
        );
        return res
          .status(200)
          .json({ success: true, message: "Scan Snack Dewasa Berhasil" });
      }

      return res.status(400).json({
        success: false,
        message: "Karyawan belum melakukan scan kedatangan",
      });
    } else if (type === "scanDinner") {
      const validateKedatangan = await query(
        `SELECT status_kedatangan, status_dinner FROM karyawan WHERE no_emp = ?`,
        [noEmp]
      );

      if (validateKedatangan[0]?.status_dinner === 1) {
        return res.status(400).json({
          success: false,
          message: "Karyawan sudah melakukan scan dinner",
        });
      }

      if (validateKedatangan[0]?.status_kedatangan === 1) {
        await query(`UPDATE karyawan SET status_dinner = ? WHERE no_emp = ?`, [
          1,
          noEmp,
        ]);
        return res
          .status(200)
          .json({ success: true, message: "Scan Dinner Berhasil" });
      }

      return res.status(400).json({
        success: false,
        message: "Karyawan belum melakukan scan kedatangan",
      });
    } else {
      return res.status(400).json({ success: false, message: "Invalid type" });
    }
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};
