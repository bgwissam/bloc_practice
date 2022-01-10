import 'package:flutter_cubit_bloc_tutorial/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void main(List<String> args) {
  group('CounterCubit', () {
    CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test(
        'The initial state of the CounterCubit is CounterState(counterValue: 0)',
        () {
      expect(counterCubit.state, CounterState(counterValue: 0));
    });
  });
}
