import 'package:fazakir/Features/azkar/presentation/manager/cubits/manage_azkar_cubit/manage_azkar_cubit.dart';
import 'package:fazakir/Features/azkar/presentation/views/widgets/zikr_item.dart';
import 'package:fazakir/core/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzkarViewBody extends StatelessWidget {
  const AzkarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: BlocBuilder<ManageAzkarCubit, ManageAzkarState>(
        builder: (context, state) {
          if (state is FetchAzkarSuccess) {
            return ListView.builder(
              clipBehavior: Clip.none,
              itemCount: state.azkarCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(
                      bottom:
                          index + 1 == state.azkarCategories.length ? 0 : 24),
                  child: ZikrItem(
                    azkarCategory: state.azkarCategories[index],
                  ),
                );
              },
            );
          } else if (state is FetchAzkarFailure) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            );
          }
        },
      ),
    );
  }
}
