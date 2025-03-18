import { Router } from "express";
import { StudentController } from "../controllers/studentController";
const router = Router();
const studentController = new StudentController();

// Map routes to controller methods
router.post("/students", studentController.createStudent);
router.get("/students", studentController.getAllStudents);
router.get("/students/:id", studentController.getStudentById);
router.put("/students/:id", studentController.updateStudent);
router.delete("/students/:id", studentController.deleteStudent);

export { router };
