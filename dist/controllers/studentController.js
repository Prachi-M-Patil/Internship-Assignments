"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.StudentController = void 0;
const studentService_1 = require("../services/studentService");
class StudentController {
    constructor() {
        this.studentService = new studentService_1.StudentService();
    }
    // Create a new student
    createStudent(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const student = yield this.studentService.createStudent(req.body);
                res.status(201).json(student);
            }
            catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
    }
    // Get all students
    getAllStudents(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const students = yield this.studentService.getAllStudents();
                res.status(200).json(students);
            }
            catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
    }
    // Get a student by ID
    getStudentById(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const id = Number(req.params.id);
                const student = yield this.studentService.getStudentById(id);
                if (!student) {
                    res.status(404).json({ message: "Student not found" });
                }
                else {
                    res.status(200).json(student);
                }
            }
            catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
    }
    // Update student details
    updateStudent(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const id = Number(req.params.id);
                const updatedStudent = yield this.studentService.updateStudent(id, req.body);
                if (!updatedStudent) {
                    res.status(404).json({ message: "Student not found" });
                }
                else {
                    res.status(200).json(updatedStudent);
                }
            }
            catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
    }
    // Delete a student
    deleteStudent(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const id = Number(req.params.id);
                const isDeleted = yield this.studentService.deleteStudent(id);
                if (!isDeleted) {
                    res.status(404).json({ message: "Student not found" });
                }
                else {
                    res.status(200).json({ message: "Student deleted successfully" });
                }
            }
            catch (error) {
                res.status(500).json({ error: error.message });
            }
        });
    }
}
exports.StudentController = StudentController;
