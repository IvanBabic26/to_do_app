part of 'to_do_bloc.dart';

abstract class ToDoState extends Equatable {
  final List<ToDo> todoList;
  final int page;
  final String toDoEntry;
  final bool isLoading;
  final bool showToTopButton;
  final ToDoActionType actionType;
  const ToDoState({
    required this.todoList,
    this.page = 1,
    this.toDoEntry = '',
    this.isLoading = false,
    this.showToTopButton = false,
    this.actionType = ToDoActionType.nothing,
  });
  @override
  List<Object?> get props =>
      [todoList, page, toDoEntry, isLoading, showToTopButton, actionType];
}

class ToDoInitialState extends ToDoState {
  const ToDoInitialState(List<ToDo> todoList) : super(todoList: todoList);
}

class ToDoDataState extends ToDoState {
  const ToDoDataState({
    required List<ToDo> todoList,
    required int page,
    required String toDoEntry,
    bool isLoading = false,
    bool showToTopButton = false,
    ToDoActionType actionType = ToDoActionType.nothing,
  }) : super(
          todoList: todoList,
          page: page,
          toDoEntry: toDoEntry,
          isLoading: isLoading,
          showToTopButton: showToTopButton,
          actionType: actionType,
        );
}

class ErrorToDoState extends ToDoState {
  const ErrorToDoState({
    required this.error,
    required List<ToDo> todoList,
  }) : super(todoList: todoList);
  final Exception error;
}
