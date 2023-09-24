import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app/res/enums/todo_enums.dart';
import 'package:to_do_app/model/model.dart';
import 'package:to_do_app/service/todo_repository.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final ToDoRepository repository;

  ToDoBloc(this.repository) : super(const ToDoInitialState([])) {
    on<GetToDoData>(_onGetToDoData);
    on<CreateToDoEntry>(_onCreateToDoEntry);
    on<SetToDoNotes>(_onSetToDoNotes);
    on<ToggleToDoComplete>(_onToggleToDoComplete);
    on<RemoveToDoEntry>(_onRemoveToDoEntry);
    on<ToggleShowToTopButton>(_onToggleShowToTopButton);
  }

  Future<void> _onGetToDoData(
    GetToDoData event,
    Emitter<ToDoState> emit,
  ) async {
    try {
      if (state.page > 1) {
        emit(
          ToDoDataState(
            todoList: state.todoList,
            page: state.page,
            toDoEntry: state.toDoEntry,
            isLoading: event.isLoading,
            showToTopButton: state.showToTopButton,
          ),
        );
      }

      final dataList = List.of(state.todoList);
      final list = await repository.getToDoData(state.page);
      final int page = state.page + 1;
      dataList.addAll(list);
      emit(
        ToDoDataState(
          todoList: dataList,
          page: page,
          toDoEntry: state.toDoEntry,
          isLoading: false,
          showToTopButton: state.showToTopButton,
        ),
      );
    } catch (e) {
      ErrorToDoState(
        todoList: state.todoList,
        error: Exception(e),
      );
    }
  }

  Future<void> _onCreateToDoEntry(
    CreateToDoEntry event,
    Emitter<ToDoState> emit,
  ) async {
    final dataList = List.of(state.todoList);

    Random random = Random.secure();
    int randomNumber = random.nextInt(1000) + 200;

    dataList.insert(
      0,
      ToDo(
        id: randomNumber,
        userId: 1,
        title: state.toDoEntry,
        completed: false,
      ),
    );

    emit(
      ToDoDataState(
          todoList: dataList,
          page: state.page,
          toDoEntry: state.toDoEntry,
          showToTopButton: state.showToTopButton,
          actionType: ToDoActionType.create),
    );
  }

  Future<void> _onSetToDoNotes(
    SetToDoNotes event,
    Emitter<ToDoState> emit,
  ) async {
    emit(
      ToDoDataState(
        todoList: state.todoList,
        page: state.page,
        toDoEntry: event.text,
      ),
    );
  }

  Future<void> _onToggleToDoComplete(
    ToggleToDoComplete event,
    Emitter<ToDoState> emit,
  ) async {
    final dataList = List.of(state.todoList);
    final ToDo item = event.item.copyWith(completed: event.value);

    var index = dataList.indexWhere((e) => e.id == event.item.id);
    dataList[index] = item;
    emit(
      ToDoDataState(
          todoList: dataList,
          page: state.page,
          toDoEntry: state.toDoEntry,
          showToTopButton: state.showToTopButton),
    );
  }

  Future<void> _onRemoveToDoEntry(
    RemoveToDoEntry event,
    Emitter<ToDoState> emit,
  ) async {
    final dataList = List.of(state.todoList);
    final ToDo item = event.item;
    dataList.remove(item);
    emit(
      ToDoDataState(
        todoList: dataList,
        page: state.page,
        toDoEntry: state.toDoEntry,
        showToTopButton: state.showToTopButton,
        actionType: ToDoActionType.delete,
      ),
    );
  }

  Future<void> _onToggleShowToTopButton(
    ToggleShowToTopButton event,
    Emitter<ToDoState> emit,
  ) async {
    emit(
      ToDoDataState(
        todoList: state.todoList,
        page: state.page,
        toDoEntry: state.toDoEntry,
        showToTopButton: event.value,
      ),
    );
  }
}
