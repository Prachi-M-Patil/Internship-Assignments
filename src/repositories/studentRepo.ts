import { AppDataSource } from "../database/database";
import { Students2008 } from "../entity/student";
class StudentRepository {
    async createStudent(studentData: Partial<Students2008>): Promise<Students2008> {
        const studentRepo = AppDataSource.getRepository(Students2008);
        const newStudent = studentRepo.create(studentData);
        return await studentRepo.save(newStudent);
    }

    async getAllStudents(): Promise<Students2008[]> {
        const studentRepo = AppDataSource.getRepository(Students2008);
        return await studentRepo.find();
    }

    async getStudentById(id: number): Promise<Students2008 | null> {
        const studentRepo = AppDataSource.getRepository(Students2008);
        return await studentRepo.findOneBy({ id });
    }

    async updateStudent(id: number, updatedData: Partial<Students2008>): Promise<Students2008 | null> {
        const studentRepo = AppDataSource.getRepository(Students2008);
        const student = await studentRepo.findOneBy({ id });
        if (!student) {
            return null;
        }

        Object.assign(student, updatedData);
        return await studentRepo.save(student);
    }

    async deleteStudent(id: number): Promise<boolean> {
        const studentRepo = AppDataSource.getRepository(Students2008);
        const result = await studentRepo.delete(id);
        return result.affected !== 0;
    }
}

export { StudentRepository };
