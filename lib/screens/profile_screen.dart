import 'package:flutter/material.dart';

import '../utils/app_state.dart';
import '../widgets/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  final AppState appState;

  const ProfileScreen({
    super.key,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профіль'),
        centerTitle: true,
      ),
      body: Center(
        child: ProfileWidget(
          user: appState.currentUser,
          onEditPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Редагування профілю'),
              ),
            );
          },
        ),
      ),
    );
  }
}