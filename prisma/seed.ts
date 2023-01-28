import { PrismaClient } from "@prisma/client";
import { faker } from "@faker-js/faker";

const prisma = new PrismaClient();

async function clearDb() {
  await prisma.$queryRaw`DELETE FROM "athleteInfo";`;
  await prisma.$queryRaw`TRUNCATE "athleteInfo" RESTART IDENTITY CASCADE;`;

  await prisma.$queryRaw`DELETE FROM "personalInfo";`;
  await prisma.$queryRaw`TRUNCATE "personalInfo" RESTART IDENTITY CASCADE;`;

  await prisma.$queryRaw`DELETE FROM "users";`;
  await prisma.$queryRaw`TRUNCATE "users" RESTART IDENTITY CASCADE;`;
}

async function populateUsers() {
  for (let i = 0; i < 30; i++) {
    await prisma.users.create({
      data: {
        email: faker.internet.email(),
        password: faker.internet.password(),
      },
    });
  }
}

async function populatePersonalInfo() {
  const users = await prisma.users.findMany();

  for (let i = 0; i < users.length; i++) {
    const user = users[i];

    await prisma.personalInfo.create({
      data: {
        userId: user.id,
        cpf: faker.datatype.number(),
        firstName: faker.name.firstName(),
        lastName: faker.name.lastName(),
        birthday: faker.date.birthdate(),
        gender: faker.helpers.arrayElement(["MALE", "FEMALE"]),
        role: faker.helpers.arrayElement(["ATHLETE", "OWNER"]),
      },
    });
  }
}

async function populateAthleteInfo() {
  const athletes = await prisma.personalInfo.findMany({ where: { role: "ATHLETE" } });

  for (let i = 0; i < athletes.length; i++) {
    const athlete = athletes[i];

    await prisma.athleteInfo.create({
      data: {
        userId: athlete.id,
        gradeId: 1,
        teamId: faker.datatype.number({ min: 1, max: 2 }),
      },
    });
  }
}

async function seed() {
  await clearDb();
  await populateUsers();
  await populatePersonalInfo();
  await populateAthleteInfo();
}

seed()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
