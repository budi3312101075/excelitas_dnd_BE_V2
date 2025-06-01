import express from "express";
import { scan } from "../../controllers/scan.js";

const router = express.Router();

router.patch("/scan/", scan);

export default router;
