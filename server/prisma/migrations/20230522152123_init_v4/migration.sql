/*
  Warnings:

  - You are about to drop the column `completionStatus` on the `appointments` table. All the data in the column will be lost.
  - Added the required column `destination` to the `appointments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `startLocation` to the `appointments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `startTime` to the `appointments` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "appointments" DROP COLUMN "completionStatus",
ADD COLUMN     "destination" TEXT NOT NULL,
ADD COLUMN     "startLocation" TEXT NOT NULL,
ADD COLUMN     "startTime" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "status" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "reviews" ALTER COLUMN "Review" DROP NOT NULL;

-- CreateTable
CREATE TABLE "movers" (
    "Id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "licenceNumber" TEXT NOT NULL,
    "profilePic" TEXT,
    "carPic" TEXT,
    "location" TEXT,
    "idPic" TEXT,
    "baseFee" TEXT NOT NULL,
    "Banned" BOOLEAN NOT NULL DEFAULT false
);

-- CreateIndex
CREATE UNIQUE INDEX "movers_Id_key" ON "movers"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "movers_userId_key" ON "movers"("userId");

-- AddForeignKey
ALTER TABLE "movers" ADD CONSTRAINT "movers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;
