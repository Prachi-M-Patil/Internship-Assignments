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
exports.StudentRepository = void 0;
const database_1 = require("../database/database");
const student_1 = require("../entity/student");
class StudentRepository {
    createStudent(studentData) {
        return __awaiter(this, void 0, void 0, function* () {
            const studentRepo = database_1.AppDataSource.getRepository(student_1.Students2008);
            const newStudent = studentRepo.create(studentData);
            return yield studentRepo.save(newStudent);
        });
    }
    getAllStudents() {
        return __awaiter(this, void 0, void 0, function* () {
            const studentRepo = database_1.AppDataSource.getRepository(student_1.Students2008);
            return yield studentRepo.find();
        });
    }
    getStudentById(id) {
        return __awaiter(this, void 0, void 0, function* () {
            const studentRepo = database_1.AppDataSource.getRepository(student_1.Students2008);
            return yield studentRepo.findOneBy({ id });
        });
    }
    updateStudent(id, updatedData) {
        return __awaiter(this, void 0, void 0, function* () {
            const studentRepo = database_1.AppDataSource.getRepository(student_1.Students2008);
            const student = yield studentRepo.findOneBy({ id });
            if (!student) {
                return null;
            }
            Object.assign(student, updatedData);
            return yield studentRepo.save(student);
        });
    }
    deleteStudent(id) {
        return __awaiter(this, void 0, void 0, function* () {
            const studentRepo = database_1.AppDataSource.getRepository(student_1.Students2008);
            const result = yield studentRepo.delete(id);
            return result.affected !== 0;
        });
    }
}
exports.StudentRepository = StudentRepository;
