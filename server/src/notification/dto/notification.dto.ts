import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class NotificationDto {
  @IsNotEmpty()
  @IsNumber()
  appointmentId: number;
  // moverId: number;
  // customerId: number;
  @IsString()
  update: string = 'None';

  @IsNumber()
  @IsNotEmpty()
  stage: number;
}

export class DeleteNotificationDto {
  @IsNotEmpty()
  @IsNumber()
  appointmentId: number;

  @IsNumber()
  @IsNotEmpty()
  stage: number;
}
