import 'package:flutter/material.dart';

const TextStyle kListViewTitle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

final TextStyle kAlternateListViewTitle =
    kListViewTitle.copyWith(color: kPrimaryColor);

final TextStyle kActiveNavBarStyle =
    kListViewTitle.copyWith(color: Colors.white);
final TextStyle kInactiveNavBarStyle =
    kListViewTitle.copyWith(color: Colors.white54);

const Color kPrimaryColor = Color(0xFF1D1E33);
const Color kPrimaryColor2 = Color(0xFF2B2C3A);

const TextStyle kSmallConentStyle = TextStyle(fontSize: 14.0);

const TextStyle kTitleStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);
