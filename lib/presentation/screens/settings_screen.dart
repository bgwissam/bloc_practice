import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final notificationSnackBar = SnackBar(
            duration: Duration(milliseconds: 500),
            content: Text(
                'App: ${state.appNotifications} Email: ${state.emailNotifications}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SwitchListTile(
                    value: state.appNotifications,
                    onChanged: (newValue) => context
                        .read<SettingsCubit>()
                        .toggleAppNotifications(newValue),
                    title: Text('App Notification'),
                  ),
                  SwitchListTile(
                    value: state.emailNotifications,
                    onChanged: (newValue) {
                      return context
                          .read<SettingsCubit>()
                          .toggleEmailNotifications(newValue);
                    },
                    title: Text('Email Notification'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
