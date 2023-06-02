import { IsBoolean, IsNotEmpty, IsOptional, IsString } from "class-validator"

export class UserUpdateDto{
    @IsOptional()
    @IsString()
    email?: string

    @IsNotEmpty()
    @IsString()
    password?: string

    @IsOptional()
    @IsString()
    phoneNumber?: string

    @IsOptional()
    @IsString()
    firstName?: string

    @IsOptional()
    @IsString()
    lastName?: string = 'anywhere';
}


