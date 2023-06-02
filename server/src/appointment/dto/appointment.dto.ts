import { IsISO8601, IsNotEmpty, IsNumber, IsOptional, IsString } from "class-validator";

export class AppointmentDto{
    // to make an appointment. customerId is inferred from access token
    @IsNotEmpty()
    @IsNumber()
    moverId: number;

    @IsOptional()
    completionStatus?: number;

    @IsNotEmpty()
    @IsISO8601({
        strict: true,
      }) 
    setDate: string;

    @IsNotEmpty()
    @IsString()
    startLocation: string;

    @IsNotEmpty()
    @IsString()
    destination: string;
}

export class DeleteAppointmentDto{
    // to remove an appointment
    @IsNotEmpty()
    @IsNumber()
    appointmentId: number;
}


export class UpdateAppointmentDto{
    // to move an appointment to a different date
    @IsNotEmpty()
    @IsNumber()
    appointmentId: number;

    @IsOptional()
    @IsISO8601({
        strict: true,
      })
    @IsString()
    setDate: string;

    @IsOptional()
    @IsString()
    destination: string;

    @IsOptional()
    @IsNumber()
    status?: number
}

export class AppointmentStatusDto{}