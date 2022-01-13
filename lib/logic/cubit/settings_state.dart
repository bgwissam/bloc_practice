part of 'settings_cubit.dart';

class SettingsState {
  final bool appNotifications;
  final bool emailNotifications;

  SettingsState({this.appNotifications, this.emailNotifications});

  SettingsState copyWith({
    bool appNotifications,
    bool emailNotifications,
  }) {
    return SettingsState(
        appNotifications: appNotifications ?? this.appNotifications,
        emailNotifications: emailNotifications ?? this.emailNotifications);
  }
}

class SettingsInitial extends SettingsState {}
