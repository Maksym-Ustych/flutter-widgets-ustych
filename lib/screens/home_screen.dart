import 'package:flutter/material.dart';

import '../utils/app_state.dart';
import '../widgets/animated_counter.dart';
import '../widgets/custom_button.dart';
import '../widgets/profile_widget.dart';

class HomeScreen extends StatelessWidget {
  final AppState appState;

  const HomeScreen({
    super.key,
    required this.appState,
  });

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

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
                _showMessage(
                  context,
                  'Редагування профілю',
                );
              },
            ),
            const SizedBox(height: 16),
            const AnimatedCounter(
              initialValue: 0,
              maxValue: 10,
            ),
            const SizedBox(height: 24),
            Text(
              'CustomButton',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                CustomButton(
                  text: 'Primary',
                  icon: Icons.check,
                  style: CustomButtonStyle.primary,
                  onPressed: () {
                    _showMessage(
                      context,
                      'Primary button',
                    );
                  },
                ),
                CustomButton(
                  text: 'Secondary',
                  icon: Icons.star,
                  style: CustomButtonStyle.secondary,
                  onPressed: () {
                    _showMessage(
                      context,
                      'Secondary button',
                    );
                  },
                ),
                CustomButton(
                  text: 'Danger',
                  icon: Icons.delete,
                  style: CustomButtonStyle.danger,
                  onPressed: () {
                    _showMessage(
                      context,
                      'Danger button',
                    );
                  },
                ),
                CustomButton(
                  text: 'Outline',
                  icon: Icons.info_outline,
                  style: CustomButtonStyle.outline,
                  onPressed: () {
                    _showMessage(
                      context,
                      'Outline button',
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}