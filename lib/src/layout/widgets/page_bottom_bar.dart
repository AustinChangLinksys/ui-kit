import 'package:flutter/material.dart';
import '../../atoms/surfaces/app_surface.dart';
import '../../atoms/layout/app_gap.dart';
import '../../molecules/buttons/app_button.dart';
import '../../foundation/theme/tokens/app_spacing.dart';
import '../models/page_bottom_bar_config.dart';

/// A Constitution-compliant bottom action bar for AppPageView.
///
/// This widget extracts the bottom bar rendering logic from AppPageView
/// to improve maintainability and testability.
///
/// Constitution Compliance:
/// - §3.3: Uses AppSpacing tokens instead of hardcoded values
/// - §6.1: Uses AppSurface for visual container
/// - §6.2: Dumb component - receives data via constructor, passes events via callback
class PageBottomBar extends StatelessWidget {
  /// Configuration for the bottom bar actions
  final PageBottomBarConfig config;

  const PageBottomBar({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      variant: SurfaceVariant.base,
      // Use AppSpacing.lg (16) instead of hardcoded value (§3.3)
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          if (config.negativeLabel != null)
            Expanded(
              child: AppButton.secondary(
                onTap: (config.isNegativeEnabled ?? true)
                    ? config.onNegativeTap
                    : null,
                label: config.negativeLabel!,
              ),
            ),
          if (config.negativeLabel != null && config.positiveLabel != null)
            AppGap.lg(),
          if (config.positiveLabel != null)
            Expanded(
              child: AppButton.primary(
                onTap: config.isPositiveEnabled ? config.onPositiveTap : null,
                label: config.positiveLabel!,
              ),
            ),
        ],
      ),
    );
  }
}
