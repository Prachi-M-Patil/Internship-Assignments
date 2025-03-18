import "reflect-metadata";
import { DataSource } from "typeorm";
import dotenv from "dotenv";
import { Students2008 } from "../entity/student";
dotenv.config();

export const AppDataSource = new DataSource({
    type: "mssql",  
    port: Number(process.env.DB_PORT) , 
    username: process.env.DB_USER, 
    password: process.env.DB_PASS, 
    host: process.env.DB_HOST,
    database: process.env.DB_NAME, 
    entities: [Students2008], 
    logging: true, 
    synchronize: true, 
    options: {
        trustServerCertificate: true,
    },
});
