import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/res/colors.dart';
import 'package:to_do_app/res/constants.dart';
import 'package:to_do_app/res/text_styles.dart';
import 'package:to_do_app/view_logic/todobloc/to_do_bloc.dart';

class Dialogs {
  static showActionAlertDialog(BuildContext context, {required Widget child}) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}

class AddNewItemDialog extends StatefulWidget {
  const AddNewItemDialog({
    super.key,
    required this.dialogTitle,
    required this.negativeButtonText,
    required this.positiveButtonText,
    required this.negativeOnTap,
    required this.positiveOnTap,
  });

  final String dialogTitle;
  final String negativeButtonText;
  final String positiveButtonText;
  final Function() negativeOnTap;
  final Function() positiveOnTap;

  @override
  State<AddNewItemDialog> createState() => _AddNewItemDialogState();
}

class _AddNewItemDialogState extends State<AddNewItemDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController()
      ..addListener(
        () => context.read<ToDoBloc>().add(SetToDoNotes(_controller.text)),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<ToDoBloc>(),
      builder: (context, state) {
        if (state is ToDoDataState) {
          return Dialog(
            insetPadding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: CustomColors.backgroundDark,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.dialogTitle, style: kDialogTitleTextStyle),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _controller,
                    maxLines: 5,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: CustomColors.lightGrey,
                      hintText: CustomStrings.addToDoNotes,
                      hintStyle: kHintTextStyle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          foregroundColor: CustomColors.white,
                        ),
                        onPressed: widget.negativeOnTap,
                        child: Text(
                          widget.negativeButtonText,
                          style: kButtonTextStyle,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: CustomColors.darkGrey,
                          disabledForegroundColor: CustomColors.lightGrey,
                        ),
                        onPressed: _controller.text.isNotEmpty
                            ? widget.positiveOnTap
                            : null,
                        child: Text(widget.positiveButtonText),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class RemoveToDoItem extends StatefulWidget {
  const RemoveToDoItem({
    super.key,
    required this.negativeOnTap,
    required this.positiveOnTap,
  });

  final Function() negativeOnTap;
  final Function() positiveOnTap;

  @override
  State<RemoveToDoItem> createState() => _RemoveToDoItemState();
}

class _RemoveToDoItemState extends State<RemoveToDoItem> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: CustomColors.backgroundDark,
      title: const Text(CustomStrings.removeToDoEntryDialogTitle,
          style: kDialogTitleTextStyle),
      content: const Text(
        CustomStrings.deleteEntryDialogBody,
        style: kDialogBodyTextStyle,
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: CustomColors.white,
          ),
          onPressed: widget.negativeOnTap,
          child: const Text(
            CustomStrings.cancel,
            style: kButtonTextStyle,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: CustomColors.darkGrey,
            disabledForegroundColor: CustomColors.lightGrey,
          ),
          onPressed: widget.positiveOnTap,
          child: const Text(
            CustomStrings.remove,
            style: kButtonTextStyle,
          ),
        ),
      ],
    );
  }
}
