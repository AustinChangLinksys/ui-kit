import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Avatar',
  type: AppAvatar,
)
Widget buildInteractiveAvatar(BuildContext context) {
  final initials = context.knobs.string(
    label: 'Initials',
    initialValue: 'JD',
  );

  final showImage = context.knobs.boolean(
    label: 'Show Image',
    initialValue: true,
  );

  final size = context.knobs.double.slider(
    label: 'Size',
    min: 24,
    max: 120,
    initialValue: 48,
  );

  return Center(
    child: AppAvatar(
      initials: initials,
      size: size,
      imageUrl: showImage ? 'https://i.pravatar.cc/300' : null,
    ),
  );
}

@widgetbook.UseCase(
  name: 'All States (Static)',
  type: AppAvatar,
)
Widget buildAvatarStates(BuildContext context) {
  return const SingleChildScrollView(
    padding: EdgeInsets.all(32.0),
    child: Center(
      child: Column(
        children: [
          _Header('Sizes'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppAvatar(initials: 'S', size: 32),
              AppAvatar(initials: 'M', size: 48),
              AppAvatar(initials: 'L', size: 64),
              AppAvatar(initials: 'XL', size: 96),
            ],
          ),
          SizedBox(height: 32),
          _Header('Image vs Initials (Tonal Fallback)'),
          Text(
            '✨ Fallback now uses Tonal surface - adapts to all themes',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppAvatar(
                initials: 'JD',
                size: 64,
                imageUrl: 'https://i.pravatar.cc/300?img=3',
              ),
              // ✨ Shows Tonal fallback when image fails/unavailable
              AppAvatar(
                initials: 'AB',
                size: 64,
                imageUrl: null, // Fallback with Tonal surface
              ),
              // Different initials, also Tonal fallback
              AppAvatar(
                initials: 'MK',
                size: 64,
                imageUrl: null,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// --- Helper ---
class _Header extends StatelessWidget {
  final String text;
  const _Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
      ),
    );
  }
}
