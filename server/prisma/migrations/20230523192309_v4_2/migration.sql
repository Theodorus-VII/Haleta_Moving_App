/*
  Warnings:

  - A unique constraint covering the columns `[stage,appointmentId]` on the table `notifications` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `stage` to the `notifications` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "appointments" ADD COLUMN     "endTime" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "movers" ADD COLUMN     "verified" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "notifications" ADD COLUMN     "stage" INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "notifications_stage_appointmentId_key" ON "notifications"("stage", "appointmentId");
