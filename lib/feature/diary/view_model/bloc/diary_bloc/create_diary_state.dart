part of 'create_diary_bloc.dart';

sealed class DiaryState extends Equatable {
  const DiaryState();

  @override
  List<Object> get props => [];
}

final class DiaryInitialState extends DiaryState {}

final class DiarySuccessState extends DiaryState {
  final List<DiaryModel> diaryList;

  const DiarySuccessState({required this.diaryList});

  @override
  List<Object> get props => [diaryList];
}

final class DiaryErrorState extends DiaryState {
  final String message;

  const DiaryErrorState(this.message);

  @override
  List<Object> get props => [message];
}
