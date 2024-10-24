import 'package:fazakir/core/flutter_quran/lib/src/models/ayah.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class AyahWidget extends StatelessWidget {
  const AyahWidget(this.ayah, {super.key});

  final Ayah ayah;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children:
          ayah.ayah.split(' ').map((word) => TextSpan(text: word)).toList(),
      style: TextStyle(
        color: Colors.black,
        fontSize: getTheFontSize(context, fontSize: 23.55),
        fontFamily: "uthmanic_hafs",
      ),
    ));
  }
}
