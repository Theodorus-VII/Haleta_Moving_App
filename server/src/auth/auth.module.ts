import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtModule } from '@nestjs/jwt';
import { JwtStrategy } from './strategy/jwt.strategy';
import { APP_GUARD } from '@nestjs/core';
import { RolesGuard } from './guard/roles.guard';
import { AuthGuard } from './guard/auth.guard';

@Module({
  providers: [
    AuthService,
    JwtStrategy,
    // { provide: APP_GUARD, useClass: RolesGuard },
    // AuthGuard,
    {provide: APP_GUARD, useClass: AuthGuard}
  ],
  controllers: [AuthController],
  imports: [
    JwtModule.register({
      global: true,
    }),
  ],
  exports: [
    // AuthGuard
  ],
})
export class AuthModule {}
