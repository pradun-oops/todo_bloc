import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/contant/app_route.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => TodoBloc())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.ROUTE_SPLASH,
      routes: AppRoute.getRoute(),
    );
  }
}
