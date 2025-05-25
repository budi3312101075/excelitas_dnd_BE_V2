import express from "express";
import { getPrize } from "../../controllers/prize.js";

const router = express.Router();

router.get("/prizes", getPrize);

export default router;
