import 'package:fazakir/Features/home/presentation/manager/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:fazakir/Features/sebha/presentation/manager/cubits/manage_sebha_zikr_cubit/manage_sebha_zikr_cubit.dart';
import 'package:fazakir/Features/sebha/presentation/views/widgets/add_zikr_dialog.dart';
import 'package:fazakir/Features/sebha/presentation/views/widgets/saved_azkar_view_body.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class SavedAzkarView extends StatelessWidget {
  const SavedAzkarView({
    super.key,
    this.fromNavigation = false,
  });

  static const String routeName = 'savedAzkarView';
  final bool fromNavigation;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageSebhaZikrCubit()..addDefaultSebhaZikr(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الاذكار المحفوظة',
            style: AppFontStyles.styleBold20(context),
          ),
          centerTitle: true,
          actions: [
            Builder(builder: (acontext) {
              return Bounceable(
                child: const Card(
                  color: AppColors.textBlackColor,
                  shape: CircleBorder(),
                  margin: EdgeInsetsDirectional.only(end: 24),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  showAddZikrDialog(acontext);
                },
              );
            }),
          ],
          leading: fromNavigation
              ? null
              : Bounceable(
                  child: const Card(
                    color: AppColors.textBlackColor,
                    shape: CircleBorder(),
                    margin: EdgeInsetsDirectional.only(start: 24),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    if (fromNavigation) {
                      context.read<NavigationCubit>().backNavigation();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: const SafeArea(
          child: SavedAzkarViewBody(),
        ),
      ),
    );
  }
}
