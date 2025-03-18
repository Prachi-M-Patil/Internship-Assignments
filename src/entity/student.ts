import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class Students2008 {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: "varchar", length: 256 })
    name: string;

    @Column({ type: "int", nullable: true })
    age: number;
}
