"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("reflect-metadata");
const database_1 = require("./database/database");
const express_1 = __importDefault(require("express"));
const studentRoutes_1 = require("./routes/studentRoutes");
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const app = (0, express_1.default)();
const PORT = process.env.PORT || 3300;
app.use(express_1.default.json());
app.use("/api", studentRoutes_1.router);
database_1.AppDataSource.initialize()
    .then(() => {
    console.log("Database connected successfully!");
    app.listen(PORT, () => {
        console.log(`Server is running on port ${PORT}`);
    });
})
    .catch((error) => {
    console.error("Failed to connect to the database:", error);
});
