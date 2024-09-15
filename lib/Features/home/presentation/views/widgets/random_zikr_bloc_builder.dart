import 'package:fazakir/Features/azkar/domain/entities/azkar_item_entity.dart';
import 'package:fazakir/Features/azkar/presentation/manager/cubits/manage_azkar_cubit/manage_azkar_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/container_zikr_of_the_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RandomZikrBlocBuilder extends StatelessWidget {
  const RandomZikrBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageAzkarCubit, ManageAzkarState>(
      builder: (context, state) {
        if (state is FetchAzkarSuccess) {
          return ContainerZikrOfTheDay(
            azkarItem: state.azkarCategories.first.azkar.first,
            zikrCategory: state.azkarCategories.first.category,
            withoutCount: true,
          );
        } else if (state is FetchAzkarLoading) {
          return Skeletonizer(
            effect: const PulseEffect(),
            child: ContainerZikrOfTheDay(
              azkarItem: AzkarItemEntity(
                id: 1,
                text:
                    'اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.',
                count: 1,
              ),
              withoutCount: true,
            ),
          );
        } else {
          return ContainerZikrOfTheDay(
            azkarItem: AzkarItemEntity(
              id: 1,
              text:
                  'اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.',
              count: 1,
            ),
            withoutCount: true,
          );
        }
      },
    );
  }
}
