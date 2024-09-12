import 'package:flutter/material.dart';

abstract class AppFontStyles {
  static TextStyle styleBold10(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold, // Bold
      fontSize: getResponsiveFontSize(context, fontSize: 10),
    );
  }

  static TextStyle styleRegular14(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.normal, // Regular
      fontSize: getResponsiveFontSize(context, fontSize: 14),
    );
  }

  static TextStyle styleRegular16(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.normal, // Regular
      fontSize: getResponsiveFontSize(context, fontSize: 16),
    );
  }

  static TextStyle styleBold15(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold, // Bold
      fontSize: getResponsiveFontSize(context, fontSize: 15),
    );
  }

  static TextStyle styleBold13(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold, // Bold
      fontSize: getResponsiveFontSize(context, fontSize: 13),
    );
  }

  static TextStyle styleBold12(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold, // Bold
      fontSize: getResponsiveFontSize(context, fontSize: 12),
    );
  }

  static TextStyle styleBold20(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold, // Bold
      fontSize: getResponsiveFontSize(context, fontSize: 20),
    );
  }

  static TextStyle styleBold14(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold, // Bold
      fontSize: getResponsiveFontSize(context, fontSize: 14),
    );
  }

  static TextStyle styleRegular11(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.normal, // Regular
      fontSize: getResponsiveFontSize(context, fontSize: 11),
    );
  }

  static TextStyle styleRegular13(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.normal, // Regular
      fontSize: getResponsiveFontSize(context, fontSize: 13),
    );
  }

  static TextStyle styleRegular24(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.normal, // Regular
      fontSize: getResponsiveFontSize(context, fontSize: 24),
    );
  }

  static TextStyle styleExtraBold13(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w800, // ExtraBold
      fontSize: getResponsiveFontSize(context, fontSize: 13),
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold, // Bold
      fontSize: getResponsiveFontSize(context, fontSize: 16),
    );
  }

  static TextStyle styleRegular70(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.normal, // Regular
      fontSize: getResponsiveFontSize(context, fontSize: 70),
    );
  }
}

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;
  double minSize = fontSize * 0.7;
  double maxSize = fontSize * 1.2;
  return responsiveFontSize.clamp(minSize, maxSize);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  /* var dispatcher = PlatformDispatcher.instance;
  double width0 = dispatcher.views.first.physicalSize.width /
      dispatcher.views.first.devicePixelRatio; */
  if (width < 600) {
    return width / 450; // Scaling factor for small screens
  } else if (width < 800) {
    return width / 600; // Scaling factor for medium screens
  } else if (width < 1100) {
    return width / 950; // Scaling factor for large screens
  } else {
    return width / 1450; // Scaling factor for extra-large screens
  }
}
