import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// 引入共用矩陣
import '../../test_utils/test_theme_matrix.dart';

void main() {
  group('AppSurface Logic Tests', () {
    // 1. Matrix 驗證：確保 AppSurface 能正確讀取所有定義好的 Theme
    kTestThemeMatrix.forEach((themeName, themeData) {
      testWidgets('AppSurface correctly maps properties from $themeName',
          (tester) async {
        // 從 ThemeData 中取出 Extension
        final appTheme = themeData.extension<AppDesignTheme>()!;
        final expectedStyle = appTheme.surfaceBase;

        // 渲染 Widget
        await tester.pumpWidget(
            _buildTestApp(themeData, const AppSurface(child: Text('A'))));

        // 找到底層的 Container
        final container =
            tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
        final decoration = container.decoration as BoxDecoration;

        // --- 驗證核心屬性映射 ---

        // 1. 顏色一致性
        expect(decoration.color, expectedStyle.backgroundColor,
            reason: '$themeName: Background color mismatch');

        // 2. 邊框一致性 (如果 Theme 定義了邊框)
        if (expectedStyle.borderWidth > 0) {
          expect(decoration.border?.top.width, expectedStyle.borderWidth,
              reason: '$themeName: Border width mismatch');
          expect(decoration.border?.top.color, expectedStyle.borderColor,
              reason: '$themeName: Border color mismatch');
        }

        // 3. 圓角一致性 (預設矩形模式)
        // 注意：有些主題 (Brutal) 圓角可能為 0
        if (expectedStyle.borderRadius > 0) {
          expect(decoration.borderRadius,
              BorderRadius.circular(expectedStyle.borderRadius),
              reason: '$themeName: Border radius mismatch');
        } else {
          // 如果是 0，可能是 BorderRadius.zero 或 null (視實作而定)，通常檢查 radius.x
          expect(
              (decoration.borderRadius as BorderRadius?)?.topLeft.x ?? 0, 0.0);
        }

        // 4. 陰影一致性 (Neumorphic 特別重要)
        // listEquals 無法直接比較 BoxShadow，這裡簡單檢查長度或第一個元素
        expect(decoration.boxShadow?.length ?? 0, expectedStyle.shadows.length,
            reason: '$themeName: Shadow count mismatch');
      });
    });

    // 2. 變體切換測試 (Variant Logic)
    // 只需要選一個代表性的主題來測邏輯即可 (例如第一個)
    testWidgets('AppSurface switches to Highlight variant correctly',
        (tester) async {
      final themeData = kTestThemeMatrix.values.first;
      final appTheme = themeData.extension<AppDesignTheme>()!;

      await tester.pumpWidget(_buildTestApp(
        themeData,
        const AppSurface(variant: SurfaceVariant.highlight, child: Text('A')),
      ));

      final container =
          tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
      final decoration = container.decoration as BoxDecoration;

      // 驗證它讀取的是 Highlight 而不是 Base
      expect(decoration.color, appTheme.surfaceHighlight.backgroundColor);
      expect(decoration.color, isNot(appTheme.surfaceBase.backgroundColor));
    });

    // 3. 優先權覆寫測試 (Style Override Logic)
    testWidgets('AppSurface style parameter overrides theme variant',
        (tester) async {
      final themeData = kTestThemeMatrix.values.first; // 隨便選一個主題

      // 定義一個與任何主題都不同的「紅色風格」
      const customStyle = SurfaceStyle(
        backgroundColor: Colors.red,
        borderColor: Colors.green,
        borderWidth: 10.0,
        borderRadius: 0,
        shadows: [],
        blurStrength: 0,
        contentColor: Colors.white,
      );

      await tester.pumpWidget(_buildTestApp(
        themeData,
        const AppSurface(
          variant: SurfaceVariant.base, // 應該被忽略
          style: customStyle, // 應該生效
          child: Text('A'),
        ),
      ));

      final container =
          tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
      final decoration = container.decoration as BoxDecoration;

      // 驗證屬性完全來自 customStyle
      expect(decoration.color, Colors.red);
      expect(decoration.border?.top.color, Colors.green);
      expect(decoration.border?.top.width, 10.0);
    });
  });
}

// 輔助函式：注入 Theme
Widget _buildTestApp(ThemeData themeData, Widget child) {
  return MaterialApp(
    theme: themeData,
    home: Scaffold(
      body: child,
    ),
  );
}
