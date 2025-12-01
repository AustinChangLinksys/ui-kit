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
    // ✨ 1. 新增參數：預設為 false
    this.initiallyVisible = false,
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

  // ✨ 儲存這個設定
  final bool initiallyVisible;

  @override
  State<AppTooltip> createState() => _AppTooltipState();
}

class _AppTooltipState extends State<AppTooltip> {
  // 這是控制顯示與否的核心狀態
  bool _isVisible = false;

  static const double _kDefaultGap = 8.0;

  @override
  void initState() {
    super.initState();
    // ✨ 2. 關鍵邏輯：在初始化時，將 State 設為傳入的值
    // 如果 initiallyVisible 為 true，_isVisible 就會是 true
    _isVisible = widget.initiallyVisible;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return MouseRegion(
      // 互動邏輯：滑鼠移入顯示，移出隱藏
      onEnter: (_) => setState(() => _isVisible = true),
      onExit: (_) => setState(() => _isVisible = false),
      child: GestureDetector(
        // 互動邏輯：長按顯示，放開隱藏 (Mobile)
        onLongPress: () => setState(() => _isVisible = true),
        onLongPressUp: () => setState(() => _isVisible = false),

        child: PortalTarget(
          // ✨ 3. 綁定狀態：PortalTarget 會根據 _isVisible 決定是否渲染 follower
          // 因為 initState 已經設定過初始值，所以如果 initiallyVisible=true，這裡一開始就是 true
          visible: _isVisible,

          anchor: _resolveAnchor(),
          portalFollower: _buildPopup(theme),
          child: widget.child,
        ),
      ),
    );
  }

  /// 解析錨點邏輯
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
