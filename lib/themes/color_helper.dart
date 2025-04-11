import "dart:ui";

class ColorHelper {
  static const myMainBlue = Color(0xFF0656A0);
  static const mySecondBlue = Color(0xFF7C98C7);
  static const myThirdBlue = Color(0xFF99AED1);
  static const myFourthBlue = Color(0xFF98afd2);
  static const myLightBlue = Color(0xFF1A98D5);
  static const myWhite = Color(0xFFFFFFFF);
  static const myDarkBlue = Color(0xFF0B192C);
  static const myRed = Color(0xFFE8292C);
  static const myGreen = Color(0xFF37A048);
  static const myGrey = Color(0xFF646464);
  static const myDarkGrey = Color(0xFF3e3e3e);
  static const myBlack = Color(0xFF000000);
  static const myDefaultBackColor = Color(0xFAFAFAFF);
  static const myDisable1 = Color(0xff9B9B9B);
  static const myDisable2 = Color(0xffC7C7CC);
  static const whatsappGreen = Color(0xff25D366);

  //static const myDominantColor = Color(0xFF3F5F95);
  static const myDominantColor = Color(0xFF0656A0);
  static const mySecondaryColor = Color(0xff7591CB);
  static const myComplementaryColor = Color(0xffE3F0FF);
  static const myAccentColor = Color(0xFFFFB115);
  static const myOffWhite = Color(0xFFFAF9F6);

  static String colorConverter(int colorInt) {
    String hexValue = (colorInt & 0xFFFFFFFF).toRadixString(16).toUpperCase();
    return hexValue;
  }
}
