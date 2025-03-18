import { Request, Response } from "express";
import { StudentService } from "../services/studentService";

class StudentController {
    private studentService = new StudentService();

    // Create a new student
    async createStudent(req: Request, res: Response): Promise<void> {
        try {
            const student = await this.studentService.createStudent(req.body);
            res.status(201).json(student);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // Get all students
    async getAllStudents(req: Request, res: Response): Promise<void> {
        try {
            const students = await this.studentService.getAllStudents();
            res.status(200).json(students);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // Get a student by ID
    async getStudentById(req: Request, res: Response): Promise<void> {
        try {
            const id = Number(req.params.id);
            const student = await this.studentService.getStudentById(id);

            if (!student) {
                res.status(404).json({ message: "Student not found" });
            } else {
                res.status(200).json(student);
            }
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // Update student details
    async updateStudent(req: Request, res: Response): Promise<void> {
        try {
            const id = Number(req.params.id);
            const updatedStudent = await this.studentService.updateStudent(id, req.body);

            if (!updatedStudent) {
                res.status(404).json({ message: "Student not found" });
            } else {
                res.status(200).json(updatedStudent);
            }
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // Delete a student
    async deleteStudent(req: Request, res: Response): Promise<void> {
        try {
            const id = Number(req.params.id);
            const isDeleted = await this.studentService.deleteStudent(id);

            if (!isDeleted) {
                res.status(404).json({ message: "Student not found" });
            } else {
                res.status(200).json({ message: "Student deleted successfully" });
            }
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}

export { StudentController };
