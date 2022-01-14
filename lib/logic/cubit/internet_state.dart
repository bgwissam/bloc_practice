part of 'internet_cubit.dart';

class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectivityEnum connectivityType;

  InternetConnected({@required this.connectivityType});

  @override
  String toString() => 'InternetConnected(connectivityType: $connectivityType)';
}

class InternetDisconnected extends InternetState {}
