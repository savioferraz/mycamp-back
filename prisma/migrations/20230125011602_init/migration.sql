-- CreateEnum
CREATE TYPE "gendertype" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateEnum
CREATE TYPE "prizetype" AS ENUM ('GOLD', 'SILVER', 'BRONZE');

-- CreateEnum
CREATE TYPE "roletype" AS ENUM ('ATHLETE', 'OWNER', 'REFEREE');

-- CreateTable
CREATE TABLE "athleteInfo" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "martialArtId" INTEGER NOT NULL,
    "gradeId" INTEGER NOT NULL,
    "teamId" INTEGER NOT NULL,

    CONSTRAINT "athleteInfo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "id" SERIAL NOT NULL,
    "gradeId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "weight" TEXT NOT NULL,
    "gender" "gendertype" NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cities" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "stateId" INTEGER NOT NULL,

    CONSTRAINT "cities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "enrolments" (
    "id" SERIAL NOT NULL,
    "eventId" INTEGER NOT NULL,
    "athleteId" INTEGER NOT NULL,
    "categoryId" INTEGER NOT NULL,

    CONSTRAINT "enrolments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "events" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "logo" TEXT,
    "cityId" INTEGER NOT NULL,
    "martialArtId" INTEGER NOT NULL,
    "date" DATE NOT NULL,
    "local" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "ownerId" INTEGER NOT NULL,

    CONSTRAINT "events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "grades" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "martialArtsId" INTEGER NOT NULL,

    CONSTRAINT "grades_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "martialArts" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "martialArts_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "matchs" (
    "id" SERIAL NOT NULL,
    "eventId" INTEGER NOT NULL,
    "firstFighter" INTEGER NOT NULL,
    "secondFighter" INTEGER NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "refereeId" INTEGER NOT NULL,
    "time" TIME(6),
    "mat" TEXT,

    CONSTRAINT "matchs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "personalInfo" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "cpf" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "birthday" DATE NOT NULL,
    "gender" "gendertype" NOT NULL,
    "role" "roletype" NOT NULL,

    CONSTRAINT "personalInfo_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prizes" (
    "id" SERIAL NOT NULL,
    "athleteId" INTEGER NOT NULL,
    "eventId" INTEGER NOT NULL,
    "prize" "prizetype" NOT NULL,

    CONSTRAINT "prizes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "referees" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "referee_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "results" (
    "id" SERIAL NOT NULL,
    "matchId" INTEGER NOT NULL,
    "winner" TEXT,
    "result" TEXT NOT NULL,
    "time" TIME(6),
    "description" TEXT,

    CONSTRAINT "results_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "token" TEXT NOT NULL,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "states" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "states_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "teams" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "martialArtsId" INTEGER NOT NULL,

    CONSTRAINT "teams_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "grades_name_key" ON "grades"("name");

-- CreateIndex
CREATE UNIQUE INDEX "martialArts_name_key" ON "martialArts"("name");

-- CreateIndex
CREATE UNIQUE INDEX "matchs_firstFighter_key" ON "matchs"("firstFighter");

-- CreateIndex
CREATE UNIQUE INDEX "matchs_secondFighter_key" ON "matchs"("secondFighter");

-- CreateIndex
CREATE UNIQUE INDEX "personalInfo_cpf_key" ON "personalInfo"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "referee_name_key" ON "referees"("name");

-- CreateIndex
CREATE UNIQUE INDEX "teams_name_key" ON "teams"("name");

-- AddForeignKey
ALTER TABLE "athleteInfo" ADD CONSTRAINT "athleteInfo_gradeId_fkey" FOREIGN KEY ("gradeId") REFERENCES "grades"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "athleteInfo" ADD CONSTRAINT "athleteInfo_martialArtId_fkey" FOREIGN KEY ("martialArtId") REFERENCES "martialArts"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "athleteInfo" ADD CONSTRAINT "athleteInfo_personalInfo_fkey" FOREIGN KEY ("userId") REFERENCES "personalInfo"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "athleteInfo" ADD CONSTRAINT "athleteInfo_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "categories" ADD CONSTRAINT "categories_gradeId_fkey" FOREIGN KEY ("gradeId") REFERENCES "grades"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "cities" ADD CONSTRAINT "cities_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "states"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enrolments" ADD CONSTRAINT "enrolments_athleteId_fkey" FOREIGN KEY ("athleteId") REFERENCES "athleteInfo"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enrolments" ADD CONSTRAINT "enrolments_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categories"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enrolments" ADD CONSTRAINT "enrolments_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "events"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "cities"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_martialArtId_fkey" FOREIGN KEY ("martialArtId") REFERENCES "martialArts"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_personalInfo_fkey" FOREIGN KEY ("ownerId") REFERENCES "personalInfo"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "grades" ADD CONSTRAINT "grades_martialArtsId_fkey" FOREIGN KEY ("martialArtsId") REFERENCES "martialArts"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matchs" ADD CONSTRAINT "matchs_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categories"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matchs" ADD CONSTRAINT "matchs_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "events"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matchs" ADD CONSTRAINT "matchs_firstFighter_fkey" FOREIGN KEY ("firstFighter") REFERENCES "enrolments"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matchs" ADD CONSTRAINT "matchs_refereeId_fkey" FOREIGN KEY ("refereeId") REFERENCES "referees"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matchs" ADD CONSTRAINT "matchs_secondFighter_fkey" FOREIGN KEY ("secondFighter") REFERENCES "enrolments"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "personalInfo" ADD CONSTRAINT "personalInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "prizes" ADD CONSTRAINT "prizes_athleteId_fkey" FOREIGN KEY ("athleteId") REFERENCES "athleteInfo"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "prizes" ADD CONSTRAINT "prizes_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "events"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "results" ADD CONSTRAINT "results_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES "matchs"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "teams" ADD CONSTRAINT "teams_martialArtsId_fkey" FOREIGN KEY ("martialArtsId") REFERENCES "martialArts"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
