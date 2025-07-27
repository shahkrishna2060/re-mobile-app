import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromARGB(255, 40, 7, 27);
const kSecondaryColor = Color.fromARGB(255, 54, 138, 194);
const kThirdColor = Color.fromARGB(255, 228, 171, 117);
const kLightBackground = Color.fromARGB(255, 111, 142, 152);
const kWhiteColor = Color.fromARGB(255, 244, 229, 229);
const kBlackColor = Color.fromARGB(255, 23, 2, 2);

class AppTheme {
  static const kBigTitle =
      TextStyle(color: kWhiteColor, fontSize: 25, fontWeight: FontWeight.bold);

  static const kHeadingOne =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const kSeeAllText = TextStyle(color: kPrimaryColor);

  static const kBodyText =
      TextStyle(color: Color.fromARGB(255, 121, 119, 119), fontSize: 12);

  static const kCardTitle =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
}
