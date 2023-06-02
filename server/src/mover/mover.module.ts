import { Module } from '@nestjs/common';
import { MoverService } from './mover.service';
import { MoverController } from './mover.controller';

@Module({
  providers: [MoverService],
  controllers: [MoverController]
})
export class MoverModule {}
