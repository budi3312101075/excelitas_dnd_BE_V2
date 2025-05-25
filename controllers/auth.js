import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import { query } from "../utils/query.js";
import { uuid } from "../utils/tools.cjs";

export const login = async (req, res) => {
  const { username, password } = req.body;
  try {
    if (username === undefined || password === undefined) {
      return res.status(400).json("Invalid data!");
    }

    const cekUser = await query(
      `SELECT username, password FROM users WHERE username = ? AND is_deleted = 0`,
      [username]
    );

    if (cekUser.length === 0) {
      return res.status(400).json("Username tidak ditemukan!");
    }

    const isPasswordMatch = await bcrypt.compare(password, cekUser[0].password);
    if (!isPasswordMatch) {
      return res.status(400).json("Password Salah");
    }

    const user = await query(
      `SELECT id FROM users WHERE username = ? AND is_deleted = 0`,
      [username]
    );

    const payload = {
      idUser: user[0].id,
    };
    const token = jwt.sign(payload, process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: "1d",
    });
    const options = {
      httpOnly: true,
      maxAge: 3600000 * 1 * 24,
    };

    return res
      .status(200)
      .cookie("token", token, options)
      .json({ success: true, data: token });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

export const getMe = async (req, res) => {
  const { id } = req.user;
  try {
    const [getMe] = await query(
      `SELECT id, username FROM users 
      WHERE id = ?  AND is_deleted = ?`,
      [id, 0]
    );

    return res.status(200).json({ success: true, getMe });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

export const Logout = async (req, res) => {
  try {
    res
      .status(200)
      .clearCookie("token")
      .json({ success: true, msg: "Logout Berhasil!" });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

export const register = async (req, res) => {
  const { username, password } = req.body;
  try {
    if (
      username === undefined ||
      password === undefined ||
      username === "" ||
      password === ""
    ) {
      return res.status(400).json("Invalid data!");
    }

    const isUserExist = await query(
      `SELECT username FROM users WHERE username = ? AND is_deleted = 0`,
      [username]
    );

    if (isUserExist.length > 0) {
      return res.status(400).json("Username sudah digunakan!");
    } else {
      const salt = await bcrypt.genSalt();
      const hashedPassword = await bcrypt.hash(password, salt);

      await query(
        `INSERT INTO users
          (id, username, password, is_deleted) values 
          (?, ?, ?, ?)`,
        [uuid(), username, hashedPassword, 0]
      );

      return res.status(200).json({ message: "Berhasil register" });
    }
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};
