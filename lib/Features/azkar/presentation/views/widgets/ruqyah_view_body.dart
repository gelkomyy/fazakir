import 'package:fazakir/Features/azkar/data/models/azkar_item_model.dart';
import 'package:fazakir/Features/azkar/presentation/manager/cubits/manage_azkar_cubit/manage_azkar_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/container_zikr_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RuqyahViewBody extends StatelessWidget {
  const RuqyahViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: BlocBuilder<ManageAzkarCubit, ManageAzkarState>(
        builder: (context, state) {
          if (state is FetchRuqyahSuccess) {
            return ListView.builder(
              clipBehavior: Clip.none,
              itemCount: state.ruqyahZikrs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(
                      bottom: index + 1 == state.ruqyahZikrs.length ? 0 : 24),
                  child: ContainerZikrItem(
                    azkarItem:
                        AzkarItemModel.fromRuqyah(state.ruqyahZikrs[index]),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    withoutHeader: true,
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
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
