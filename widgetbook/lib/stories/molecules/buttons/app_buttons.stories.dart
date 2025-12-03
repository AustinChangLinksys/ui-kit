import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

// --- Part 1: AppButton Stories ---

@widgetbook.UseCase(
  name: 'Interactive Playground',
  type: AppButton,
)
Widget buildInteractiveAppButton(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Confirm',
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );

  final variant = context.knobs.object.dropdown<SurfaceVariant>(
    label: 'Variant',
    options: SurfaceVariant.values,
    initialOption: SurfaceVariant.highlight,
    labelBuilder: (val) => val.name,
  );

  final size = context.knobs.object.dropdown<AppButtonSize>(
    label: 'Size',
    options: AppButtonSize.values,
    initialOption: AppButtonSize.medium,
    labelBuilder: (val) => val.name,
  );

  final isLoading = context.knobs.boolean(
    label: 'Is Loading',
    initialValue: false,
  );

  final isEnabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: AppButton(
        label: label,
        onTap: isEnabled ? () {} : null,
        isLoading: isLoading,
        variant: variant,
        size: size,
        icon:
            showIcon ? const Icon(Icons.check_circle_outline, size: 20) : null,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'All States (Static)',
  type: AppButton,
)
Widget buildAppButtonStates(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _Header('Variants'),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              AppButton(
                  label: 'Highlight (Primary)',
                  onTap: () {},
                  variant: SurfaceVariant.highlight),
              AppButton(
                  label: 'Base (Secondary)',
                  onTap: () {},
                  variant: SurfaceVariant.base),
              AppButton(
                  label: 'Elevated (Floating)',
                  onTap: () {},
                  variant: SurfaceVariant.elevated),
            ],
          ),
          const SizedBox(height: 32),
          const _Header('States'),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              AppButton(label: 'Enabled', onTap: () {}),
              const AppButton(label: 'Disabled', onTap: null),
              AppButton(label: 'Loading', onTap: () {}, isLoading: true),
            ],
          ),
          const SizedBox(height: 32),
          const _Header('Sizes'),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              AppButton(
                  label: 'Small', size: AppButtonSize.small, onTap: () {}),
              AppButton(
                  label: 'Medium', size: AppButtonSize.medium, onTap: () {}),
              AppButton(
                  label: 'Large', size: AppButtonSize.large, onTap: () {}),
            ],
          ),
          const SizedBox(height: 32),
          const _Header('With Icon'),
          AppButton(
            label: 'Search',
            icon: const Icon(Icons.search, size: 18),
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

// --- Part 2: AppIconButton Stories ---

@widgetbook.UseCase(
  name: 'Interactive Playground',
  type: AppIconButton,
)
Widget buildInteractiveIconButton(BuildContext context) {
  final variant = context.knobs.object.dropdown<SurfaceVariant>(
    label: 'Variant',
    options: SurfaceVariant.values,
    initialOption: SurfaceVariant.base,
    labelBuilder: (val) => val.name,
  );

  final size = context.knobs.object.dropdown<AppButtonSize>(
    label: 'Size',
    options: AppButtonSize.values,
    initialOption: AppButtonSize.medium,
    labelBuilder: (val) => val.name,
  );

  final isLoading = context.knobs.boolean(
    label: 'Is Loading',
    initialValue: false,
  );

  final isEnabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: AppIconButton(
        onTap: isEnabled ? () {} : null,
        isLoading: isLoading,
        variant: variant,
        size: size,
        icon: const Icon(Icons.settings),
        tooltip: 'Settings',
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'All States (Static)',
  type: AppIconButton,
)
Widget buildIconButtonStates(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32.0),
    child: Center(
      child: Column(
        children: [
          const _Header('Variants'),
          Wrap(
            spacing: 24,
            children: [
              AppIconButton(
                  variant: SurfaceVariant.base,
                  icon: const Icon(Icons.home),
                  onTap: () {}),
              // ✨ Tonal: Secondary actions, toggle states
              AppIconButton(
                  variant: SurfaceVariant.tonal,
                  icon: const Icon(Icons.favorite),
                  onTap: () {}),
              AppIconButton(
                  variant: SurfaceVariant.highlight,
                  icon: const Icon(Icons.add),
                  onTap: () {}),
              AppIconButton(
                  variant: SurfaceVariant.elevated,
                  icon: const Icon(Icons.edit),
                  onTap: () {}),
            ],
          ),
          const SizedBox(height: 32),
          const _Header('Toggle State Example (Tonal)'),
          const Text(
            '✨ Favorite button uses Tonal when selected',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 24,
            children: [
              // Unselected: Base variant
              AppIconButton(
                  variant: SurfaceVariant.base,
                  icon: const Icon(Icons.favorite_border),
                  tooltip: 'Not favorited',
                  onTap: () {}),
              // Selected: Tonal variant
              AppIconButton(
                  variant: SurfaceVariant.tonal,
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  tooltip: 'Favorited',
                  onTap: () {}),
            ],
          ),
          const SizedBox(height: 32),
          const _Header('States'),
          Wrap(
            spacing: 24,
            children: [
              AppIconButton(
                  icon: const Icon(Icons.check), onTap: () {}), // Enabled
              const AppIconButton(
                  icon: Icon(Icons.block), onTap: null), // Disabled
              AppIconButton(
                  icon: const Icon(Icons.refresh),
                  onTap: () {},
                  isLoading: true), // Loading
            ],
          ),
          const SizedBox(height: 32),
          const _Header('Sizes'),
          Wrap(
            spacing: 24,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppIconButton(
                  size: AppButtonSize.small,
                  icon: const Icon(Icons.circle, size: 12),
                  onTap: () {}),
              AppIconButton(
                  size: AppButtonSize.medium,
                  icon: const Icon(Icons.circle, size: 18),
                  onTap: () {}),
              AppIconButton(
                  size: AppButtonSize.large,
                  icon: const Icon(Icons.circle, size: 24),
                  onTap: () {}),
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
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
      ),
    );
  }
}
