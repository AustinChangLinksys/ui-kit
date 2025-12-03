import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class LoadingIndicator extends StatelessWidget {
  final String message;

  const LoadingIndicator({
    this.message = 'Thinking...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppLoader(),
          AppGap.md(),
          AppText.bodyMedium(
            message,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}