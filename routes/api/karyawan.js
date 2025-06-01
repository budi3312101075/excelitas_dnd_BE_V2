import express from "express";
import {
  deletedKaryawan,
  getKaryawan,
  getKaryawanById,
  updateKaryawan,
  uploadExcelKaryawan,
} from "../../controllers/karyawan.js";
import upload from "../../middleware/multer.js";

const router = express.Router();

router.get("/karyawan", getKaryawan);
router.get("/karyawan/:noEmp", getKaryawanById);
router.post("/uploadKaryawan", upload, uploadExcelKaryawan);
router.patch("/karyawan/:noEmp", updateKaryawan);
router.delete("/karyawan/:noEmp", deletedKaryawan);

export default router;
