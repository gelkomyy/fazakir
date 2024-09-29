import 'package:fazakir/Features/search/presentation/manager/cubits/cubit/search_cubit.dart';
import 'package:fazakir/Features/search/presentation/views/widgets/search_view_body.dart';
import 'package:fazakir/core/cubits/filter_select_item_cubit/filter_select_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static const String routeName = 'searchView';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchCubit(context),
        ),
        BlocProvider(
          create: (context) => FilterSelectItemCubit(),
        ),
      ],
      child: const Scaffold(
        body: SafeArea(
          child: SearchViewBody(),
        ),
      ),
    );
  }
}
