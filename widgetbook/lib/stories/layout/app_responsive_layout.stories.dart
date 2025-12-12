import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'Default',
  type: AppResponsiveLayout,
)
Widget appResponsiveLayoutUseCase(BuildContext context) {
  return AppResponsiveLayout(
    mobile: _buildDemoWidget(
      title: 'Mobile Layout',
      color: Colors.blue.shade100,
      icon: Icons.phone_android,
    ),
    tablet: _buildDemoWidget(
      title: 'Tablet Layout',
      color: Colors.green.shade100,
      icon: Icons.tablet_mac,
    ),
    desktop: _buildDemoWidget(
      title: 'Desktop Layout',
      color: Colors.purple.shade100,
      icon: Icons.desktop_mac,
    ),
  );
}

@UseCase(
  name: 'Without Tablet (Fallback)',
  type: AppResponsiveLayout,
)
Widget appResponsiveLayoutFallbackUseCase(BuildContext context) {
  return AppResponsiveLayout(
    mobile: _buildDemoWidget(
      title: 'Mobile Layout',
      color: Colors.blue.shade100,
      icon: Icons.phone_android,
    ),
    // No tablet widget - will use desktop as fallback
    desktop: _buildDemoWidget(
      title: 'Desktop Layout\n(Also used for Tablet)',
      color: Colors.purple.shade100,
      icon: Icons.desktop_mac,
    ),
  );
}

Widget _buildDemoWidget({
  required String title,
  required Color color,
  required IconData icon,
}) {
  return AppSurface(
    variant: SurfaceVariant.base,
    style: SurfaceStyle(
      backgroundColor: color,
      borderColor: Colors.grey.shade300,
      borderWidth: 2,
      borderRadius: 12,
      contentColor: Colors.black87,
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 64,
          color: Colors.black54,
        ),
        AppGap.md(),
        AppText.headlineSmall(
          title,
          textAlign: TextAlign.center,
        ),
        AppGap.sm(),
        AppText.bodyMedium(
          'Resize the screen to see responsive behavior',
          textAlign: TextAlign.center,
          color: Colors.black54,
        ),
      ],
    ),
  );
}