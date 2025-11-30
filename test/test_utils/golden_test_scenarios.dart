// test/test_utils/golden_test_scenarios.dart

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';

/// 專案統一的 Golden Test 場景建構器
///
/// 特性：
/// 1. 強制尺寸限制 (SizedBox) - 防止 Layout Overflow / Infinite Size
/// 2. 自動注入背景色 (ColoredBox) - 確保 Glass/Neumorphic 可見
/// 3. 自動注入主題 (Theme)
/// 4. 預設禁用動畫 (TickerMode) - 防止 Skeleton/Loading 導致 Timeout
GoldenTestScenario buildSafeScenario({
  required String name,
  required ThemeData theme,
  required Widget child,
  double width = 200.0, // 預設給予寬裕的空間
  double height = 100.0,
  bool disableAnimation = true, // 預設關閉動畫，保證測試穩定
}) {
  return GoldenTestScenario(
    name: name,
    child: SizedBox(
      width: width,
      height: height,
      child: ColoredBox(
        color: theme.scaffoldBackgroundColor,
        child: Theme(
          data: theme,
          child: Center(
            child: TickerMode(
              enabled: !disableAnimation,
              child: child,
            ),
          ),
        ),
      ),
    ),
  );
}
