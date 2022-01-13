import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit_bloc_tutorial/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/logic/cubit/internet_cubit.dart';
import 'package:flutter_cubit_bloc_tutorial/logic/cubit/settings_cubit.dart';
import 'package:flutter_cubit_bloc_tutorial/presentation/router/app_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedStorage _storage = await HydratedStorage.build(
      storageDirectory: await getApplicationSupportDirectory());

  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({Key key, @required this.appRouter, @required this.connectivity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Bloc Counter Demo',
        theme: ThemeData(
            primarySwatch: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
