import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailingWidget;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailingWidget, // Optional trailing widget
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: theme.cardColor, // Use dynamic background color based on theme
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.iconTheme.color,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodySmall
              ),
            ),
            if (trailingWidget != null) trailingWidget!,
          ],
        ),
      ),
    );
  }
}
