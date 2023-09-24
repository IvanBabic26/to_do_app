import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/res/colors.dart';
import 'package:to_do_app/view_logic/todobloc/to_do_bloc.dart';

class AppBarBottom extends StatelessWidget {
  const AppBarBottom({Key? key, required this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: CustomColors.darkGrey,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder(
                bloc: context.read<ToDoBloc>(),
                builder: (context, state) {
                  final isDataState = state is ToDoDataState;
                  return Icon(
                    Icons.arrow_upward,
                    color: isDataState
                        ? state.showToTopButton
                            ? Colors.white
                            : Colors.transparent
                        : Colors.transparent,
                  );
                },
              ),
            ),
            onTap: () => controller.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ],
      ),
    );
  }
}
