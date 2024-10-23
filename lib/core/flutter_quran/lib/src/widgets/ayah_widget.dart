import 'package:fazakir/core/flutter_quran/lib/src/models/ayah.dart';
import 'package:fazakir/core/flutter_quran/lib/src/utils/flutter_quran_utils.dart';
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
      style: FlutterQuran().hafsStyle,
    ));
  }
}
