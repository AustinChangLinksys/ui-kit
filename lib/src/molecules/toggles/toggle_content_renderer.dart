import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/toggle_style.dart';

/// 專門負責渲染 Toggle 內部圖形的渲染器
class ToggleContentRenderer extends StatelessWidget {
  final ToggleContentType type;
  final String? text;
  final IconData? icon;
  final Color color;

  const ToggleContentRenderer({
    super.key,
    required this.type,
    required this.color,
    this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ToggleContentType.text:
        return Center(
          child: Text(
            text ?? "",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontFamily: 'Courier',
              fontSize: 12,
            ),
          ),
        );

      case ToggleContentType.icon:
        return Center(
          child: Icon(
            icon,
            size: 16,
            color: color,
          ),
        );

      case ToggleContentType.grip:
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _GripLine(color: color),
              const SizedBox(width: 2),
              _GripLine(color: color),
              const SizedBox(width: 2),
              _GripLine(color: color),
            ],
          ),
        );

      case ToggleContentType.dot:
        return _ConcaveDot(color: color);

      case ToggleContentType.none:
        return const SizedBox.shrink();
    }
  }
}

// --- 私有原子元件 (Private Atoms) ---
// 這些小零件只跟渲染有關，不應該污染 AppSwitch

class _GripLine extends StatelessWidget {
  final Color color;
  const _GripLine({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 10,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

class _ConcaveDot extends StatelessWidget {
  final Color color;
  const _ConcaveDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              offset: const Offset(-1, -1),
              blurRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 1),
              blurRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}