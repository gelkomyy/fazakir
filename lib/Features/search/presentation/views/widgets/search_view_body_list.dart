import 'package:fazakir/Features/ahadith/presentation/views/widgets/container_hadith_item.dart';
import 'package:fazakir/Features/search/presentation/manager/cubits/cubit/search_cubit.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBodyList extends StatelessWidget {
  const SearchViewBodyList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.primaryColor,
            ),
          );
        } else if (state is SearchLoaded) {
          if (state.searchResults == null ||
              state.searchResults.isEmpty ||
              state.searchResults.length == 0) {
            return const Center(
              child: Text('لا توجد نتائج'),
            );
          }
          return ListView.builder(
            itemCount: state.searchResults.length,
            itemBuilder: (context, index) {
              return ContainerHadithItem(
                hadithEntity: state.searchResults[index],
              );
            },
          );
        } else if (state is SearchError) {
          return Text('Error: ${state.error}');
        } else {
          return Center(
            child: Image.asset(
              Assets.assetsImagesSearchViewShape2,
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }
}
