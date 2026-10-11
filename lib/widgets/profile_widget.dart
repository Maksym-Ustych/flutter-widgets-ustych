import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;
  final VoidCallback? onEditPressed;
  final bool isCompact;

  const ProfileWidget({
    super.key,
    required this.user,
    this.onEditPressed,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isCompact
            ? Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildUserInfo(theme),
                  ),
                  if (onEditPressed != null)
                    IconButton(
                      onPressed: onEditPressed,
                      icon: const Icon(Icons.edit),
                    ),
                ],
              )
            : Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  const SizedBox(height: 12),
                  _buildUserInfo(theme),
                  if (onEditPressed != null) ...[
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: onEditPressed,
                      icon: const Icon(Icons.edit),
                      label: const Text('Редагувати'),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment:
          isCompact ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          user.name,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}