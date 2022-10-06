import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/login/login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
            child: const Text('/login')),
      ),
    );
  }
}
