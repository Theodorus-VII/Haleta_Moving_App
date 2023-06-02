import {
  Body,
  Controller,
  Delete,
  Get,
  ParseIntPipe,
  Patch,
  Post,
  Request,
  // UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import {
  Param,
  Res,
  UploadedFile,
} from '@nestjs/common/decorators/http/route-params.decorator';
import { Role, User } from '@prisma/client';
import { GetUser, Public } from 'src/auth/decorator';
import { Roles } from 'src/auth/decorator/roles.decorator';
import { RolesGuard } from 'src/auth/guard/roles.guard';
import { MoverService } from './mover.service';
import { MoverUpdateDto } from 'src/mover/dto/mover.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import { join } from 'path';
import { storage } from './storage/mover.storage';
import { of } from 'rxjs';
import { ImageType, ImageTypeDto } from './dto';

@Controller('movers')
export class MoverController {
  constructor(private moverService: MoverService) {}

  //   post(signup) in auth
  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  @Patch()
  updateMover(@GetUser('Id') userId: number, @Body() dto: MoverUpdateDto) {
    // account update
    return this.moverService.updateMover(userId, dto);
  }
  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  @Get('me')
  getMover(@GetUser('Id') moverId: number) {
    //Returns the users information
    return this.moverService.getMover(moverId);
  }
  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  @Delete('me')
  deleteMover(@GetUser('Id') userId: number) {
    return this.moverService.deleteAccount((userId = userId));
  }
  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  @Post('image')
  @UseInterceptors(FileInterceptor('file', storage))
  async uploadImage(
    @UploadedFile() file: Express.Multer.File,
    @GetUser('Id') userId: number,
    @Body() dto: ImageTypeDto,
  ) {
    // console.log("Sth")
    const fname = file.filename;
    return this.moverService.uploadImage(file, userId, dto);
  }

  @Public()
  @Get('/images/profile/:moverId')
  async getProfileImage(@Param('moverId') moverId: number, @Res() res) {
    // to send images to the client
    console.log("moverId${moverId}");
    const imageType = 'profilePic';
    var imageName = await this.moverService.returnImage(moverId, imageType);
    console.log(imageName)
    if (imageName == null) {
      imageName = 'images.png';
    }
    try {
      return of(res.sendFile(join(process.cwd(), 'uploads/' + imageName)));
    } catch (error) {
      return 'data not found';
    }
  }

  @Public()
  @Get('/images/car/:moverId')
  async getCarPic(@Param('moverId') moverId: number, @Res() res) {
    // to send images to the client
    console.log("moverId${moverId}");
    const imageType = 'carPic';
    var imageName = await this.moverService.returnImage(moverId, imageType);
    if (imageName == null) {
      imageName = 'images.png';
    }
    try {
      return of(res.sendFile(join(process.cwd(), 'uploads/' + imageName)));
    } catch (error) {
      return 'data not found';
    }
  }

  @Public()
  @Get('/images/id/:moverId')
  async getIdPic(@Param('moverId') moverId: number, @Res() res) {
    // to send images to the client
    console.log("moverId${moverId}");
    const imageType = 'idPic';
    var imageName = await this.moverService.returnImage(moverId, imageType);
    if (imageName == null) {
      imageName = 'images.png';
    }
    try {
      return of(res.sendFile(join(process.cwd(), 'uploads/' + imageName)));
    } catch (error) {
      return 'data not found';
    }
  }

  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  @Delete('image')
  async deleteImage(@GetUser('Id') userId: number, @Body() dto: ImageTypeDto) {
    return this.moverService.deleteImage(userId, dto);
  }

  @Roles(Role.MOVER)
  @UseGuards(RolesGuard)
  @Patch('image')
  @UseInterceptors(FileInterceptor('file', storage))
  async updateImage(
    @UploadedFile() file: Express.Multer.File,
    @GetUser('Id') userId: number,
    @Body() dto: ImageTypeDto,
  ) {
    return this.moverService.updateImage(userId, file, dto);
  }

  @Get('test')
  getSth(@Request() req) {
    return req.user;
  }
}
