import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  Put,
  UseGuards,
} from '@nestjs/common';
import { Role, User } from '@prisma/client';
import { GetUser } from 'src/auth/decorator';
import { AppointmentService } from './appointment.service';
import { AuthGuard } from 'src/auth/guard';
import { Roles } from 'src/auth/decorator/roles.decorator';
import { RolesGuard } from 'src/auth/guard/roles.guard';
import {
  AppointmentDto,
  DeleteAppointmentDto,
  UpdateAppointmentDto,
} from './dto/appointment.dto';

@Controller('appointments')
export class AppointmentController {
  constructor(private appointmentService: AppointmentService) {}

  @Roles(Role.USER, Role.MOVER)
  @UseGuards(RolesGuard)
  @Get('user')
  getUserAppointments(@GetUser() user: User) {
    // just returns any records of user appointments. specifics of functionality will be done during frontend if needed
    // can work for mover too ig, since he's also a user
    return this.appointmentService.getUserAppointments(user);
  } // - user can see when the date booked is.

  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  @Get('mover')
 async  getMoverAppointments(@GetUser('Id') moverId: number) {
    //for the mover to see his booked schedule

    // if the status of the appointment is -1, mover has rejected the request. the user should be able to see that and then delete the appointment
    return await this.appointmentService.getMoverAppointments(moverId);
  }

  @Roles(Role.USER)
  @UseGuards(RolesGuard)
  @Post('create')
  async userAddAppointment(
    @GetUser('Id') customerId: number,
    @Body() appointmentDto: AppointmentDto,
  ) {
    return await this.appointmentService.addAppointment(customerId, appointmentDto);
  } //making a new appointment. needs to cross check with the chosen mover's schedule first.

  @Patch()
  userUpdateAppointment(
    @Body() dto: UpdateAppointmentDto,
    @GetUser('Id') customerId: number,
  ) {
    return this.appointmentService.updateAppointment(dto, customerId);
  } //user changing schedule

  @Roles(Role.USER)
  @UseGuards(RolesGuard)
  @Delete()
  async userRemoveAppointment(
    @Body() dto: DeleteAppointmentDto,
    @GetUser('Id') customerId: number,
  ) {
    return await this.appointmentService.deleteAppointment(dto, customerId);
  } //deletion / cancellation from the user

  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  @Patch(':id')
  async moverRejectAppointment(
    @Param('id', ParseIntPipe) appointmentId: number,
    @GetUser('Id') moverId: number,
  ){
    return await this.appointmentService.moverRejectAppointment(appointmentId, moverId);
  }
}
