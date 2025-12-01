import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> loadAppFonts() async {
  const packageName = 'ui_kit_library';
  const fontFamily = 'NeueHaasGrotTextRound';

  // define font assets (relative to project root)
  final fontAssets = [
    'assets/fonts/NeueHaasGrotTextRound-55Roman.otf',
    'assets/fonts/NeueHaasGrotTextRound-75Bold.otf',
  ];

  // read font data (ensure we can read it)
  final List<ByteData> fontDataList = [];

  for (final path in fontAssets) {
    final file = File(path);
    if (!file.existsSync()) {
      throw Exception('❌ Font file not found: ${file.absolute.path}');
    }
    final bytes = await file.readAsBytes();
    fontDataList.add(ByteData.view(bytes.buffer));
  }

  // register font loader
  final familyNames = [
    fontFamily, // "NeueHaasGrotTextRound"
    'packages/$packageName/$fontFamily', // "packages/ui_kit_library/NeueHaasGrotTextRound"
    '/packages/$packageName/$fontFamily', // in some environments, a leading slash is required
  ];

  for (final name in familyNames) {
    final loader = FontLoader(name);
    for (final data in fontDataList) {
      // FontLoader.addFont accepts Future, so we need to wrap the data
      // Note: we cannot reuse the same Future, so even though the data source is the same, it is safe to do so
      loader.addFont(Future.value(data));
    }
    await loader.load();
  }

  // load icon font
  await _loadIconFont('LinksysIcons', 'assets/fonts/LinksysIcons.otf');

  // load material icon font
  await _loadMaterialIconFont();
}

Future<void> _loadIconFont(String family, String path) async {
  final file = File(path);
  if (file.existsSync()) {
    final bytes = await file.readAsBytes();
    final loader = FontLoader(family);
    loader.addFont(Future.value(ByteData.view(bytes.buffer)));
    await loader.load();
  }
}

Future<void> _loadMaterialIconFont() async {
  // usually flutter test will handle this, but just in case
}
