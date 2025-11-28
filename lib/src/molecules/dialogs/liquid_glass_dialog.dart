import 'package:flutter/material.dart';
import '../cards/liquid_glass_card.dart'; // 重用我們的卡片

@Deprecated('Use AppDialog instead')
class LiquidGlassDialog extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final List<Widget>? actions;
  final LiquidGlassStyle? style;

  const LiquidGlassDialog({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 使用 Flutter 原生的 Dialog 作為容器
    // 這確保了它有正確的 Margin (MediaQuery.viewInsets) 和對齊方式
    return Dialog(
      // backgroundColor: Colors.transparent, // 關鍵：背景透明，交給 GlassCard 處理
      elevation: 0, // 關鍵：移除預設陰影，交給 GlassCard 處理
      insetPadding: const EdgeInsets.all(24), // 響應式邊距，也可以用 context.pageMargin
      child: LiquidGlassCard(
        // 允許外部覆寫樣式，若無則使用預設
        style: style ?? const LiquidGlassStyle(
          borderRadius: 24.0, // Dialog 通常圓角較大
          // width/height 不設，讓內容撐開
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0), // 內部間距
          child: Column(
            mainAxisSize: MainAxisSize.min, // 高度自適應
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // A. 標題區
              if (title != null) ...[
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    // 確保在深色/淺色玻璃上都清楚，通常 GlassTheme 會處理，或這裡強制
                  ),
                  textAlign: TextAlign.center,
                  child: title!,
                ),
                const SizedBox(height: 16),
              ],

              // B. 內容區
              Flexible(
                child: SingleChildScrollView(
                  child: content,
                ),
              ),

              // C. 按鈕區
              if (actions != null && actions!.isNotEmpty) ...[
                const SizedBox(height: 24),
                // 這裡可以根據設計決定是 Row (水平) 還是 Column (垂直)
                // 簡單起見，我們先用 Wrap 或 Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _buildActionsWithSpacing(actions!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 輔助方法：給按鈕之間加間距
  List<Widget> _buildActionsWithSpacing(List<Widget> actions) {
    if (actions.isEmpty) return [];
    if (actions.length == 1) return actions;

    final List<Widget> spacedActions = [];
    for (int i = 0; i < actions.length; i++) {
      spacedActions.add(actions[i]);
      if (i != actions.length - 1) {
        spacedActions.add(const SizedBox(width: 8)); // 按鈕間距
      }
    }
    return spacedActions;
  }
}