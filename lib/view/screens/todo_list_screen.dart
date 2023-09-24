import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/view/components/bottom_app_bar.dart';
import 'package:to_do_app/view/components/floating_action_button.dart';
import 'package:to_do_app/view/components/flush_bar.dart';
import 'package:to_do_app/res/enums/todo_enums.dart';
import 'package:to_do_app/res/constants.dart';
import 'package:to_do_app/service/todo_repository.dart';
import 'package:to_do_app/res/colors.dart';
import 'package:to_do_app/view/components/todo_list.dart';
import 'package:to_do_app/view_logic/todobloc/to_do_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late ToDoBloc _toDoBloc;
  final _controller = ScrollController();

  @override
  void initState() {
    _toDoBloc = ToDoBloc(ToDoRepository())..add(const GetToDoData());
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _toDoBloc.add(const GetToDoData(isLoading: true));
      }
      double showOffset = 10.0;

      if (_controller.offset > showOffset) {
        _toDoBloc.add(const ToggleShowToTopButton(value: true));
      } else {
        _toDoBloc.add(const ToggleShowToTopButton(value: false));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _toDoBloc,
      child: BlocConsumer(
        bloc: _toDoBloc,
        listener: (context, state) {
          if (state is ToDoDataState) {
            if (state.actionType == ToDoActionType.create) {
              FlushBar.flushBarPositive(
                context,
                CustomStrings.successfullyCreated,
              );
            } else if (state.actionType == ToDoActionType.delete) {
              FlushBar.flushBarPositive(
                context,
                CustomStrings.successfullyRemoved,
              );
            }
          } else if (state is ErrorToDoState) {
            FlushBar.flushBarNegative(
              context,
              CustomStrings.somethingWentWrong,
            );
          }
        },
        builder: (context, state) {
          final isDataState = state is ToDoDataState;
          return Scaffold(
            backgroundColor: CustomColors.backgroundDark,
            floatingActionButton:
                CustomFloatingActionButton(controller: _controller),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AppBarBottom(controller: _controller),
            body: isDataState
                ? ToDoList(controller: _controller, state: state)
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
