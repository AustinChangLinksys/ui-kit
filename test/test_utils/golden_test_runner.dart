import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

// ✨ 1. 關鍵：將 alchemist 取別名，避免跟我們自己的函式名稱打架
import 'package:alchemist/alchemist.dart' as alchemist;

// 2. 匯出 alchemist 的常用類別，讓測試檔案不用重複 import
export 'package:alchemist/alchemist.dart' hide goldenTest;

/// 定義標準的 Pump 行為 (與 Alchemist 的簽章完全一致)
/// 簽章：(WidgetTester, Widget) -> Future<void>
Future<void> _defaultPumpWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();
}

/// 專案統一的 Golden Test 進入點
Future<void> goldenTest(
  String description, {
  required String fileName,
  required alchemist.GoldenTestGroup Function() builder, // 注意這裡要用別名
  bool skip = false,
  // 使用 alchemist.PumpWidget 確保型別正確
  alchemist.PumpWidget pumpWidget = _defaultPumpWidget,
  double textScaleFactor = 1.0,
}) async {
  // ✨ 3. 呼叫原本套件的 goldenTest
  return alchemist.goldenTest(
    description,
    fileName: fileName,
    builder: builder,
    skip: skip,
    pumpWidget: pumpWidget,
    textScaleFactor: textScaleFactor,
    // 這裡可以加入全域設定，例如 CI 環境的 tag
    // tags: ['golden'],
  );
}
