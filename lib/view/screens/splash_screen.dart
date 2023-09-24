import 'dart:async';
import 'package:flutter/material.dart';
import 'package:to_do_app/res/colors.dart';
import 'package:to_do_app/view/components/splash_screen_image.dart';
import 'package:to_do_app/view/screens/todo_list_screen.dart';

class ToDoSplashScreen extends StatefulWidget {
  const ToDoSplashScreen({Key? key}) : super(key: key);
  @override
  State<ToDoSplashScreen> createState() => _ToDoSplashScreenState();
}

class _ToDoSplashScreenState extends State<ToDoSplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    startTimeout();

    super.initState();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, _startApp);
  }

  _startApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const TodoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColors.backgroundDark,
      body: ToDoSplashScreenImage(),
    );
  }
}
