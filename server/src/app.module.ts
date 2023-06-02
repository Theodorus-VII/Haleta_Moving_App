import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { ConfigModule } from '@nestjs/config';
import { UserModule } from './user/user.module';
import { AppointmentModule } from './appointment/appointment.module';
import { NotificationModule } from './notification/notification.module';
import { ReviewModule } from './review/review.module';
import { MoverModule } from './mover/mover.module';

@Module({
  imports: [
    AuthModule,
    PrismaModule,
    ConfigModule.forRoot({
      isGlobal: true
    }),
    UserModule,
    AppointmentModule,
    NotificationModule,
    ReviewModule,
    MoverModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
