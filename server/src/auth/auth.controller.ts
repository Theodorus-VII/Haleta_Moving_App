import { Body, Controller, Post, UseGuards, Request, Get, ParseIntPipe, Param, } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthDto, BanMoverDto, MoverDto, UserDto } from './dto';
import { AuthGuard } from './guard/auth.guard';
import { RolesGuard } from './guard/roles.guard';
import { Mover, Role } from '@prisma/client';
import { Roles } from './decorator/roles.decorator';
import { Public } from './decorator/public.decorator';

@Public()
@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService) {}

    @Post('signup')
    async customerSignup(@Body() dto: UserDto) {
        let response =  await this.authService.userSignup(dto);
        return response;
    }

    @Post('signup/mover')
    moverSignup(@Body() dto: MoverDto) {
        return this.authService.moverSignup(dto);
    }

    @Post('signin')
    login(@Body() dto: AuthDto) {
        console.log("signing in");
        return this.authService.signin(dto);
    }

    @Post('logout')
    logout() {}

    @UseGuards(AuthGuard, RolesGuard)
    @Roles(Role.ADMIN, Role.USER)
    @Get('profile')
    getProfile(@Request() req){
        return req.user
    }

    @UseGuards(RolesGuard, AuthGuard)
    @Roles(Role.ADMIN)
    @Post('ban')
    banMover(@Body() dto: BanMoverDto){
        return this.authService.banMover(dto);
    }
}
