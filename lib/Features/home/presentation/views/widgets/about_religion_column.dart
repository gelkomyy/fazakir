import 'package:fazakir/core/widgets/row_label_with_show_more.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';

class AboutReligionColumn extends StatelessWidget {
  const AboutReligionColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final S txt = S.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowLabelWithShowMore(
            labelText: txt.about_religion,
          ),
          const SizedBox(
            height: 38,
          ),
        ],
      ),
    );
  }
}
