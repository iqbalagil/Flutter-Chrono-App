import 'package:flutter/material.dart';

class TColor{
  static Color get primaryColor1 => const Color(0xff153448);
  static Color get primaryColor2 => const Color(0xff3C5B6F);

  static Color get secondary1 => const Color(0xffFF8A08);
  static Color get secondary2 => const Color(0xffFFC100);

  static List<Color> get primaryG => [primaryColor1, primaryColor2];
  static List<Color> get secondaryG => [secondary1, secondary2];

  static Color get white => Colors.white;
  static Color get gray => const Color(0xff786F72);
  static Color get black => const Color(0xff1D1617);
}