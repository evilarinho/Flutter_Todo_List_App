import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/core/interface/theme_extension.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 200,
        ),
        Text(
          'Todo List',
          style: context.textTheme.headline6,
        )
      ],
    );
  }
}
