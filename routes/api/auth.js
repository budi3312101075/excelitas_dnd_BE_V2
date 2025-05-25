import express from "express";
import { getMe, login, Logout, register } from "../../controllers/auth.js";
import { privateRoutes } from "../../middleware/private.js";

const router = express.Router();

router.post("/login", login);
router.post("/register", register);
router.get("/getMe", privateRoutes, getMe);
router.get("/logout", Logout);

export default router;
