import { IsNotEmpty, IsString } from "class-validator";

export enum ImageType{
    profilePic = 'profilePic',
    idPic = 'idPic',
    carPic = 'carPic',
}
export class ImageTypeDto{
    @IsNotEmpty()
    @IsString()
    imageType: ImageType
}
