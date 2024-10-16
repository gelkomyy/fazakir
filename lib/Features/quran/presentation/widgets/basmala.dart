import 'package:fazakir/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class Basmala extends StatelessWidget {
  const Basmala({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SizedBox(
      width: screenSize.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: (screenSize.width * .2),
            right: (screenSize.width * .2),
            top: 8,
            bottom: 2),
        child: Image.asset(
          Assets.assetsImagesBasmala,
          color: Colors.black,
          width: MediaQuery.of(context).size.width * .4,
        ),
      ),
    );
  }
}
