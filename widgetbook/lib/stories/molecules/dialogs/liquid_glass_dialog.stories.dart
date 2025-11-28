import 'dart:ui'; // 為了 ImageFilter
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Alert Dialog (Popup)',
  type: LiquidGlassDialog,
)
Widget buildLiquidGlassDialogPopup(BuildContext context) {
  final titleText =
      context.knobs.string(label: 'Title', initialValue: 'Glass Alert');
  final contentText = context.knobs.string(
      label: 'Content',
      initialValue:
          'This is a standard alert dialog using our glass material. Notice how it floats above the content.');

  // 讓使用者可以調整背景模糊度
  final backdropBlur = context.knobs.double
      .slider(label: 'Backdrop Blur', initialValue: 3.0, min: 0.0, max: 10.0);

  return Center(
    child: FilledButton(
      child: const Text('Show Alert Dialog'),
      onPressed: () {
        showGeneralDialog(
          context: context,
          useRootNavigator: false,
          barrierDismissible: true,
          barrierLabel: 'Dismiss',
          barrierColor: Colors.black.withOpacity(0.3), // 背景遮罩顏色

          // 關鍵：使用 BackdropFilter 讓背景也模糊，提升質感
          pageBuilder: (context, anim1, anim2) {
            return BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: backdropBlur, sigmaY: backdropBlur),
              child: Center( // 新增: 居中 Dialog
                child: Padding( // 新增: Dialog 的外邊距
                  padding: const EdgeInsets.all(24.0),
                  child: LiquidGlassDialog(
                    title: Text(titleText),
                    content: Text(
                      contentText,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          // 加入簡單的縮放動畫
          transitionBuilder: (context, anim1, anim2, child) {
            return Transform.scale(
              scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack)
                  .value,
              child: Opacity(
                opacity: anim1.value,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Alert Dialog Style',
  type: LiquidGlassDialog,
)
Widget buildLiquidGlassDialogAlert(BuildContext context) {
  final titleText =
      context.knobs.string(label: 'Title', initialValue: 'Important Alert');
  final contentText = context.knobs.string(
      label: 'Content',
      initialValue:
          'This is a crucial message for the user. Please pay attention to the details provided below.');

  final showActions = context.knobs.boolean(label: 'Show Actions', initialValue: true);

  return Center(
    child: LiquidGlassDialog(
      title: Text(titleText),
      content: Text(
        contentText,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: showActions
          ? [
              TextButton(
                onPressed: () {}, // For story, no actual action
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {}, // For story, no actual action
                child: const Text('Confirm'),
              ),
            ]
          : null,
    ),
  );
}

