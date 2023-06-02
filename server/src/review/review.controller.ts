import {
  Controller,
  Get,
  Put,
  Post,
  Delete,
  Patch,
  UseGuards,
  Body,
  Param,
  ParseIntPipe,
} from '@nestjs/common';
import { ReviewService } from './review.service';
import { RolesGuard } from 'src/auth/guard/roles.guard';
import { GetUser, Roles } from 'src/auth/decorator';
import { Role, User } from '@prisma/client';
import {
  deleteReviewDto,
  editReviewDto,
  getMoverReviewDto,
  postReviewDto,
} from './dto/review.dto';

@Controller('reviews')
export class ReviewController {
  constructor(private reviewService: ReviewService) {}
  @Get(':id')
  getMoverReviews(@Param('id', ParseIntPipe) moverId: number) {
    // get the reviews for a mover. needs a parameter instead of a dto since its a get
    return this.reviewService.getMoverReviews(moverId);
  }

  @UseGuards(RolesGuard)
  @Roles(Role.USER)
  @Post()
  postMoverReview(
    @GetUser('Id') customerId: number,
    @Body() dto: postReviewDto,
  ) {
    // for users to post reviews about a specific mover
    return this.reviewService.postMoverReview(
      (dto = dto),
      (customerId = customerId),
    );
  }

  @UseGuards(RolesGuard)
  @Roles(Role.USER)
  @Patch()
  editMoverReview(
    @Body() dto: editReviewDto,
    @GetUser('Id') customerId: number,
  ) {
    return this.reviewService.editMoverReview(
      (dto = dto),
      (customerId = customerId),
    );
  }

  @UseGuards(RolesGuard)
  @Roles(Role.USER, Role.ADMIN)
  @Delete(':id')
  deleteMoverReview(
    @GetUser('Id') userId: number,
    @Param('id', ParseIntPipe) reviewId: number,
  ) {
    return this.reviewService.deleteMoverReviews(
      reviewId, userId
    );
  }
}
