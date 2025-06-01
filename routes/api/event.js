import express from "express";
import { getDataPieChart, registerEvent } from "../../controllers/event.js";
import { sendEmail } from "../../middleware/nodemailer.js";

const router = express.Router();

router.post("/registerEvent/:noEmp", registerEvent, sendEmail);
router.get("/pieChart", getDataPieChart);

export default router;
