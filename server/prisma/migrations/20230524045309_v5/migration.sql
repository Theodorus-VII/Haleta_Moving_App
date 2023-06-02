-- DropIndex
DROP INDEX "notifications_stage_appointmentId_key";

-- AlterTable
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_pkey" PRIMARY KEY ("stage", "appointmentId");
