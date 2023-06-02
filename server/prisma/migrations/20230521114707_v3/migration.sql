/*
  Warnings:

  - Added the required column `appointmentId` to the `notifications` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "notifications" ADD COLUMN     "appointmentId" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "Review" (
    "Id" SERIAL NOT NULL,
    "moverId" INTEGER NOT NULL,
    "customerId" INTEGER NOT NULL,
    "Rating" INTEGER NOT NULL DEFAULT 0,
    "Review" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Review_Id_key" ON "Review"("Id");

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES "appointments"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "users"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_moverId_fkey" FOREIGN KEY ("moverId") REFERENCES "users"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;
