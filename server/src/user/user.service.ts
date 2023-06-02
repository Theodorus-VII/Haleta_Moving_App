import {
  HttpException,
  HttpStatus,
  Injectable,
  UseGuards,
} from '@nestjs/common';
import { Role, User } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { UserUpdateDto } from './dto/user.dto';
import * as argon from '../../node_modules/argon2/argon2';
import { RolesGuard } from 'src/auth/guard/roles.guard';
import { Roles } from 'src/auth/decorator';

@Roles(Role.USER)
@UseGuards(RolesGuard)
@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async getUser(userID: number) {
    var account = await this.prisma.user.findFirst({ where: { Id: userID } });
    if (account != null) {
      console.log(account);
      delete account['hash'];
      delete account['joinDate'];
      delete account['updatedAt'];

      if (account.role == Role.MOVER) {
        try {
          var mover = await this.prisma.mover.findFirst({
            where: { userId: account.Id },
          });
          console.log(mover);
          // return { message: 'success', data: { ...account } };
          return { ...account, ...mover, moverId: mover.userId };
        } catch (e) {
          // return { message: 'error', data: e };
          throw new HttpException({ message: e }, HttpStatus.BAD_REQUEST);
        }
      }
      console.log('gotten user');
      return { ...account };
    }
    // return { message: 'account not found' };
    throw new HttpException(
      { message: 'account not found' },
      HttpStatus.BAD_REQUEST,
    );
  }

  async updateUser(userId: number, dto: UserUpdateDto) {
    try {
      if (dto.password) {
        const hash = await argon.hash(dto.password);
        dto.password = hash;
      }

      console.log(dto.password);
      const user = await this.prisma.user.update({
        where: { Id: userId },
        data: {
          hash: dto.password || undefined,
          firstName: dto.firstName || undefined,
          lastName: dto.lastName || undefined,
          phoneNumber: dto.phoneNumber || undefined,
        },
      });

      return {
        ...user,
      };
    } catch (e) {
      // return { message: 'Error. Cant help more' };
      throw new HttpException({ message: e }, HttpStatus.BAD_REQUEST);
    }
  }

  async deleteAccount(userId: number) {
    try {
      const user = await this.prisma.user.delete({ where: { Id: userId } });
      return true;
    } catch (e) {
      // return { message: 'Deletion not complete' };
      throw new HttpException(
        { message: `Cant delete account`, details: e },
        HttpStatus.BAD_REQUEST,
      );
    }
  }

  async getMovers() {
    try {
      const users = await this.prisma.user.findMany({
        where: { role: Role.MOVER },
      });
      // const movers = await this.prisma.mover.findMany({
      //   where: { Banned: false },
      // });
      var movers = [];
      // console.log(users);
      for (var i = 0; i < users.length; i++) {
        // console.log(users[i])
        var mover = await this.prisma.mover.findFirst({
          where: { userId: users[i].Id },
        });
        delete users[i].hash;
        var moverId = mover.Id;
        delete mover.Id;
        movers.push({ ...users[i], ...mover, moverId: moverId });
        // console.log(movers[i])
      }
      //  console.log('movers');
      // console.log(movers);
      return { movers };
    } catch (e) {
      throw new HttpException(
        { message: 'failed', details: e },
        HttpStatus.BAD_REQUEST,
      );
    }
  }

  async getUserById(userId: number) {
    try {
      const user = await this.prisma.user.findUnique({ where: { Id: userId } });
      return {
        Id: user.Id,
        firstName: user.firstName,
        lastName: user.lastName,
        phoneNumber: user.phoneNumber,
        email: user.email,
        username: user.username
      };
    } catch (e) {
      throw new HttpException(
        { message: 'failed', details: e },
        HttpStatus.BAD_REQUEST,
      );
    }
  }
}
