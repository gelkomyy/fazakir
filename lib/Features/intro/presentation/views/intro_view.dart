import 'package:fazakir/Features/intro/presentation/views/widgets/intro_view_body.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});
  static const String routeName = 'introView';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesIntroBackground),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Colors.transparent, Colors.black],
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(child: IntroViewBody()),
        ),
      ),
    );
  }
}
