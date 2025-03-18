import { StudentRepository } from "../repositories/studentRepo";
import { Students2008 } from "../entity/student";
class StudentService {
    private studentRepo = new StudentRepository();

    async createStudent(studentData: Partial<Students2008>): Promise<Students2008> {
        return await this.studentRepo.createStudent(studentData);
    }

    async getAllStudents(): Promise<Students2008[]> {
        return await this.studentRepo.getAllStudents();
    }

    async getStudentById(id: number): Promise<Students2008 | null> {
        return await this.studentRepo.getStudentById(id);
    }

    async updateStudent(id: number, updatedData: Partial<Students2008>): Promise<Students2008 | null> {
        return await this.studentRepo.updateStudent(id, updatedData);
    }

    async deleteStudent(id: number): Promise<boolean> {
        return await this.studentRepo.deleteStudent(id);
    }
}

export { StudentService };
