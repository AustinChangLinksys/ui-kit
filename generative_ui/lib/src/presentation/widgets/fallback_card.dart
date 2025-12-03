import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'dart:convert';

/// Error type indicator for fallback card display
enum FallbackErrorType {
  /// Component name not found in registry
  unsupported,

  /// Exception occurred during component rendering
  renderingError,
}

/// Fallback widget for unknown or errored components
class FallbackCard extends StatelessWidget {
  /// Type of error this fallback represents
  final FallbackErrorType errorType;

  /// Component name that failed or is unsupported
  final String componentName;

  /// Raw props data from the ToolUseBlock (for debugging)
  final Map<String, dynamic> propsData;

  /// Optional additional error message
  final String? message;

  const FallbackCard({
    required this.errorType,
    required this.componentName,
    this.propsData = const {},
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    
    final errorTypeLabel = errorType == FallbackErrorType.unsupported
        ? 'Unsupported Component'
        : 'Component Error';

    return AppSurface(
      style: theme.surfaceBase, // Use surfaceBase or surfaceSecondary
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error header
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppText.labelMedium(
                    errorTypeLabel,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Component name
            AppText.bodySmall(
              'Component: $componentName',
              color: Colors.grey[700],
            ),
            const SizedBox(height: 8),

            // Message if provided
            if (message != null) ...[
              AppText.bodySmall(
                message!,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 8),
            ],

            // Raw data for debugging
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  _formatJson(propsData),
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Format props data as pretty JSON for display
  String _formatJson(Map<String, dynamic> data) {
    if (data.isEmpty) {
      return '{}';
    }
    try {
      final encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (e) {
      return '{...}';
    }
  }
}