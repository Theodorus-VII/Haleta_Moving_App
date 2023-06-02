import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { NotificationDto } from './dto/notification.dto';

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

      const notifications = await this.prisma.notification.findMany({
        where: { appointmentId: appointment.Id },
      });
      // return {
      //   message: 'success',
      //   data: notifications,
      // };
      var n = [];
      // for (var i = 0; i < notifications.length; i++) {
      //   var mover = await 
      //   n.push({ Id: notifications[i].Id,
      //   message: notifications[i].update,

      // });
      // }
      return {
        notifications,
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
      return { message: 'success', data: editedNotification };
    } catch (e) {
      return { message: e };
    }
  }

  async deleteNotification() {
    // need to decide when this can be done
  }
}
