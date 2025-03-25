export class AuthService {
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
