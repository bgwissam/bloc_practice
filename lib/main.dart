import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cubit_bloc_tutorial/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/presentation/router/app_router.dart';
import 'package:flutter_cubit_bloc_tutorial/presentation/screens/second_screen.dart';
import 'package:flutter_cubit_bloc_tutorial/presentation/screens/third_screen.dart';

import 'presentation/screens/home_screen.dart';

void main(List<String> args) async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Bloc Counter Demo',
        theme: ThemeData(
            primarySwatch: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
