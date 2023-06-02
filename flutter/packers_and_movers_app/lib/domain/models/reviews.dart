// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Review {
  final int Id;
  final int moverId;
  final int customerId;
  final int Rating;
  final String review;

  const Review(
    this.Id,
    this.customerId,
    this.moverId,
    this.Rating,
    this.review,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'moverId': moverId,
      'customerId': customerId,
      'Rating': Rating,
      'Review': review,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      map['Id'] as int,
      map['moverId'] as int,
      map['customerId'] as int,
      map['Rating'] as int,
      map['Review'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source) as Map<String, dynamic>);
}



