import {
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import * as argon from '../../node_modules/argon2/argon2';
import { AuthDto, BanMoverDto, MoverDto, UserDto } from './dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwt: JwtService,
    private config: ConfigService,
  ) {}

  async signToken(userId: number, email: string, role: string) {
    const payload = {
      sub: userId,
      email: email,
      roles: [role],
    };
    const secret = this.config.get('JWT_SECRET');
    const expiry = this.config.get('JWT_EXPIRY');
    const token = await this.jwt.signAsync(payload, {
      expiresIn: expiry,
      secret: secret,
    });

    return {
      access_token: token,
    };
  }

  async userSignup(dto: UserDto) {
    const hash = await argon.hash(dto.password);

    var id: number;
    console.log(dto.role);

    try {
      if (
        await this.prisma.user.findUnique({
          where: { email: dto.email },
        })
      ) {
        // prevent movers with the same email from creating a customer account
        throw new ForbiddenException(
          'Email already exists. Please use a different email',
        );
      }

      const user = await this.prisma.user.create({
        data: {
          email: dto.email,
          hash: hash,
          username: dto.username,
          firstName: dto.firstName,
          lastName: dto.lastName,
          phoneNumber: dto.phoneNumber,
          role: 'USER',
        },
      });
      return this.signToken(user.Id, user.email, user.role);
    } catch (e) {
      if (e instanceof PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new ForbiddenException(
            'Email already exists. Please use a different email',
          );
        }
      }
      console.log(e);
      // return {
      //   message: 'Invalid Credentials',
      // };
      throw new ForbiddenException(
        'Email already exists. Please use a different email',
      );
    }
  }

  async moverSignup(dto: MoverDto) {
    const hash = await argon.hash(dto.password);
    var id: number;
    console.log(dto.role);
    var user;
    try {
      if (
        await this.prisma.user.findUnique({
          where: { email: dto.email },
        })
      ) {
        // prevent movers with the same email from creating a customer account
        throw new ForbiddenException(
          'Email already exists. Please use a different email',
        );
      }
      user = await this.prisma.user.create({
        data: {
          email: dto.email,
          hash: hash,
          username: dto.username,
          firstName: dto.firstName,
          lastName: dto.lastName,
          phoneNumber: dto.phoneNumber,
          role: 'MOVER',
        },
      });
      console.log("HERE")

      const mover = await this.prisma.mover.create({
        data: {
          licenceNumber: dto.licenceNumber,
          location: dto.location,
          baseFee: dto.baseFee,
          userId: user.Id,
        },
      });
      return this.signToken(user.Id, user.email, user.role);
    } catch (e) {
      if (user) {
        await this.prisma.user.delete({ where: { Id: user.id } });
      }
      if (e instanceof PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new ForbiddenException(
            'Email already exists. Please use a different email',
          );
        }
      }
      console.log(e);
      // return {
      //   message: 'Invalid Credentials',
      // };
      throw new HttpException(
        { message: 'invalid credentials' },
        HttpStatus.BAD_REQUEST,
      );
    }
  }

  async signin(dto: AuthDto) {
    const hash = await argon.hash(dto.password);
    try {
      const user = await this.prisma.user.findUnique({
        where: {
          email: dto.email,
        },
      });

      if (!user) {
        throw new ForbiddenException('Incorrect Credentials!');
      }
      const passmatch = await argon.verify(user.hash, dto.password);
      if (passmatch) {
        return this.signToken(user.Id, user.email, user.role);
      } else {
        // return { message: 'Incorrect password' };
        throw new HttpException(
          { message: 'incorrect password' },
          HttpStatus.BAD_REQUEST,
        );
      }
    } catch (e) {
      // return { message: 'Incorrect Credentials!' };
      throw new HttpException(
        { message: 'invalid credentials' },
        HttpStatus.BAD_REQUEST,
      );
    }
  }

  async banMover(dto: BanMoverDto) {
    try {
      const mover = await this.prisma.mover.update({
        where: { userId: dto.moverId },
        data: { Banned: dto.Banned },
      });
      return { mover };
    } catch (e) {
      // return { message: e };
      throw new HttpException({ message: e }, HttpStatus.BAD_REQUEST);
    }
  }

  logout() {}
}
