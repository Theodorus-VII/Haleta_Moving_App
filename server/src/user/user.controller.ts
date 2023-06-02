import { Body, Controller, Delete, Get, Patch, Post, Request,ParseIntPipe, UseGuards, Param } from '@nestjs/common';
import { Role, User } from '@prisma/client';
import { GetUser } from 'src/auth/decorator';
import { PrismaService } from 'src/prisma/prisma.service';
import { UserService } from './user.service';
import { Roles } from 'src/auth/decorator/roles.decorator';
import { RolesGuard } from 'src/auth/guard/roles.guard';
import { AuthGuard } from 'src/auth/guard/auth.guard';
import { UserUpdateDto } from './dto/user.dto';

@Roles(Role.USER)
@UseGuards(RolesGuard)
@Controller('users')
export class UserController {
  constructor(
    private userService: UserService,
    private prisma: PrismaService,
  ) {}

  // the authguard(checking jwt token) works on all endpoints by default. add @Public() to make it accessible to others(check authcontroller)
  // ROLE BASED: copy the next two (uncommented) lines, replace the @Roles parameters to whichever role/s u want to access the endpoint. others will get an error
  // admin has access to everything

  @Roles(Role.USER, Role.MOVER)
  @UseGuards(RolesGuard)
  @Patch()
  updateAccount(@GetUser('Id') userId: number, @Body() dto: UserUpdateDto) {
    // account update
    console.log("updating password");
    return this.userService.updateUser(userId, dto);
  }

  @Roles(Role.USER, Role.MOVER)
  @UseGuards(RolesGuard)
  @Get('me')
  getUser(@GetUser('Id') userId: number) {
    //Returns the users information
    console.log(`getting user ${userId}`);
    return this.userService.getUser(userId);
  }

  @UseGuards(AuthGuard, RolesGuard)
  @Roles()
  @Get('test')
  getSth(@Request() req) {
    return req.user;
  }

  @Delete('me')
  deleteUser(@GetUser('Id') userId: number) {
    return this.userService.deleteAccount((userId = userId));
  }

  @UseGuards(RolesGuard)
  @Roles(Role.USER, Role.ADMIN)
  @Get('allMovers')
  returnMovers(@GetUser('Id') userId: number) {
    // returns all nonBanned users
    console.log('getstart');
    return this.userService.getMovers();
  }
  @UseGuards(RolesGuard)
  @Roles(Role.USER, Role.MOVER)
  @Get(':id')
  getUserById(@Param('id', ParseIntPipe) userId: number, @GetUser() user: User) {
    return this.userService.getUserById(userId);
  }
}
