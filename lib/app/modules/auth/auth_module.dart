import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/register/register_page.dart';
import 'package:provider/provider.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(
          routers: {
            '/login': (_) => const LoginPage(),
            '/register': (_) => const RegisterPage(),
          },
          bindings: [
            ChangeNotifierProvider(
              create: (_) => LoginController(),
            ),
            ChangeNotifierProvider(
              create: (_) => RegisterController(),
            ),
          ],
        );
}
