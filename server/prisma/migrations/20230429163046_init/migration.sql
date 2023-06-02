-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "hash" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'customer',
    "userId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "customers" (
    "Id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "joinDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "movers" (
    "Id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "joinDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "appointments" (
    "appointmentId" SERIAL NOT NULL,
    "customerId" INTEGER NOT NULL,
    "moverId" INTEGER NOT NULL,
    "completionStatus" INTEGER NOT NULL DEFAULT 0,
    "date" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "notifications" (
    "notificationId" SERIAL NOT NULL,
    "customerId" INTEGER NOT NULL,
    "moverId" INTEGER NOT NULL,
    "update" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "users_id_key" ON "users"("id");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "customers_Id_key" ON "customers"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "customers_email_key" ON "customers"("email");

-- CreateIndex
CREATE UNIQUE INDEX "movers_Id_key" ON "movers"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "movers_email_key" ON "movers"("email");

-- CreateIndex
CREATE UNIQUE INDEX "appointments_appointmentId_key" ON "appointments"("appointmentId");

-- CreateIndex
CREATE UNIQUE INDEX "notifications_notificationId_key" ON "notifications"("notificationId");

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customers"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_moverId_fkey" FOREIGN KEY ("moverId") REFERENCES "movers"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customers"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_moverId_fkey" FOREIGN KEY ("moverId") REFERENCES "movers"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;
