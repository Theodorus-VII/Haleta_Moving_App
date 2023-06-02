import { IsOptional, IsString, IsBoolean, IsNotEmpty } from "class-validator"

export class MoverUpdateDto{
    @IsOptional()
    @IsString()
    email?: string

    @IsOptional()
    @IsString()
    password?: string

    @IsOptional()
    @IsString()
    name?: string

    @IsOptional()
    @IsString()
    phoneNumber?: string

    @IsOptional()
    @IsString()
    firstName?: string

    @IsOptional()
    @IsString()
    lastName?: string

    @IsOptional()
    @IsString()
    licenseNumber?: string;

    @IsOptional()
    @IsString()
    profilePic?: string;

    @IsOptional()
    @IsString()
    carPic?: string;

    @IsOptional()
    @IsString()
    location?: string;

    @IsOptional()
    @IsString()
    idPic?: string;

    @IsOptional()
    @IsString()
    baseFee?: string;

    @IsOptional()
    @IsBoolean()
    Banned?: boolean;

    @IsOptional()
    @IsBoolean()
    verified?: boolean;
}



