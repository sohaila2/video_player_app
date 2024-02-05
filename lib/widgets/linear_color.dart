import 'package:flutter/material.dart';



BoxDecoration buildContainerDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xffe4a99a),
        Color(0xff4f3a35),
        Color(0xff110d0b),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.4, 0.7, 1],
      tileMode: TileMode.clamp,
    ),
  );
}