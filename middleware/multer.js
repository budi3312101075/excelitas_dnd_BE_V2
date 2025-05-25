import multer from "multer";
import { fileDirUpload } from "../utils/tools.cjs";

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, fileDirUpload());
  },
  filename: function (req, file, cb) {
    const validMimeTypes = [
      "application/pdf",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "application/vnd.ms-excel",
      "text/csv",
      "text/plain",
    ];

    if (!validMimeTypes.includes(file.mimetype)) {
      return cb(
        new Error("Invalid file type.  Excel, and CSV files are allowed."),
        false
      );
    }

    const uniqueSuffix = Date.now().toString();
    cb(null, `${uniqueSuffix}-${file.originalname}`);
  },
});

const upload = multer({ storage: storage }).fields([
  { name: "file_excel", maxCount: 1 }, // Untuk file Excel
]);

export default upload;
