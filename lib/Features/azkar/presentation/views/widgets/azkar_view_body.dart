import 'package:fazakir/Features/azkar/presentation/views/widgets/zikr_item.dart';

import 'package:flutter/material.dart';

class AzkarViewBody extends StatelessWidget {
  const AzkarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                EdgeInsetsDirectional.only(bottom: index + 1 == 10 ? 0 : 24),
            child: const ZikrItem(),
          );
        },
      ),
    );
  }
}
