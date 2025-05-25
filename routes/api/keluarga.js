import express from "express";
import {
  deletedKeluarga,
  getAllKeluarga,
  getKeluarga,
  updateKeluarga,
  uploadExcelKeluarga,
} from "../../controllers/keluarga.js";
import upload from "../../middleware/multer.js";

const router = express.Router();

router.post("/uploadKeluarga", upload, uploadExcelKeluarga);
router.get("/keluarga/:noEmp", getKeluarga);
router.get("/allKeluarga", getAllKeluarga);
router.patch("/keluarga/:id", updateKeluarga);
router.delete("/keluarga/:id", deletedKeluarga);

export default router;
