import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class MoveForCompassDialog extends StatefulWidget {
  const MoveForCompassDialog({
    super.key,
  });

  @override
  State<MoveForCompassDialog> createState() => _MoveForCompassDialogState();
}

class _MoveForCompassDialogState extends State<MoveForCompassDialog> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    final S txt = S.of(context);
    return isDone
        ? const SizedBox()
        : Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  txt.move_for_better_results,
                  style: AppFontStyles.styleBold20(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  txt.tilt_and_move_phone,
                  style: AppFontStyles.styleBold16(context),
                ),
                const SizedBox(height: 8),
                Image.asset(Assets.assetsImagesMoveForCompassGif),
                const SizedBox(height: 8),
                Bounceable(
                  onTap: () {},
                  child: CustomTextButton(
                      padding: const EdgeInsets.all(8),
                      text: txt.done,
                      minimumSize: const Size(72, 24),
                      onPressed: () {
                        setState(() {
                          isDone = true;
                        });
                      }),
                ),
              ],
            ),
          );
  }
}
