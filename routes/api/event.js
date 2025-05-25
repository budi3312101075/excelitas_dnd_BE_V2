import express from "express";
import { getDataPieChart, registerEvent } from "../../controllers/event.js";

const router = express.Router();

router.post("/registerEvent/:noEmp", registerEvent);
router.get("/pieChart", getDataPieChart);

export default router;
