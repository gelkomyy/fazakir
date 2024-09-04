import 'package:fazakir/Features/home/presentation/views/widgets/shortcuts_view_body.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShortCutsView extends StatelessWidget {
  const ShortCutsView({super.key});

  static const String routeName = 'ShortcutsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          SvgPicture.asset(Assets.assetsImagesShortcutsBackgroundShapeSvg),
          const Center(child: ShortCutsViewBody()),
        ],
      ),
    );
  }
}
