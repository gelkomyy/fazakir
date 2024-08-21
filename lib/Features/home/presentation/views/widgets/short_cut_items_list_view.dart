import 'package:fazakir/Features/home/presentation/views/widgets/custom_short_cut_image_shape.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShortCutItemsListView extends StatelessWidget {
  const ShortCutItemsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsetsDirectional.only(end: index + 1 == 3 ? 0 : 12),
              child: const CustomShortCutImageShape(),
            );
          },
        ),
        PositionedDirectional(
          start: 0,
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.textBlackColor),
            child: Center(
              child: IconButton(
                iconSize: 20,
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  FontAwesomeIcons.arrowRightLong,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
        PositionedDirectional(
          end: 0,
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.textBlackColor),
            child: IconButton(
              iconSize: 20,
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                FontAwesomeIcons.arrowLeftLong,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
