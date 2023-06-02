/*
  Warnings:

  - You are about to drop the column `appointmentId` on the `appointments` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[Id]` on the table `appointments` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "appointments_appointmentId_key";

-- AlterTable
ALTER TABLE "appointments" DROP COLUMN "appointmentId",
ADD COLUMN     "Id" SERIAL NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "appointments_Id_key" ON "appointments"("Id");
