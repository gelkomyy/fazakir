import 'package:fazakir/Features/quran/presentation/manager/cubits/quran_cubit/quran_cubit.dart';
import 'package:fazakir/core/widgets/custom_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranViewSearchTextField extends StatelessWidget {
  const QuranViewSearchTextField({
    super.key,
    required TextEditingController searchController,
    required FocusNode focusNode,
  })  : _searchController = searchController,
        _focusNode = focusNode;

  final TextEditingController _searchController;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return CustomSearchTextField(
      controller: _searchController,
      focusNode: _focusNode,
      prefixIcon: IconButton(
        iconSize: 16,
        onPressed: () {
          _searchController.clear();
          context.read<QuranCubit>().filterSurahsWithDebounce('');
          context.read<QuranCubit>().searchInQuranWithIsolateDebounce('');
        },
        icon: const Icon(
          Icons.clear_outlined,
        ),
      ),
      onChanged: (query) {
        context.read<QuranCubit>().filterSurahsWithDebounce(query);
        context.read<QuranCubit>().searchInQuranWithIsolateDebounce(query);
      },
      hintText: 'ابحث برقم او بكلمة (سور, آيات, صفحات)' ' ..... ',
    );
  }
}
