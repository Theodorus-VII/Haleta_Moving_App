/*
  Warnings:

  - You are about to drop the column `customerId` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `moverId` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `notificationId` on the `notifications` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[Id]` on the table `notifications` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `updatedAt` to the `notifications` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "notifications" DROP CONSTRAINT "notifications_customerId_fkey";

-- DropForeignKey
ALTER TABLE "notifications" DROP CONSTRAINT "notifications_moverId_fkey";

-- DropIndex
DROP INDEX "notifications_notificationId_key";

-- AlterTable
ALTER TABLE "notifications" DROP COLUMN "customerId",
DROP COLUMN "moverId",
DROP COLUMN "notificationId",
ADD COLUMN     "Id" SERIAL NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "notifications_Id_key" ON "notifications"("Id");
