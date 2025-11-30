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
  // 1. 內容 Knobs
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Confirm',
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );

  // 2. 樣式與尺寸 Knobs
  final variant = context.knobs.list<SurfaceVariant>(
    label: 'Variant',
    options: SurfaceVariant.values,
    initialOption: SurfaceVariant.highlight,
    labelBuilder: (val) => val.name,
  );

  final size = context.knobs.list<AppButtonSize>(
    label: 'Size',
    options: AppButtonSize.values,
    initialOption: AppButtonSize.medium,
    labelBuilder: (val) => val.name,
  );

  // 3. 狀態 Knobs
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
          _Header('Variants'),
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
          _Header('States'),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              AppButton(label: 'Enabled', onTap: () {}),
              AppButton(label: 'Disabled', onTap: null),
              AppButton(label: 'Loading', onTap: () {}, isLoading: true),
            ],
          ),
          const SizedBox(height: 32),
          _Header('Sizes'),
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
          _Header('With Icon'),
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
  final variant = context.knobs.list<SurfaceVariant>(
    label: 'Variant',
    options: SurfaceVariant.values,
    initialOption: SurfaceVariant.base,
    labelBuilder: (val) => val.name,
  );

  final size = context.knobs.list<AppButtonSize>(
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
          _Header('Variants'),
          Wrap(
            spacing: 24,
            children: [
              AppIconButton(
                  variant: SurfaceVariant.base,
                  icon: const Icon(Icons.home),
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
          _Header('States'),
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
          _Header('Sizes'),
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
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
      ),
    );
  }
}
