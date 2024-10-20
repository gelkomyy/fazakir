import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/Features/azkar/presentation/manager/cubits/manage_azkar_cubit/manage_azkar_cubit.dart';
import 'package:fazakir/Features/azkar/presentation/views/widgets/ruqyah_view_body.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class RuqyahView extends StatelessWidget {
  const RuqyahView({super.key});
  static const String routeName = 'ruqyahView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageAzkarCubit(
        getIt<AzkarRepoImpl>(),
      )..fetchRuqyah(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الرقية الشرعية',
            style: AppFontStyles.styleBold20(context),
          ),
          centerTitle: true,
          leading: Bounceable(
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
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: const SafeArea(
          child: RuqyahViewBody(),
        ),
      ),
    );
  }
}
