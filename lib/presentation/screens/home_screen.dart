import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/logic/cubit/counter_cubit.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
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
    );
  }
}
