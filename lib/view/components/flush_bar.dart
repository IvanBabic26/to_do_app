import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:to_do_app/res/colors.dart';

class FlushBar {
  static flushBarPositive(BuildContext context, String message) => Flushbar(
        margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        backgroundColor: CustomColors.lightGreen,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        messageText: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: CustomColors.darkGreen,
            ),
            const SizedBox(width: 8.0),
            Expanded(child: Text(message)),
          ],
        ),
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(seconds: 3),
      ).show(context);

  static flushBarNegative(BuildContext context, String message) => Flushbar(
        margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        backgroundColor: CustomColors.lightRed,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        messageText: Row(
          children: [
            const Icon(
              Icons.highlight_remove_outlined,
              color: CustomColors.darkRed,
            ),
            const SizedBox(width: 8.0),
            Expanded(child: Text(message)),
          ],
        ),
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(seconds: 3),
      ).show(context);
}
