import { Injectable } from '@nestjs/common';
import { User } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import * as argon from '../../node_modules/argon2/argon2';
import { MoverUpdateDto } from './dto/mover.dto';
import * as fs from 'fs';
import { ImageType, ImageTypeDto } from './dto';

@Injectable()
export class MoverService {
  constructor(private prisma: PrismaService) {}

  async getMover(userID: number) {
    // var account = this.prisma.user.findUnique({ where: { Id: user.Id } });
    try {
      const u = await this.prisma.user.findFirst({ where: { Id: userID } });
      delete u.hash;
      const account = await this.prisma.mover.findMany({
        where: { userId: userID },
      });
      if (account) {
        return {
          message: 'success',
          data: { ...u, ...account[0] },
        };
      }
    } catch (e) {
      return { message: 'account not found' };
    }
  }

  async updateMover(userId: number, dto: MoverUpdateDto) {
    try {
      if (dto.password) {
        const hash = await argon.hash(dto.password);
        dto.password = hash;
      }
      const user = await this.prisma.user.update({
        where: { Id: userId },
        data: {
          hash: dto.password || undefined,
          email: dto.email || undefined,
          firstName: dto.firstName || undefined,
          lastName: dto.lastName || undefined,
          phoneNumber: dto.phoneNumber || undefined,
        },
      });

      const mover = await this.prisma.mover.update({
        where: { userId: userId },
        data: {
          licenceNumber: dto.licenseNumber || undefined,
          profilePic: dto.profilePic || undefined,
          carPic: dto.carPic || undefined,
          location: dto.location || undefined,
          idPic: dto.idPic || undefined,
          baseFee: dto.baseFee || undefined,
          Banned: dto.Banned || undefined,
          verified: dto.verified || undefined,
        },
      });

      return {
        data: { ...user, ...mover },
      };
    } catch (e) {
      return { message: e };
    }
  }

  async deleteAccount(userId: number) {
    try {
      const mover = await this.prisma.mover.delete({
        where: { userId: userId },
      });
      const user = await this.prisma.user.delete({ where: { Id: userId } });
      return { message: 'success' };
    } catch (e) {
      return { message: 'Deletion not complete' };
    }
  }

  async uploadImage(
    file: Express.Multer.File,
    userId: number,
    dto: ImageTypeDto,
  ) {
    const m = await this.prisma.mover.findFirst({ where: { userId: userId } });
    if (m[dto.imageType] != null) {
      // image already set. do an update instead
      return this.updateImage(userId, file, dto);
    }
    const mover = await this.prisma.mover.update({
      where: { userId: userId },
      data: {
        profilePic:
          dto.imageType == ImageType.profilePic ? file.filename : undefined,
        carPic: dto.imageType == ImageType.carPic ? file.filename : undefined,
        idPic: dto.imageType == ImageType.idPic ? file.filename : undefined,
      },
    });
    return { message: 'success', data: mover };
  }

  async returnImage(moverId: number, imageType: String) {
    var mover;
    console.log(imageType);
    try {
      mover = await this.prisma.mover.findFirst({
        where: { userId: moverId },
      });
    } catch (e) {
      // return { message: 'no mover by this id' };
      console.log('mover not found');
      return null;
    }

    try {
      if (mover[`${imageType}`] == null) {
        return null;
      }
      const image = await mover[`${imageType}`];
      return image;
    } catch (e) {
      return null;
    }
  }

  async deleteImage(moverId: number, dto: ImageTypeDto) {
    const mover = await this.prisma.mover.findFirst({
      where: { userId: moverId },
    });
    const filename = await mover[dto.imageType];
    try {
      await this.prisma.mover.update({
        where: { userId: moverId },
        data: {
          profilePic: dto.imageType == ImageType.profilePic ? null : undefined,
          carPic: dto.imageType == ImageType.carPic ? null : undefined,
          idPic: dto.imageType == ImageType.idPic ? null : undefined,
        },
      });
    } catch (e) {
      return { message: `Error: ${e}` };
    }
    await fs.unlink(`uploads/${filename}`, (err) => {
      if (err) {
        console.log(err);
        return err;
      }
    });
    return { message: 'success' };
  }

  async updateImage(
    moverId: number,
    file: Express.Multer.File,
    dto: ImageTypeDto,
  ) {
    const i = await this.deleteImage(moverId, dto);

    if (i.message == 'success') {
      return this.uploadImage(file, moverId, dto);
    } else {
      return i;
    }
  }
}
