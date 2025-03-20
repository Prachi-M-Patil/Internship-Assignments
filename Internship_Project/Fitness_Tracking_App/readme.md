
### Day 1-2: Project Setup
1. **Initialize the Project**:
   - Set up a new Node.js project with TypeScript.
   - Install necessary dependencies: `express`, `typeorm`, `mysql`, `jsonwebtoken`, `bcrypt`, `cors`, `dotenv`, `ts-node`, `typescript`.

   ```bash
   mkdir fitness-tracker
   cd fitness-tracker
   npm init -y
   npm install express typeorm mysql jsonwebtoken bcrypt cors dotenv
   npm install --save-dev ts-node typescript @types/express @types/node
   ```

2. **Configure TypeScript**:
   - Create a `tsconfig.json` file for TypeScript configuration.

   ```json
   {
     "compilerOptions": {
       "target": "ES6",
       "module": "commonjs",
       "outDir": "./dist",
       "rootDir": "./src",
       "strict": true,
       "esModuleInterop": true,
       "skipLibCheck": true
     }
   }
   ```

3. **Set Up Express Server**:
   - Create a basic Express server in `src/index.ts`.

   ```typescript
   import express from 'express';
   import cors from 'cors';
   import dotenv from 'dotenv';

   dotenv.config();

   const app = express();
   app.use(cors());
   app.use(express.json());

   const PORT = process.env.PORT || 3000;
   app.listen(PORT, () => {
     console.log(`Server is running on port ${PORT}`);
   });
   ```

### Day 3-4: Database Setup
1. **Configure TypeORM**:
   - Create a `ormconfig.json` file for TypeORM configuration.

   ```json
   {
     "type": "mysql",
     "host": "localhost",
     "port": 3306,
     "username": "root",
     "password": "password",
     "database": "fitness_tracker",
     "entities": ["src/entity/*.ts"],
     "synchronize": true
   }
   ```

2. **Create Entities**:
   - Define entities for `User`, `Workout`, `Goal`, `Activity`, and `Nutrition`.

   ```typescript
   // src/entity/User.ts
   import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

   @Entity()
   export class User {
     @PrimaryGeneratedColumn()
     id: number;

     @Column()
     username: string;

     @Column()
     password: string;

     @Column()
     email: string;
   }
   ```

### Day 5-6: Authentication
1. **User Registration and Login**:
   - Implement JWT authentication for user registration and login.

   ```typescript
   // src/routes/auth.ts
   import express from 'express';
   import { getRepository } from 'typeorm';
   import { User } from '../entity/User';
   import bcrypt from 'bcrypt';
   import jwt from 'jsonwebtoken';

   const router = express.Router();

   router.post('/register', async (req, res) => {
     const { username, password, email } = req.body;
     const userRepository = getRepository(User);
     const hashedPassword = await bcrypt.hash(password, 10);
     const user = userRepository.create({ username, password: hashedPassword, email });
     await userRepository.save(user);
     res.status(201).send('User registered');
   });

   router.post('/login', async (req, res) => {
     const { username, password } = req.body;
     const userRepository = getRepository(User);
     const user = await userRepository.findOne({ where: { username } });
     if (!user || !(await bcrypt.compare(password, user.password))) {
       return res.status(401).send('Invalid credentials');
     }
     const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET!, { expiresIn: '1h' });
     res.json({ token });
   });

   export default router;
   ```

### Day 7-8: Core Features
1. **Workout Logging**:
   - Implement routes and controllers for logging workouts.

   ```typescript
   // src/entity/Workout.ts
   import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
   import { User } from './User';

   @Entity()
   export class Workout {
     @PrimaryGeneratedColumn()
     id: number;

     @Column()
     type: string;

     @Column()
     duration: number;

     @ManyToOne(() => User, user => user.workouts)
     user: User;
   }
   ```

2. **Goal Setting**:
   - Implement routes and controllers for setting and tracking fitness goals.

### Day 9-10: Additional Features
1. **Activity Tracking**:
   - Implement routes and controllers for tracking activities like running, cycling, and swimming.

2. **Nutrition Tracking**:
   - Implement routes and controllers for logging meals and tracking nutritional intake.

### Day 11: Social Features
1. **Connect with Friends**:
   - Implement routes and controllers for connecting with friends and sharing progress.

### Day 12: Testing and Deployment
1. **Testing**:
   - Write unit tests for your routes and controllers.
   - Ensure all features are working as expected.

2. **Deployment**:
   - Deploy your application to a cloud service like Heroku or AWS.

This plan should help you get your fitness tracking app up and running in 12 days. Good luck with your project! If you have any questions or need further assistance, feel free to ask.
