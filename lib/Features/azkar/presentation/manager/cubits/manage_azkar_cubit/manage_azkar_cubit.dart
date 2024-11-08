import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
import 'package:fazakir/Features/azkar/domain/entities/ruqyah_entity.dart';
import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'manage_azkar_state.dart';

class ManageAzkarCubit extends Cubit<ManageAzkarState> {
  ManageAzkarCubit(this.azkarRepoImpl) : super(ManageAzkarInitial());
  final AzkarRepoImpl azkarRepoImpl;

  Future<void> fetchAzkar() async {
    try {
      safeEmit(FetchAzkarLoading());
      final azkar = await azkarRepoImpl.getAzkarCategories();
      safeEmit(FetchAzkarSuccess(azkarCategories: azkar));
    } catch (e) {
      safeEmit(
        FetchAzkarFailure(message: 'Failed to load azkar'),
      );
    }
  }

  Future<void> fetchRuqyah() async {
    try {
      safeEmit(FetchAzkarLoading());
      final ruqyahZikrs = await azkarRepoImpl.fetchRuqyah();
      safeEmit(FetchRuqyahSuccess(ruqyahZikrs: ruqyahZikrs));
    } catch (e) {
      safeEmit(
        FetchAzkarFailure(message: 'Failed to load ruqyah'),
      );
    }
  }

  Future<void> fetchRandomZikr() async {
    try {
      safeEmit(FetchAzkarLoading());
      final zikr = await azkarRepoImpl.getRandomAzkarCategory();
      safeEmit(FetchAzkarSuccess(azkarCategories: [zikr]));
    } catch (e) {
      safeEmit(
        FetchAzkarFailure(message: 'Failed to load zikr'),
      );
    }
  }
}
