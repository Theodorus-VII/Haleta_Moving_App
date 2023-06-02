import 'package:flutter/material.dart';

Container iconBuilderMethod(IconData iconData) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      margin: const EdgeInsets.all(8.0),
      child: Icon(
        iconData,
        size: 28.0,
        color: Colors.white,
      ),
    ),
  );
}
