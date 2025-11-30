import 'package:equatable/equatable.dart';

/// 定義佈局相關的響應式規則 (整合版)
class LayoutSpec extends Equatable {
  // 1. 斷點定義 (Breakpoints) - 允許不同 Theme 微調斷點
  final double breakpointMobile; // default: 600
  final double breakpointTablet; // default: 900
  final double breakpointDesktop; // default: 1200

  // 2. 響應式 Gutter (欄間距)
  final double gutterMobile;
  final double gutterTablet;
  final double gutterDesktop;

  // 3. 響應式 Margin (頁面邊距)
  final double marginMobile;
  final double marginTablet;
  final double marginDesktop;

  // 4. 最大欄數限制 (Grid System)
  final int maxColumns;

  const LayoutSpec({
    // 預設斷點 (Material 標準)
    this.breakpointMobile = 600.0,
    this.breakpointTablet = 900.0,
    this.breakpointDesktop = 1200.0,

    // 預設 Gutter
    this.gutterMobile = 16.0,
    this.gutterTablet = 24.0,
    this.gutterDesktop = 24.0,

    // 預設 Margin
    this.marginMobile = 16.0,
    this.marginTablet = 32.0,
    this.marginDesktop = 64.0, // 桌面版通常留白較多

    this.maxColumns = 12,
  });

  // --- 核心邏輯：響應式解析器 ---

  /// 根據螢幕寬度取得當前 Gutter
  double gutter(double width) {
    if (width >= breakpointDesktop) return gutterDesktop;
    if (width >= breakpointTablet) return gutterTablet;
    return gutterMobile;
  }

  /// 根據螢幕寬度取得當前 Page Margin
  double margin(double width) {
    if (width >= breakpointDesktop) return marginDesktop;
    if (width >= breakpointTablet) return marginTablet;
    return marginMobile;
  }

  /// 判斷當前是否為手機尺寸
  bool isMobile(double width) => width < breakpointTablet;

  @override
  List<Object?> get props => [
        breakpointMobile,
        breakpointTablet,
        breakpointDesktop,
        gutterMobile,
        gutterTablet,
        gutterDesktop,
        marginMobile,
        marginTablet,
        marginDesktop,
        maxColumns,
      ];
}
