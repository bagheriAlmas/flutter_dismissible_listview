import 'dart:math';

import 'package:flutter/material.dart';

class GenerateColor {
  Color getColor(String str) {
    Random random = Random(str.hashCode);
    return Color.fromARGB(random.nextInt(255), random.nextInt(255),
        random.nextInt(255), random.nextInt(255));
  }
}
