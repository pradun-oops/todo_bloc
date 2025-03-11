// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:todo/pages/add_todo.dart';
import 'package:todo/pages/splash_screen.dart';
import 'package:todo/pages/todo_screen.dart';

class AppRoute {
  static const String ROUTE_SPLASH = '/splash_screen';
  static const String ROUTE_TODO_LIST_SCREEN = '/todo_list_screen';
  static const String ROUTUE_ADD_TODO = '/add_todo_screen';

  static Map<String, WidgetBuilder> getRoute() => {
    ROUTE_SPLASH: (context) => SplashScreen(),
    ROUTE_TODO_LIST_SCREEN: (context) => TodoScreen(),
    ROUTUE_ADD_TODO: (context) => AddTodo(),
  };
}
