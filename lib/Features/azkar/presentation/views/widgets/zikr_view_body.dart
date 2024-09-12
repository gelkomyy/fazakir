import 'package:fazakir/Features/home/presentation/views/widgets/container_zikr_of_the_day.dart';

import 'package:flutter/material.dart';

class ZikrViewBody extends StatelessWidget {
  const ZikrViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                EdgeInsetsDirectional.only(bottom: index + 1 == 10 ? 0 : 24),
            child: const ContainerZikrOfTheDay(
              margin: EdgeInsets.symmetric(horizontal: 16),
              withoutHeader: true,
            ),
          );
        },
      ),
    );
  }
}
