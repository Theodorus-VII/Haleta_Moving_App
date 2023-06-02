import { IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';

export class postReviewDto {
  @IsNotEmpty()
  @IsNumber()
  moverId: number;

  @IsNotEmpty()
  @IsNumber()
  Rating: number;

  @IsOptional()
  @IsString()
  Review: string = '';
}

export class editReviewDto {
  @IsNotEmpty()
  @IsNumber()
  Id: number;

  @IsOptional()
  @IsNumber()
  Rating?: number;

  @IsOptional()
  @IsString()
  Review?: string;
}

export class deleteReviewDto {
  @IsNotEmpty()
  @IsNumber()
  Id: number;
}

export class getMoverReviewDto {
  @IsNotEmpty()
  @IsNumber()
  moverId: number;
}
