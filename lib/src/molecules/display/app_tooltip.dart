import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppTooltip extends StatefulWidget {
  const AppTooltip({
    required this.child,
    this.message,
    this.content,
    this.position = AxisDirection.up,
    this.offset,
    this.maxWidth = 250.0,
    this.maxHeight,
    this.padding,
    this.initiallyVisible = false,
    this.visible,
    super.key,
  }) : assert(message != null || content != null,
            'Must provide message or content');

  final Widget child;
  final String? message;
  final Widget? content;
  final AxisDirection position;
  final Offset? offset;
  final double maxWidth;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;

  /// Initial visibility state (used when [visible] is null)
  final bool initiallyVisible;

  /// External visibility control. When non-null, overrides internal state.
  /// Use this for programmatic control (e.g., show on focus, show on error).
  final bool? visible;

  @override
  State<AppTooltip> createState() => _AppTooltipState();
}

class _AppTooltipState extends State<AppTooltip> {
  bool _isVisible = false;

  static const double _kDefaultGap = 8.0;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.initiallyVisible;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    // External visibility overrides internal state
    final isVisible = widget.visible ?? _isVisible;

    return MouseRegion(
      onEnter: (_) => setState(() => _isVisible = true),
      onExit: (_) => setState(() => _isVisible = false),
      child: GestureDetector(
        onLongPress: () => setState(() => _isVisible = true),
        onLongPressUp: () => setState(() => _isVisible = false),
        // Support tap to toggle for touch devices
        onTap: widget.visible == null
            ? () => setState(() => _isVisible = !_isVisible)
            : null,

        child: PortalTarget(
          visible: isVisible,
          anchor: _resolveAnchor(),
          portalFollower: _buildPopup(theme),
          child: widget.child,
        ),
      ),
    );
  }

  Anchor _resolveAnchor() {
    final offset = widget.offset ??
        switch (widget.position) {
          AxisDirection.up => const Offset(0, -_kDefaultGap),
          AxisDirection.down => const Offset(0, _kDefaultGap),
          AxisDirection.left => const Offset(-_kDefaultGap, 0),
          AxisDirection.right => const Offset(_kDefaultGap, 0),
        };

    return switch (widget.position) {
      AxisDirection.up => Aligned(
          follower: Alignment.bottomCenter,
          target: Alignment.topCenter,
          offset: offset,
          backup: const Aligned(
            follower: Alignment.topCenter,
            target: Alignment.bottomCenter,
            offset: Offset(0, _kDefaultGap),
          ),
        ),
      AxisDirection.down => Aligned(
          follower: Alignment.topCenter,
          target: Alignment.bottomCenter,
          offset: offset,
          backup: const Aligned(
            follower: Alignment.bottomCenter,
            target: Alignment.topCenter,
            offset: Offset(0, -_kDefaultGap),
          ),
        ),
      AxisDirection.left => Aligned(
          follower: Alignment.centerRight,
          target: Alignment.centerLeft,
          offset: offset,
          backup: const Aligned(
            follower: Alignment.centerLeft,
            target: Alignment.centerRight,
            offset: Offset(_kDefaultGap, 0),
          ),
        ),
      AxisDirection.right => Aligned(
          follower: Alignment.centerLeft,
          target: Alignment.centerRight,
          offset: offset,
          backup: const Aligned(
            follower: Alignment.centerRight,
            target: Alignment.centerLeft,
            offset: Offset(-_kDefaultGap, 0),
          ),
        ),
    };
  }

  Widget _buildPopup(AppDesignTheme theme) {
    return IgnorePointer(
      child: AppSurface(
        style: theme.surfaceElevated.copyWith(
          borderRadius: 8.0,
        ),
        width: null,
        height: null,
        padding: widget.padding ??
            EdgeInsets.symmetric(
              horizontal: 12 * theme.spacingFactor,
              vertical: 8 * theme.spacingFactor,
            ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth,
            maxHeight: widget.maxHeight ?? double.infinity,
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: widget.content ??
                AppText.caption(
                  widget.message!,
                  color: theme.surfaceElevated.contentColor,
                  textAlign: TextAlign.center,
                ),
          ),
        ),
      ),
    );
  }
}
