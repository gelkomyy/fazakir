import 'package:fazakir/Features/ahadith/presentation/manager/cubits/hadith_processing_cubit/hadith_processing_cubit.dart';
import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.context) : super(SearchInitial()) {
    _loadSearchHistory();
  }

  final BuildContext context;
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<List<String>> searchHistoryNotifier = ValueNotifier([]);

  // Load search history from SharedPreferences
  void _loadSearchHistory() {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    List<String>? savedHistory = prefs.getStringList('searchHistory');
    if (savedHistory != null && savedHistory.isNotEmpty) {
      searchHistoryNotifier.value = savedHistory;
    }
  }

  Future<void> _saveSearchHistory() async {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    await prefs.setStringList('searchHistory', searchHistoryNotifier.value);
  }

  // Method to handle search across both Hadith and Zikr entities
  Future<void> searchContent(String? hadithOrZikr) async {
    if (searchController.text.isEmpty || searchController.text.trim().isEmpty) {
      return;
    }

    final String searchQuery = searchController.text;
    emit(SearchLoading());
    addSearchHistory(searchQuery);
    try {
      if (hadithOrZikr == 'ذكر') {
        // Search Zikr
        final SearchResult zikrResults =
            await getIt<AzkarRepoImpl>().filterAzkarItems(searchQuery);

        emit(SearchLoaded(zikrResults));
      } else {
        // Search Hadith
        final SearchResult hadithResults = await context
            .read<HadithProcessingCubit>()
            .filterHadiths(searchQuery);
        emit(SearchLoaded(hadithResults));
      }
    } catch (e) {
      emit(SearchError('Failed to load search results'));
    }
  }

  void removeSearchHistory(String query) {
    if (searchHistoryNotifier.value.contains(query)) {
      final updatedList = List<String>.from(searchHistoryNotifier.value);
      updatedList.remove(query);
      searchHistoryNotifier.value = updatedList;
    }
  }

  void addSearchHistory(String query) {
    if (!searchHistoryNotifier.value.contains(query)) {
      final updatedList = List<String>.from(searchHistoryNotifier.value);
      updatedList.insert(0, query);
      searchHistoryNotifier.value = updatedList;
    }
  }

  @override
  Future<void> close() async {
    searchController.dispose();
    await _saveSearchHistory();
    searchHistoryNotifier.dispose();

    return super.close();
  }
}
