import 'package:flutter/services.dart';

class AppFeedback {
  static Future<void> onInteraction() async {
    await HapticFeedback.lightImpact();
    await SystemSound.play(SystemSoundType.click);
  }

  static Future<void> onSuccess() async {
    await HapticFeedback.mediumImpact();
  }

  static Future<void> onError() async {
    await HapticFeedback.heavyImpact();
    await SystemSound.play(SystemSoundType.alert);
  }

  static Future<void> onSelection() async {
    await HapticFeedback.selectionClick();
  }
}
