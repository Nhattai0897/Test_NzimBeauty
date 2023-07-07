import 'package:flutter/material.dart';
import 'colors.dart';

class CoreFontFamily {
  static String black = "Barlow-Black";
  static String blackItalic = "Barlow-BlackItalic";
  static String bold = "Barlow-Bold";
  static String boldItalic = "Barlow-BoldItalic";
  static String italic = "Barlow-Italic";
  static String light = "Barlow-Light";
  static String lightItalic = "Barlow-LightItalic";
  static String medium = "Barlow-Medium";
  static String mediumItalic = "Barlow-MediumItalic";
  static String regular = "Barlow-Regular";
  static String barlow = "Barlow";
}

class CoreTextStyle {
  static TextStyle mediumTextFont({Color? color, double? fontSize}) =>
      TextStyle(
          fontFamily: CoreFontFamily.medium,
          fontSize: fontSize ?? CoreFontSize.defaultSize,
          color: color ?? CoreColors.colorText1,
          height: 1.2);

  static TextStyle regularTextFont({Color? color, double? fontSize}) =>
      TextStyle(
          fontFamily: CoreFontFamily.regular,
          fontSize: fontSize ?? CoreFontSize.defaultSize,
          color: color ?? CoreColors.colorText1,
          height: 1.2);

  static TextStyle boldTextFont({Color? color, double? fontSize}) => TextStyle(
        fontFamily: CoreFontFamily.bold,
        fontSize: fontSize ?? CoreFontSize.defaultSize,
        color: color ?? CoreColors.colorText1,
      );

  static TextStyle boldItalicTextFont({Color? color, double? fontSize}) =>
      TextStyle(
        fontFamily: CoreFontFamily.boldItalic,
        fontSize: fontSize ?? CoreFontSize.defaultSize,
        color: color ?? CoreColors.colorText1,
      );

  static TextStyle italicTextFont({Color? color, double? fontSize}) =>
      TextStyle(
        fontFamily: CoreFontFamily.italic,
        fontSize: fontSize ?? CoreFontSize.defaultSize,
        color: color ?? CoreColors.colorText1,
      );

  static TextStyle underLineTextFont(
          {Color? color, double? fontSize, String? fontFamily}) =>
      TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize ?? CoreFontSize.defaultSize,
        color: color ?? CoreColors.colorText1,
        decoration: TextDecoration.underline,
      );

  static TextStyle style16BoldWhite = TextStyle(
      fontFamily: CoreFontFamily.bold,
      fontSize: CoreFontSize.titleSize,
      fontWeight: FontWeight.w700,
      color: Colors.black);

  static TextStyle style12RegularGrey = TextStyle(
      fontFamily: CoreFontFamily.regular,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: CoreColors.colorText1);

  static TextStyle style12RegularBlue = TextStyle(
      fontFamily: CoreFontFamily.regular,
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
      color: CoreColors.colorText1);

  static TextStyle style30RegularBlack = TextStyle(
      fontFamily: CoreFontFamily.bold,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
      color: Colors.black);
}

class CoreFontSize {
  static double spendSize = defaultSize - 2.0;
  static double defaultSize = 14.0;
  static double titleSize = defaultSize + 2.0;
  static double maxSize = defaultSize + 4.0;
  static double superSize = defaultSize + 6.0;
  static double superSize2 = defaultSize + 12.0;
}
