import {
  Controller,
  Get,
  Post,
  Delete,
  Patch,
  Param,
  ParseIntPipe,
  UseGuards,
  Body,
} from '@nestjs/common';
import { DeleteNotificationDto, NotificationDto } from './dto/notification.dto';
import { RolesGuard } from 'src/auth/guard/roles.guard';
import { Role } from '@prisma/client';
import { GetUser, Roles } from 'src/auth/decorator';
import { NotificationService } from './notification.service';

@Controller('notification')
export class NotificationController {
  constructor(private notificationService: NotificationService) {}
  @Get(':id')
  @Roles(Role.MOVER, Role.USER)
  @UseGuards(RolesGuard)
  async getNotifications(
    @GetUser('Id') userId: number,
    @Param('id', ParseIntPipe) appointmentId: number,
  ) {
    // status history of the current delivery. everytime the mover sends an update
    // it gets saved and this will return the entire history(basically a log)
    return await this.notificationService.getAppointmentNotifications(
        userId,
      appointmentId,
    );
  }

  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  @Post()
  async postNotification(
    @GetUser('Id') moverId: number,
    @Body() dto: NotificationDto,
  ) {
    console.log(moverId);
    console.log("creating notification");
    // when the mover completes a certain stage of the delivery, sends it here
    return await this.notificationService.postNotification(moverId, dto);
  }

  @Patch()
  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  async patchNotification(
    @GetUser('Id') moverId: number,
    @Body() dto: NotificationDto,
  ) {
    console.log("patching notification");
    console.log(dto.stage);
    // should be for updating these.
    return await this.notificationService.patchNotification(moverId, dto);
  }

  @Delete()
  async deleteNotification( @Body() dto: DeleteNotificationDto) {
  // not sure if deletion should even be allowed.
  return await this.notificationService.deleteNotification(dto);
  }
}
