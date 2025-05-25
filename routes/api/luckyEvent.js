import express from "express";
import {
  getWinners,
  performLuckyDipDraw,
  performStandardDraw,
} from "../../controllers/luckyEvent.js";

const router = express.Router();

router.get("/winners/", getWinners);
router.post("/draw/luckydip", performLuckyDipDraw);
router.post("/draw/standard", performStandardDraw);

export default router;
