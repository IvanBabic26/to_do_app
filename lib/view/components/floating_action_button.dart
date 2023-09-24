import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/res/colors.dart';
import 'package:to_do_app/res/constants.dart';
import 'package:to_do_app/view/components/create_todo_dialog.dart';
import 'package:to_do_app/view_logic/todobloc/to_do_bloc.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key, required this.controller})
      : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: CustomColors.darkGrey,
      onPressed: () async {
        await Dialogs.showActionAlertDialog(
          context,
          child: BlocProvider.value(
            value: context.read<ToDoBloc>(),
            child: AddNewItemDialog(
              dialogTitle: CustomStrings.newToDoEntry,
              negativeButtonText: CustomStrings.cancel,
              positiveButtonText: CustomStrings.save,
              negativeOnTap: () => Navigator.pop(context),
              positiveOnTap: () {
                Navigator.pop(context);
                context.read<ToDoBloc>().add(const CreateToDoEntry());
                controller.jumpTo(0.0);
              },
            ),
          ),
        );
      },
      child: const Icon(
        Icons.add,
        color: CustomColors.white,
      ), //icon inside button
    );
  }
}
