import express from "express";
import {
  deletedKaryawan,
  getKaryawan,
  updateKaryawan,
  uploadExcelKaryawan,
} from "../../controllers/karyawan.js";
import upload from "../../middleware/multer.js";

const router = express.Router();

router.post("/uploadKaryawan", upload, uploadExcelKaryawan);
router.get("/karyawan", getKaryawan);
router.patch("/karyawan/:noEmp", updateKaryawan);
router.delete("/karyawan/:noEmp", deletedKaryawan);

export default router;
