import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color starColor;
  final Color emptyStarColor;

  const RatingStars({
    super.key,
    required this.rating,
    this.starSize = 18.0,
    this.starColor = Colors.orange,
    this.emptyStarColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: starSize,
          color: index < rating.floor() ? starColor : emptyStarColor,
        ),
      ),
    );
  }
}
