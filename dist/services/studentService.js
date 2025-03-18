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
exports.StudentService = void 0;
const studentRepo_1 = require("../repositories/studentRepo");
class StudentService {
    constructor() {
        this.studentRepo = new studentRepo_1.StudentRepository();
    }
    createStudent(studentData) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.studentRepo.createStudent(studentData);
        });
    }
    getAllStudents() {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.studentRepo.getAllStudents();
        });
    }
    getStudentById(id) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.studentRepo.getStudentById(id);
        });
    }
    updateStudent(id, updatedData) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.studentRepo.updateStudent(id, updatedData);
        });
    }
    deleteStudent(id) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.studentRepo.deleteStudent(id);
        });
    }
}
exports.StudentService = StudentService;
