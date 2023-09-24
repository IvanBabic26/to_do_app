import 'package:flutter/material.dart';

class ToDoSplashScreenImage extends StatelessWidget {
  const ToDoSplashScreenImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/to_do_nothing.png',
        scale: 1,
        fit: BoxFit.fill,
      ),
    );
  }
}
