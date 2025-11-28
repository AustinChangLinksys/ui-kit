import 'package:flutter/material.dart';
import '../../atoms/surfaces/app_surface.dart';

class AppDialog extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final List<Widget>? actions;

  const AppDialog({
    super.key,
    this.title,
    required this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AppSurface(
          variant: SurfaceVariant.elevated,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleLarge!,
                  child: title!,
                ),
                const SizedBox(height: 16),
              ],
              content,
              if (actions != null) ...[
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!.map((action) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: action,
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
