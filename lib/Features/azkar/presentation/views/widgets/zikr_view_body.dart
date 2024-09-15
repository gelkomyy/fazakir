import 'package:fazakir/Features/azkar/domain/entities/azkar_item_entity.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/container_zikr_of_the_day.dart';

import 'package:flutter/material.dart';

class ZikrViewBody extends StatelessWidget {
  const ZikrViewBody({super.key, required this.azkar});
  final List<AzkarItemEntity> azkar;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: azkar.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(
                bottom: index + 1 == azkar.length ? 0 : 24),
            child: ContainerZikrOfTheDay(
              azkarItem: azkar[index],
              margin: const EdgeInsets.symmetric(horizontal: 16),
              withoutHeader: true,
            ),
          );
        },
      ),
    );
  }
}
