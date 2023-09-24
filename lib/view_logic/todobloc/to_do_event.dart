part of 'to_do_bloc.dart';

abstract class ToDoEvent {
  const ToDoEvent();
}

class GetToDoData extends ToDoEvent {
  final bool isLoading;
  const GetToDoData({this.isLoading = false});

  List<Object> get props => [isLoading];
}

class CreateToDoEntry extends ToDoEvent {
  const CreateToDoEntry();
}

class SetToDoNotes extends ToDoEvent {
  final String text;
  const SetToDoNotes(this.text);

  List<Object> get props => [text];
}

class ToggleToDoComplete extends ToDoEvent {
  final ToDo item;
  final bool value;
  const ToggleToDoComplete({required this.item, required this.value});

  List<Object> get props => [item, value];
}

class RemoveToDoEntry extends ToDoEvent {
  final ToDo item;
  const RemoveToDoEntry({required this.item});

  List<Object> get props => [item];
}

class ToggleShowToTopButton extends ToDoEvent {
  final bool value;
  const ToggleShowToTopButton({this.value = false});

  List<Object> get props => [value];
}
