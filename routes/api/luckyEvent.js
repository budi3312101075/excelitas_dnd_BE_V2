import express from "express";
import {
  performLuckyDipDraw,
  performStandardDraw,
} from "../../controllers/luckyEvent.js";

const router = express.Router();

router.post("/draw/luckydip", performLuckyDipDraw);
router.post("/draw/standard", performStandardDraw);

export default router;
