import {
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { Appointment, Role, User } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import {
  AppointmentDto,
  DeleteAppointmentDto,
  UpdateAppointmentDto,
} from './dto/appointment.dto';
import { timestamp } from 'rxjs';

@Injectable()
export class AppointmentService {
  constructor(private prisma: PrismaService) {}
  async getUserAppointments(user: User) {
    try {
      var appointments;
      console.log(user['roles'][0]);
      // console.log(Role.USER==user['roles'][0])
      if (user['roles'][0] == Role.USER) {
        appointments = await this.prisma.appointment.findMany({
          where: { customerId: user['sub'] },
        });
        console.log(appointments);
      } else {
        appointments = await this.prisma.appointment.findMany({
          where: { moverId: user['sub'] },
        });
      }
      var a = [];
      // for (var i = 0; i < appointments.lenght; i++) {
      //   a.push({
      //     Id: appointments[i].Id,
      //     moverId: appointments[i].moverId,
      //     destination: appointments[i].

      //   });
      // }
      //   needs to return appointment in a properly formatted way
      console.log(appointments);
      return { appointments };
    } catch (e) {
      return { message: 'No user by this id' };
    }
  }
  async getMoverNameById(moverId: number) {
    try {
      const mover = await this.prisma.mover.findFirst({
        where: { userId: moverId },
      });
      return { mover };
    } catch (e) {
      throw new HttpException('some exception', HttpStatus.BAD_REQUEST);
    }
  }

  async moverRejectAppointment(appointmentId: number, moverId: number) {
    try {
      const appointment = await this.prisma.appointment.findFirst({
        where: { Id: appointmentId },
      });
      if (appointment.moverId != moverId) {
        throw new HttpException('wrong mover', HttpStatus.FORBIDDEN);
      }
      return await this.prisma.appointment.update({
        where: { Id: appointment.Id },
        data: { status: -1 },
      });
    } catch (e) {
      return e;
    }
  }
  async getMoverAppointments(moverId: number) {
    try {
      console.log(moverId);
      // const user = await this.prisma.user.findUnique({
      //   where: { Id: moverId },
      // });
      // console.log(user);
      const appointments = await this.prisma.appointment.findMany({
        where: { moverId: moverId },
      });
      // var ret = []
      // for (var appointment of appointments){
      //   var user = await this.prisma.user.findUnique({
      //     where: {Id: appointment.customerId}
      //   });
      //   ret.push({
      //     customerFname: user.firstName,
      //     customerLname: user.lastName,
      //     customerPhoneNo: user.phoneNumber,
      //     bookDate: appointment.bookDate,
      //     status: appointment.status,
      //     startLocation: appointment.startLocation,
      //     Id: appointment.Id
      //   })
      // }
      console.log(appointments);
      return { appointments };
    } catch (e) {
      return { message: e };
    }
  }

  async addAppointment(customerId: number, dto: AppointmentDto) {
    console.log(dto.moverId);
    const user = await this.prisma.user.findFirst({
      where: { Id: customerId },
    });
    try {
      // console.log(`moverId ${dto.moverId}`);

      const mover = await this.prisma.mover.findFirst({
        // where: { Id: dto.moverId },
        where: { userId: dto.moverId },
      });
      console.log(`moverId ${mover.Id}`);
    } catch (e) {
      // return { message: 'No mover with these credentials' };
      throw new HttpException(
        { message: 'No mover with these credentials' },
        HttpStatus.BAD_REQUEST,
      );
    }
    try {
      const appointment = await this.prisma.appointment.create({
        data: {
          customerId: customerId,
          moverId: dto.moverId,
          setDate: new Date(dto.setDate),
          destination: dto.destination,
          startLocation: dto.startLocation,
        },
      });
      console.log(appointment);
      return { appointment };
    } catch (e) {
      console.log(e);
      // return { message: 'cannot create appointment' };
      throw new HttpException(
        { message: 'cant create appointment' },
        HttpStatus.BAD_REQUEST,
      );
    }
  }

  async deleteAppointment(dto: DeleteAppointmentDto, customerId: number) {
    try {
      const appointment = await this.prisma.appointment.findUnique({
        where: { Id: dto.appointmentId },
      });
      if (appointment == null) {
        throw new HttpException(
          { message: 'No such appointment' },
          HttpStatus.BAD_REQUEST,
        );
      }
      if (appointment.customerId != customerId) {
        throw new HttpException(
          { message: 'This appointment does not belong to this customer' },
          HttpStatus.BAD_REQUEST,
        );
      }
      await this.prisma.appointment.delete({
        where: { Id: dto.appointmentId },
      });
      return { message: 'success' };
    } catch (e) {
      console.log(e);
      throw new HttpException({ message: e }, HttpStatus.BAD_REQUEST);
    }
  }

  async updateAppointment(dto: UpdateAppointmentDto, customerId: number) {
    try {
      const appointment = await this.prisma.appointment.findFirst({
        where: { Id: dto.appointmentId },
      });
      if (appointment == null) {
        throw 'No appointment my this Id.';
      }
      // if (appointment.moverId != customerId) {
      //   console.log(appointment);
      //   console.log(customerId);

      //   throw 'This appointment does not belong to this customer.';
      // }
      if (appointment.status == -1) {
        throw 'Appointment already rejected. Nothing more can be done with it.';
      }
      if (appointment.status == 2 || appointment.status == 3) {
        throw 'Appointment already ended';
      }
      if (appointment.status > 0 && dto.status == -1) {
        throw "Can't reject an already accepted appointment";
      }

      // if (dto.status == -1){
      // mover has rejected the status. notify the user and delete appointment?
      // or just update the appointment to have status -1, so the user will see it and delete it
      // }

      const editedAppointment = await this.prisma.appointment.update({
        where: { Id: dto.appointmentId },
        data: {
          status: dto.status || undefined,
          // startTime: f ? new Date() : undefined,
        },
      });

      return { editedAppointment };
    } catch (e) {
      throw new HttpException(e, HttpStatus.BAD_REQUEST);
    }
  }
}
