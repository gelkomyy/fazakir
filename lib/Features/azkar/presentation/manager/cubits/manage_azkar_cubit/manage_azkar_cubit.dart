import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
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
      final videos = await azkarRepoImpl.getAzkar();
      safeEmit(FetchAzkarSuccess(azkarCategories: videos));
    } catch (e) {
      safeEmit(
        FetchAzkarFailure(message: 'Failed to load azkar'),
      );
    }
  }
}
