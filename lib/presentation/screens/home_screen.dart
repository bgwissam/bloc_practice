import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/constants/enum.dart';
import 'package:flutter_cubit_bloc_tutorial/constants/text_style.dart';
import 'package:flutter_cubit_bloc_tutorial/logic/cubit/counter_cubit.dart';
import 'package:flutter_cubit_bloc_tutorial/logic/cubit/internet_cubit.dart';
import 'package:flutter_cubit_bloc_tutorial/presentation/screens/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.title, this.color}) : super(key: key);
  final String title;
  final Color color;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext blocContext) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (listenerContext, state) {
        if (state is InternetConnected &&
            state.connectivityType == ConnectivityEnum.Wifi) {
          listenerContext.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectivityType == ConnectivityEnum.Mobile) {
          listenerContext.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: widget.color,
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                icon: Icon(Icons.settings))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectivityType == ConnectivityEnum.Wifi) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'WIFI',
                        style: textStyle1.copyWith(color: Colors.green),
                      ),
                    ),
                  );
                } else if (state is InternetConnected &&
                    state.connectivityType == ConnectivityEnum.Mobile) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Text('MOBILE',
                          style: textStyle1.copyWith(color: Colors.amber)),
                    ),
                  );
                } else if (state is InternetDisconnected) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Text('DISCONNECTED',
                          style: textStyle1.copyWith(color: Colors.grey)),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
              Text('You have pushed the button to many fucking times'),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Increment'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Decrement'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'Oh, negative number no - ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                      softWrap: true,
                    );
                  } else if (state.counterValue % 10 == 0) {
                    return Text('Oh...at tenth number: ${state.counterValue}',
                        style: Theme.of(context).textTheme.headline4);
                  } else if (state.counterValue % 2 == 0) {
                    return Text('Yey, even number - ${state.counterValue}',
                        style: Theme.of(context).textTheme.headline4);
                  }
                  return Text(state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4);
                },
              ),
              SizedBox(
                height: 20,
              ),
              //testing bloc.watch function
              Builder(builder: (context) {
                final _counterState = context.watch<CounterCubit>().state;
                final _internetState = context.watch<InternetCubit>().state;
                if (_internetState is InternetConnected &&
                    _internetState.connectivityType == ConnectivityEnum.Wifi) {
                  return Text(
                      'Counter: ${_counterState.counterValue} Internet: WIFI',
                      style: textStyle1);
                } else if (_internetState is InternetConnected &&
                    _internetState.connectivityType ==
                        ConnectivityEnum.Mobile) {
                  return Text(
                      'Counter: ${_counterState.counterValue} Internet: MOBILE',
                      style: textStyle1);
                } else if (_internetState is InternetDisconnected) {
                  return Text(
                      'Counter: ${_counterState.counterValue} Internet: DISCONNECTED',
                      style: textStyle1);
                } else {
                  return Text(
                      'Counter: ${_counterState.counterValue} Internet: Unknown',
                      style: textStyle1);
                }
              }),
              SizedBox(
                height: 20,
              ),
              //testing block select function
              Builder(builder: (context) {
                final _counterValue = context
                    .select((CounterCubit cubit) => cubit.state.counterValue);
                return Text('Counter $_counterValue', style: textStyle1);
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: 'btn1',
                    onPressed: () {
                      blocContext.read<CounterCubit>().decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: 'btn2',
                    onPressed: () {
                      blocContext.read<CounterCubit>().increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  )
                ],
              ),
              SizedBox(height: 15),
              MaterialButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/second');
                },
                color: widget.color,
                child: Text('Go to second screen'),
              ),
              SizedBox(height: 15),
              MaterialButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/third');
                },
                color: widget.color,
                child: Text('Go to Third screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
