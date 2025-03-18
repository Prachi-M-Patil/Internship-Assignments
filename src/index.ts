import "reflect-metadata"; 
import { AppDataSource } from "./database/database"; 
import express from "express"; 
import { router as studentRouter } from "./routes/studentRoutes"; 
import dotenv from "dotenv";

dotenv.config(); 

const app = express();
const PORT = process.env.PORT || 3300;

app.use(express.json());

app.use("/api", studentRouter);

AppDataSource.initialize()
    .then(() => {
        console.log("Database connected successfully!");
        app.listen(PORT, () => {
            console.log(`Server is running on port ${PORT}`);
        });
    })
    .catch((error) => {
        console.error("Failed to connect to the database:", error);
    });
