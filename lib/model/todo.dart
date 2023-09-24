part of 'model.dart';

@JsonSerializable(explicitToJson: true)
class ToDo extends Equatable {
  final int? userId;
  final int? id;
  final String? title;
  final bool completed;

  const ToDo({this.userId, this.id, this.title, this.completed = false});

  @override
  List<Object?> get props => [userId, id, title, completed];

  factory ToDo.fromJson(Map<String, dynamic> map) => _$ToDoFromJson(map);

  static List<ToDo>? listFromJson(List<dynamic>? list) {
    if (list == null) {
      return <ToDo>[];
    } else {
      return list.map<ToDo>((dynamic e) => ToDo.fromJson(e)).toList();
    }
  }

  ToDo copyWith({int? userId, int? id, String? title, bool? completed}) {
    return ToDo(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
