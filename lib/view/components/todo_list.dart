import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/model/model.dart';
import 'package:to_do_app/res/colors.dart';
import 'package:to_do_app/res/text_styles.dart';
import 'package:to_do_app/view/components/create_todo_dialog.dart';
import 'package:to_do_app/view_logic/todobloc/to_do_bloc.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({Key? key, required this.controller, required this.state})
      : super(key: key);

  final ScrollController controller;
  final ToDoDataState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ToDoBloc>();
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          ListView.builder(
            itemCount: state.todoList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final ToDo item = state.todoList[index];
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      color: item.completed
                          ? CustomColors.lightGreen
                          : CustomColors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title ?? '',
                            style: kToDoCardTextStyle,
                          ),
                        ),
                        Checkbox(
                          value: item.completed,
                          onChanged: (value) => bloc.add(
                            ToggleToDoComplete(
                              item: item,
                              value: value!,
                            ),
                          ),
                          fillColor: MaterialStateProperty.resolveWith(
                            (Set states) {
                              if (states.contains(MaterialState.selected)) {
                                return CustomColors.darkGreen;
                              }
                              return CustomColors.lightGrey;
                            },
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 10,
                    child: InkWell(
                      onTap: () => Dialogs.showActionAlertDialog(
                        context,
                        child: BlocProvider.value(
                          value: bloc,
                          child: RemoveToDoItem(
                            negativeOnTap: () => Navigator.pop(context),
                            positiveOnTap: () {
                              Navigator.pop(context);
                              bloc.add(
                                RemoveToDoEntry(item: item),
                              );
                            },
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 18,
                        color: item.completed
                            ? CustomColors.white
                            : CustomColors.lightGrey,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          state.isLoading
              ? Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
