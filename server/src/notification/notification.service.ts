import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { DeleteNotificationDto, NotificationDto } from './dto/notification.dto';

@Injectable()
export class NotificationService {
  constructor(private prisma: PrismaService) {}

  async getAppointmentNotifications(userId: number, appointmentId: number) {
    // returns the status update history for the (appointment)

    try {
      const appointment = await this.prisma.appointment.findFirst({
        where: { Id: appointmentId },
      });

      if (appointment == null) {
        throw 'Appointment Not found';
      }

      if (userId != appointment.customerId && userId != appointment.moverId) {
        throw 'Not your appointment';
      }

      var notifications = await this.prisma.notification.findMany({
        where: { appointmentId: appointment.Id },
      });
      notifications.sort((a,b) => (a.stage - b.stage))
      console.log(notifications);
      return {
        notification: notifications,
      };
    } catch (e) {
      return {
        message: e,
      };
    }
  }

  async postNotification(moverId: number, dto: NotificationDto) {
    try {
      console.log('Here');
      const appointment = await this.prisma.appointment.findFirst({
        where: { Id: dto.appointmentId },
      });

      if (appointment == null) {
        throw 'Appointment Not found';
      }
      if (appointment.moverId != moverId) {
        throw 'This appointment does not belong to this user';
      }
      const notification = await this.prisma.notification.create({
        data: {
          update: dto.update,
          appointmentId: dto.appointmentId,
          stage: dto.stage,
        },
      });

      if (dto.stage == 3){
        // appointment also complete
        const appointment = await this.prisma.appointment.update({where: {Id: dto.appointmentId}, data: {status: 2}});
        console.log(appointment);

      }
      return { message: 'success' };
    } catch (e) {
      return {
        message: e,
      };
    }
  }

  async patchNotification(moverId: number, dto: NotificationDto) {
    try {
      const appointment = await this.prisma.appointment.findFirst({
        where: { Id: dto.appointmentId },
      });

      if (appointment == null) {
        throw 'Appointment Not found';
      }

      if (appointment.moverId != moverId) {
        throw 'This appointment does not belong to this user';
      }

      if (appointment.status >= 2) {
        throw 'cant edit whats completed';
      }
      const notification = await this.prisma.notification.findUnique({
        where: {
          stageIdentifier: {
            stage: dto.stage,
            appointmentId: dto.appointmentId,
          },
        },
      });
      const editedNotification = await this.prisma.notification.update({
        where: {
          stageIdentifier: {
            stage: dto.stage,
            appointmentId: dto.appointmentId,
          },
        },
        data: { update: `${notification.update} *${dto.update} ` },
      });
      if (dto.stage == 3){
        // appointment also complete
        const appointment = await this.prisma.appointment.update({where: {Id: dto.appointmentId}, data: {status: 2}});
        console.log(appointment);
      }
      
      return { message: 'success', data: editedNotification };
    } catch (e) {
      console.log(e);
      return { message: e };
    }
  }

  async deleteNotification(dto: DeleteNotificationDto) {
    // need to decide when this can be done
    console.log("deleting notification");
    try{
      const notification = await this.prisma.notification.delete({where: {stageIdentifier: {stage: dto.stage, appointmentId: dto.appointmentId} }});
      return {message: "success"};
    } catch (e){
      throw new HttpException(
        { message: e },
        HttpStatus.BAD_REQUEST,
      );
    }
  }
}
