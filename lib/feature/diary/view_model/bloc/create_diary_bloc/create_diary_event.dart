part of 'create_diary_bloc.dart';

sealed class DiaryEvent extends Equatable {
  const DiaryEvent();

  @override
  List<Object> get props => [];
}

class GetDiaryEvent extends DiaryEvent {
  @override
  List<Object> get props => [];
}

final class CreateDiaryEvent extends DiaryEvent {
  final String title;
  final String description;
  final File? image;
  final DateTime date;
  final Color background;
  final String? id;

  const CreateDiaryEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.background,
  });

  @override
  List<Object> get props => [
        title,
        description,
        date,
      ];
}
