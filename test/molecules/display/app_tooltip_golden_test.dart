import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppTooltip Golden Tests', () {
    kTestThemeMatrix.forEach((themeName, themeData) {
      goldenTest(
        'Tooltip - $themeName',
        fileName: 'app_tooltip_${themeName.toLowerCase()}',
        builder: () => GoldenTestGroup(
          columns: 2,
          children: [
            buildSafeScenario(
              name: 'Text Message',
              theme: themeData,
              width: 260,
              height: 150,
              child: Portal(
                child: Center(
                  child: AppTooltip(
                    message: 'Edit Profile',
                    position: AxisDirection.up,
                    initiallyVisible: true,
                    child: AppIconButton(
                        icon: const Icon(Icons.edit), onTap: () {}),
                  ),
                ),
              ),
            ),

            buildSafeScenario(
              name: 'Rich Components',
              theme: themeData,
              width: 260,
              height: 200,
              child: Portal(
                child: Center(
                  child: AppTooltip(
                    position: AxisDirection.right,
                    initiallyVisible: true,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const AppAvatar(initials: 'AU', size: 32),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.labelMedium('Austin'),
                                AppText.caption('Online', color: Colors.green),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        AppButton(
                          label: 'Message',
                          size: AppButtonSize.small,
                          onTap: () {},
                        ),
                      ],
                    ),
                    child: AppIconButton(
                        icon: const Icon(Icons.person), onTap: () {}),
                  ),
                ),
              ),
            ),

            buildSafeScenario(
              name: 'Image Preview',
              theme: themeData,
              width: 260,
              height: 200,
              child: Portal(
                child: Center(
                  child: AppTooltip(
                    position: AxisDirection.down,
                    initiallyVisible: true,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 120,
                          height: 80,
                          color: Colors.grey.withValues(alpha: 0.3),
                          child: const Icon(Icons.image,
                              size: 40, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        AppText.caption('Preview.jpg'),
                      ],
                    ),
                    child: AppIconButton(
                        icon: const Icon(Icons.image_search), onTap: () {}),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  });
}
