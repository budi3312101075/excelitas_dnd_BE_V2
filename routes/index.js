import express from "express";
import auth from "./api/auth.js";
import event from "./api/event.js";
import keluarga from "./api/keluarga.js";
import karyawan from "./api/karyawan.js";
import luckyEvent from "./api/luckyEvent.js";
import prize from "./api/prize.js";
import scan from "./api/scan.js";

const app = express();

const api = "/api/v1";

app.use(api, auth);
app.use(api, event);
app.use(api, keluarga);
app.use(api, karyawan);
app.use(api, luckyEvent);
app.use(api, prize);
app.use(api, scan);

export default app;
