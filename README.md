import { getRepository } from 'typeorm';
import { User } from '../entity/User';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

export class AuthService {
  async register(username: string, password: string, email: string, role: string) {
    const userRepository = getRepository(User);
    const existingUser = await userRepository.findOne({ where: { username } });

    if (existingUser) throw new Error('Username already exists');

    const hashedPassword = await bcrypt.hash(password, 10);
    const user = userRepository.create({ username, password: hashedPassword, email, role });
    await userRepository.save(user);

    return { message: 'User registered successfully' };
  }

  async login(username: string, password: string, secretKey: string) {
    const userRepository = getRepository(User);
    const user = await userRepository.findOne({ where: { username } });

    if (!user || !(await bcrypt.compare(password, user.password))) {
      throw new Error('Invalid credentials');
    }

    // Verify Secret Key
    if (secretKey !== process.env.SECRET_KEY) {
      throw new Error('Invalid Secret Key');
    }

    const token = jwt.sign({ userId: user.id, role: user.role }, process.env.JWT_SECRET!, { expiresIn: '1h' });
    return { token };
  }
}
