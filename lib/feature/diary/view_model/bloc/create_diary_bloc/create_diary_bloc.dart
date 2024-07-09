import 'dart:developer';
import 'dart:io';

import 'package:diary/feature/diary/model/diary_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/diary_repo.dart';

part 'create_diary_event.dart';
part 'create_diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final DiaryRepo _dairyRepo;
  DiaryBloc(this._dairyRepo) : super(DiaryInitialState()) {
    on<CreateDiaryEvent>(_create);
    on<GetDiaryEvent>(_getDiary);

    add(GetDiaryEvent());
  }

  _getDiary(GetDiaryEvent event, Emitter<DiaryState> emit) async {
    try {
      final List<DiaryModel> diaryList = await _dairyRepo.getDiary();
      emit(DiarySuccessState(diaryList: diaryList));
    } catch (e) {
      log(e.toString());
      emit(const DiaryErrorState(""));
    }
  }

  _create(CreateDiaryEvent event, Emitter<DiaryState> emit) async {
    final String id =
        event.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final DiaryModel diaryModel = DiaryModel(
      id: id,
      title: event.title,
      content: event.description,
      date: event.date,
      imagePath: event.image.toString(),
      background: event.background,
    );

    if (event.id == null) {
      try {
        await _dairyRepo.addDiary(diaryModel);
        //  emit(DiarySuccessState());
      } catch (e) {
        emit(const DiaryErrorState(""));
      }
    } else if (event.id != null) {
      try {
        await _dairyRepo.updateDiary(id, diaryModel);
        //  emit(DiarySuccessState());
      } catch (e) {
        emit(const DiaryErrorState(""));
      }
    }
  }
}
