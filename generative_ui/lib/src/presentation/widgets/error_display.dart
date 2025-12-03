import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorDisplay({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            AppGap.md(),
            AppText.titleMedium('Something went wrong'),
            AppGap.sm(),
            AppText.bodyMedium(
              message,
              textAlign: TextAlign.center,
            ),
            AppGap.lg(),
            AppButton(
              label: 'Retry',
              onTap: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}