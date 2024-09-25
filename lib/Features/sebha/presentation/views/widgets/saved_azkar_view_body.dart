import 'package:fazakir/Features/sebha/presentation/manager/cubits/manage_sebha_zikr_cubit/manage_sebha_zikr_cubit.dart';
import 'package:fazakir/Features/sebha/presentation/views/widgets/empty_zikr_state_widget.dart';
import 'package:fazakir/Features/sebha/presentation/views/widgets/sebha_zikr_item.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAzkarViewBody extends StatelessWidget {
  const SavedAzkarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: BlocBuilder<ManageSebhaZikrCubit, ManageSebhaZikrState>(
        builder: (context, state) {
          if (state is GetAzkarSuccess) {
            final zikrs = state.azkar;
            if (zikrs.isEmpty) {
              return const EmptyZikrStateWidget();
            }
            return ListView.builder(
              clipBehavior: Clip.none,
              itemCount: zikrs.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    if (index == 0)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          'اختر ذكر لبدء التسبيح به',
                          style: AppFontStyles.styleBold16(context)
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          bottom: index + 1 == zikrs.length ? 0 : 14),
                      child: SebhaZikrItem(zikr: zikrs[index]),
                    ),
                  ],
                );
              },
            );
          } else if (state is ManageSebhaZikrLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            );
          }
          return const EmptyZikrStateWidget();
        },
      ),
    );
  }
}
