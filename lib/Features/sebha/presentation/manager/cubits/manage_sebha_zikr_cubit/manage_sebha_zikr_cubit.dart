import 'package:fazakir/Features/sebha/data/models/sebha_zikr_model.dart';
import 'package:fazakir/Features/sebha/data/repos/sebha_zikr_repo.dart';
import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_sebha_zikr_state.dart';

class ManageSebhaZikrCubit extends Cubit<ManageSebhaZikrState> {
  ManageSebhaZikrCubit() : super(ManageSebhaZikrInitial());
  final GlobalKey<FormState> formKeyAdd = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyEdit = GlobalKey<FormState>();
  final TextEditingController textAddZikr = TextEditingController();
  final TextEditingController textAddZikrCount = TextEditingController();
  String? editZikr;
  int? editZikrCount;

  void getSebhaZikr() {
    safeEmit(ManageSebhaZikrLoading());
    final List<SebhaZikrModel> data = SebhaZikrRepo.getZikrs();
    safeEmit(GetAzkarSuccess(azkar: data));
  }

  Future<void> addSebhaZikr(SebhaZikrModel zikrModel) async {
    safeEmit(ManageSebhaZikrLoading());
    await SebhaZikrRepo.addZikr(zikrModel);
    getSebhaZikr();
  }

  Future<void> addDefaultSebhaZikr() async {
    final List<SebhaZikrModel> defaultZikrs = [
      SebhaZikrModel(
        zikr: 'سبحانَ اللهِ',
        count: 33,
      ),
      SebhaZikrModel(
        zikr: 'الحمدُ للهِ',
        count: 33,
      ),
      SebhaZikrModel(
        zikr: 'لَا إلهَ إلَّا اللهِ',
        count: 33,
      ),
      SebhaZikrModel(
        zikr: 'اللهُ أكبرُ',
        count: 33,
      ),
      SebhaZikrModel(
        zikr: 'لا حَوْلَ ولَا قُوَّةَ إلَّا باللَّهِ',
        count: 33,
      ),
    ];
    safeEmit(ManageSebhaZikrLoading());
    for (var zikr in defaultZikrs) {
      await SebhaZikrRepo.addZikr(zikr);
    }
    getSebhaZikr();
  }

  Future<void> updateSebhaZikr(int id, SebhaZikrModel zikrModel) async {
    safeEmit(ManageSebhaZikrLoading());
    await SebhaZikrRepo.updateZikr(id, zikrModel);
    getSebhaZikr();
  }

  Future<void> deleteSebhaZikr(int id) async {
    safeEmit(ManageSebhaZikrLoading());
    await SebhaZikrRepo.deleteZikr(id);
    getSebhaZikr();
  }

  void clear() {
    textAddZikr.clear();
    textAddZikrCount.clear();
    formKeyAdd.currentState?.reset();
    formKeyEdit.currentState?.reset();
  }

  @override
  Future<void> close() async {
    textAddZikr.clear();
    textAddZikrCount.clear();
    formKeyAdd.currentState?.reset();
    formKeyEdit.currentState?.reset();
    super.close();
  }
}
