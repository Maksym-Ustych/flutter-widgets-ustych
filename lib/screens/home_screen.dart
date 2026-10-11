import 'package:flutter/material.dart';

import '../widgets/animated_counter.dart';
import '../widgets/custom_button.dart';
import '../widgets/profile_widget.dart';
import '../utils/app_state.dart';

class HomeScreen extends StatelessWidget {
  final AppState appState;

  const HomeScreen({
    super.key,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Головна'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileWidget(
              user: appState.currentUser,
              onEditPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Редагування профілю'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const AnimatedCounter(
              initialValue: 0,
              maxValue: 10,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Основна кнопка',
              icon: Icons.check,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Кнопку натиснуто'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}