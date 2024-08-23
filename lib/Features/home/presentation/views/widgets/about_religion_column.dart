import 'package:fazakir/Features/home/presentation/views/widgets/about_religion_item.dart';
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
            height: 12,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.17,
            child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        end: index + 1 == 3 ? 0 : 14),
                    child: const AboutReligionItem(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
