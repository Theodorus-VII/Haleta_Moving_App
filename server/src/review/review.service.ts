import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import {
  deleteReviewDto,
  editReviewDto,
  getMoverReviewDto,
  postReviewDto,
} from './dto/review.dto';
import { User } from '@prisma/client';

@Injectable()
export class ReviewService {
  constructor(private prisma: PrismaService) {}

  async postMoverReview(dto: postReviewDto, customerId: number) {
    try {
      if (dto.Rating > 5) {
        dto.Rating = 5;
      }
      if (dto.Rating < 0) {
        dto.Rating = 0;
      }
      const mover = await this.prisma.mover.findFirst({
        where: { userId: dto.moverId },
      });
      console.log(mover);
      if (mover == null) {
        throw 'Mover not found';
      }
      const appointment = await this.prisma.appointment.findFirst({
        where: { moverId: mover.Id, customerId: customerId },
      });
      if (appointment == null) {
        throw 'Appointment not found';
      }
      if (appointment.status < 2) {
        throw 'Appointment not complete yet';
      }
      const review = await this.prisma.review.create({
        data: {
          moverId: dto.moverId,
          Review: dto.Review || undefined,
          Rating: dto.Rating || undefined,
          customerId: customerId,
        },
      });
      return {
        message: 'Review Created successfully',
      };
    } catch (e) {
      return { message: e };
    }
  }

  async editMoverReview(dto: editReviewDto, customerId: number) {
    try {
      if (dto.Rating > 5) {
        dto.Rating = 5;
      }
      if (dto.Rating < 0) {
        dto.Rating = 0;
      }
      const review = await this.prisma.review.findUnique({
        where: { Id: dto.Id },
      });
      if (review == null) {
        return {
          message: 'doesnt exist',
        };
      }
      if (review.customerId != customerId) {
        return {
          message: 'not your review to edit',
        };
      }
      const editedReview = await this.prisma.review.update({
        where: { Id: review.Id },
        data: {
          Rating: dto.Rating ? dto.Rating : review.Rating,
          Review: dto.Review ? dto.Review : review.Review,
        },
      });
      return { editedReview };
    } catch (e) {
      console.log(e);
      return {
        message: e,
      };
    }
  }

  async getMoverReviews(moverId: number) {
    try {
      const reviews = await this.prisma.review.findMany({
        where: { moverId: moverId },
      });
      if (reviews.length == 0) {
        return {};
      }
      return {
        reviews,
      };
    } catch (e) {
      // should return sth here.
      return {
        message: e,
      };
    }
  }

  async deleteMoverReviews(reviewId: number, customer: number) {
    try {
      const review = await this.prisma.review.findUnique({
        where: { Id: reviewId },
      });

      if (review == null) {
        throw 'Review not found';
      }
      if (review.customerId != customer) {
        throw `Not your review to delete ${customer} ${review.customerId}`;
      }

      await this.prisma.review.delete({ where: { Id: review.Id } });
      return {
        message: 'Deleted review successfully',
      };
    } catch (e) {
      return {
        message: e,
      };
    }
  }
}
