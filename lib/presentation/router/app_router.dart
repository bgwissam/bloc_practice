import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/logic/cubit/counter_cubit.dart';
import 'package:flutter_cubit_bloc_tutorial/presentation/screens/home_screen.dart';
import 'package:flutter_cubit_bloc_tutorial/presentation/screens/second_screen.dart';
import 'package:flutter_cubit_bloc_tutorial/presentation/screens/third_screen.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) =>
              HomeScreen(title: 'Home Screen', color: Colors.orangeAccent),
        );
        break;
      case '/second':
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: 'Second Screen',
            color: Colors.green,
          ),
        );
        break;
      case '/third':
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: 'Third Screen',
            color: Colors.blueGrey,
          ),
        );
        break;

      default:
        return null;
    }
  }

  void dispose() {}
}
