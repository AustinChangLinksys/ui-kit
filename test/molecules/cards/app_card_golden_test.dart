import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppCard Golden Tests', () {
    goldenTest(
      'renders correctly in different themes',
      fileName: 'app_card_themes',
      builder: () => GoldenTestGroup(
        children: [
          // Glass Themes
          GoldenTestScenario(
            name: 'Glass Light',
            child: Theme(
              data: ThemeData(extensions: [GlassDesignTheme.light()]),
              child: const AppCard(
                width: 100,
                height: 100,
                child: Center(child: Text('Glass Light')),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'Glass Dark',
            child: Theme(
              data: ThemeData(extensions: [GlassDesignTheme.dark()]),
              child: const AppCard(
                width: 100,
                height: 100,
                child: Center(child: Text('Glass Dark')),
              ),
            ),
          ),
          // Brutal Themes
          GoldenTestScenario(
            name: 'Brutal Light',
            child: Theme(
              data: ThemeData(extensions: [BrutalDesignTheme.light()]),
              child: const AppCard(
                width: 100,
                height: 100,
                child: Center(child: Text('Brutal Light')),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'Brutal Dark',
            child: Theme(
              data: ThemeData(extensions: [BrutalDesignTheme.dark()]),
              child: const AppCard(
                width: 100,
                height: 100,
                child: Center(child: Text('Brutal Dark')),
              ),
            ),
          ),
          // Flat Themes
          GoldenTestScenario(
            name: 'Flat Light',
            child: Theme(
              data: ThemeData(extensions: [FlatDesignTheme.light()]),
              child: const AppCard(
                width: 100,
                height: 100,
                child: Center(child: Text('Flat Light')),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'Flat Dark',
            child: Theme(
              data: ThemeData(extensions: [FlatDesignTheme.dark()]),
              child: const AppCard(
                width: 100,
                height: 100,
                child: Center(child: Text('Flat Dark')),
              ),
            ),
          ),
          // Neumorphic Themes
          GoldenTestScenario(
            name: 'Neumorphic Light',
            child: Theme(
              data: ThemeData(extensions: [NeumorphicDesignTheme.light()]),
              child: const AppCard(
                width: 100,
                height: 100,
                child: Center(child: Text('Neumorphic Light')),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'Neumorphic Dark',
            child: Theme(
              data: ThemeData(extensions: [NeumorphicDesignTheme.dark()]),
              child: const AppCard(
                width: 100,
                height: 100,
                child: Center(child: Text('Neumorphic Dark')),
              ),
            ),
          ),
        ],
      ),
    );
  });
}
