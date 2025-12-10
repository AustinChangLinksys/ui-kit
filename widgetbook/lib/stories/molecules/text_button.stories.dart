import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook use cases for AppButton.text() component
///
/// Demonstrates all AppButton.text() variations including:
/// - Different sizes (small, medium, large)
/// - States (enabled, disabled, loading)
/// - Icon configurations (leading, trailing, none)
/// - Interactive behaviors across all themes

@widgetbook.UseCase(
  name: 'Default',
  type: AppButton,
)
Widget appTextButtonUseCase(BuildContext context) {
  return Center(
    child: AppButton.text(
      label: context.knobs.string(
        label: 'Text',
        initialValue: 'Text Button',
      ),
      size: context.knobs.object.dropdown(
        label: 'Size',
        options: AppButtonSize.values,
        initialOption: AppButtonSize.medium,
      ),
      icon: context.knobs.boolean(label: 'Has Icon', initialValue: false)
        ? Icon(context.knobs.object.dropdown(
            label: 'Icon',
            options: [
              Icons.add,
              Icons.arrow_forward,
              Icons.save,
              Icons.send,
              Icons.download,
              Icons.favorite,
              Icons.share,
              Icons.edit,
              Icons.delete,
            ],
            initialOption: Icons.arrow_forward,
          ))
        : null,
      iconPosition: context.knobs.object.dropdown(
        label: 'Icon Position',
        options: AppButtonIconPosition.values,
        initialOption: AppButtonIconPosition.leading,
      ),
      isLoading: context.knobs.boolean(
        label: 'Loading',
        initialValue: false,
      ),
      onTap: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ) ? () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Text button tapped!')),
        );
      } : null,
    ),
  );
}

@widgetbook.UseCase(
  name: 'All Sizes',
  type: AppButton,
)
Widget appTextButtonSizesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton.text(
          label: 'Small Text Button',
          size: AppButtonSize.small,
          onTap: () {},
        ),
        AppGap.md(),
        AppButton.text(
          label: 'Medium Text Button',
          size: AppButtonSize.medium,
          onTap: () {},
        ),
        AppGap.md(),
        AppButton.text(
          label: 'Large Text Button',
          size: AppButtonSize.large,
          onTap: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Icons',
  type: AppButton,
)
Widget appTextButtonIconsUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton.text(
          label: 'Leading Icon',
          icon: const Icon(Icons.arrow_forward),
          iconPosition: AppButtonIconPosition.leading,
          onTap: () {},
        ),
        AppGap.md(),
        AppButton.text(
          label: 'Trailing Icon',
          icon: const Icon(Icons.arrow_forward),
          iconPosition: AppButtonIconPosition.trailing,
          onTap: () {},
        ),
        AppGap.md(),
        AppButton.text(
          label: 'Save Document',
          icon: const Icon(Icons.save),
          size: AppButtonSize.large,
          onTap: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'States',
  type: AppButton,
)
Widget appTextButtonStatesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton.text(
          label: 'Enabled Button',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Button tapped!')),
            );
          },
        ),
        AppGap.md(),
        const AppButton.text(
          label: 'Disabled Button',
          onTap: null,
        ),
        AppGap.md(),
        AppButton.text(
          label: 'Loading Button',
          isLoading: true,
          onTap: () {},
        ),
        AppGap.md(),
        AppButton.text(
          label: 'Loading with Icon',
          icon: const Icon(Icons.send),
          isLoading: true,
          onTap: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive Demo',
  type: AppButton,
)
Widget appTextButtonInteractiveUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        AppButton.text(
          label: 'Primary Action',
          onTap: () => _showSnackBar(context, 'Primary action executed'),
        ),
        AppButton.text(
          label: 'Secondary',
          size: AppButtonSize.small,
          onTap: () => _showSnackBar(context, 'Secondary action executed'),
        ),
        AppButton.text(
          label: 'With Icon',
          icon: const Icon(Icons.favorite),
          onTap: () => _showSnackBar(context, 'Favorite added!'),
        ),
        AppButton.text(
          label: 'Share',
          icon: const Icon(Icons.share),
          iconPosition: AppButtonIconPosition.trailing,
          onTap: () => _showSnackBar(context, 'Share dialog opened'),
        ),
        AppButton.text(
          label: 'Download',
          icon: const Icon(Icons.download),
          size: AppButtonSize.large,
          onTap: () => _showSnackBar(context, 'Download started'),
        ),
        const AppButton.text(
          label: 'Disabled',
          onTap: null,
        ),
      ],
    ),
  );
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}