import { IsBoolean, IsEmail, IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';
// import { Role } from '../Roles/roles.enum';
import { Role } from '@prisma/client';

export class AuthDto {
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsNotEmpty()
  password: string;

  @IsString()
  @IsNotEmpty()
  role: Role = Role.USER;
}


export class UserDto extends AuthDto{
    @IsString()
    @IsNotEmpty()
    username: string;

    @IsString()
    @IsNotEmpty()
    firstName: string;

    @IsString()
    @IsNotEmpty()
    lastName: string;

    @IsString()
    @IsNotEmpty()
    phoneNumber: string;

    @IsOptional()
    @IsString()
    location: string;
}

export class MoverDto extends UserDto{
  @IsNotEmpty()
  @IsString()
  licenceNumber: string;

  @IsOptional()
  @IsString()
  profilePic: string;

  @IsOptional()
  @IsString()
  carPic: string;

  @IsOptional()
  @IsString()
  location: string = 'Anywhere';

  @IsOptional()
  @IsString()
  idPic: string;

  @IsNotEmpty()
  @IsString()
  baseFee: string;
}

export class BanMoverDto{
  @IsNotEmpty()
  @IsBoolean()
  Banned: boolean;

  @IsNotEmpty()
  @IsNumber()
  moverId: number;
}