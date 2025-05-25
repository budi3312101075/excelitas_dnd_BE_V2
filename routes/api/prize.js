import express from "express";
import {
  deletedPrize,
  getPrize,
  updatePrize,
} from "../../controllers/prize.js";

const router = express.Router();

router.get("/prizes", getPrize);
router.patch("/prizes/:id", updatePrize);
router.delete("/prizes/:id", deletedPrize);

export default router;
