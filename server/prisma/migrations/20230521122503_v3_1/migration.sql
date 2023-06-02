/*
  Warnings:

  - You are about to drop the `Review` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_customerId_fkey";

-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_moverId_fkey";

-- DropTable
DROP TABLE "Review";

-- CreateTable
CREATE TABLE "reviews" (
    "Id" SERIAL NOT NULL,
    "moverId" INTEGER NOT NULL,
    "customerId" INTEGER NOT NULL,
    "Rating" INTEGER NOT NULL DEFAULT 0,
    "Review" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "reviews_Id_key" ON "reviews"("Id");

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "users"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_moverId_fkey" FOREIGN KEY ("moverId") REFERENCES "users"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;
