library ui_kit;

// -----------------------------------------------------------------------------
// Foundation (地基)
// 包含：主題工廠、佈局設定、顏色定義、文字定義、特殊材質主題
// -----------------------------------------------------------------------------
export 'src/foundation/theme/app_theme.dart';
export 'src/foundation/theme/app_layout.dart';
export 'src/foundation/theme/app_colors.dart';
export 'src/foundation/theme/app_typography.dart';
export 'src/foundation/theme/glass_theme.dart';

export 'src/foundation/gen/assets.gen.dart';
export 'src/foundation/icons/app_font_icons.dart';
export 'src/atoms/images/theme_aware_svg.dart';
export 'src/atoms/images/theme_aware_image.dart';

// -----------------------------------------------------------------------------
// Atoms (原子元件)
// 包含：按鈕、圖示、圖片、標籤
// -----------------------------------------------------------------------------
export 'src/atoms/icons/app_icon.dart';           // 👈 新增：SVG 圖示封裝
export 'src/atoms/images/product_image.dart';     // 👈 新增：產品圖片封裝
export 'src/atoms/loading/app_skeleton.dart';     // 👈 新增：骨架元件

// -----------------------------------------------------------------------------
// Molecules (分子元件)
// 包含：卡片、列表項
// -----------------------------------------------------------------------------
export 'src/molecules/cards/liquid_glass_card.dart'; // 毛玻璃卡片
export 'src/molecules/dialogs/liquid_glass_dialog.dart';

// Layout
export 'src/layout/layout_extensions.dart'; // 讓 context extension 可用
export 'src/layout/app_page_view.dart';


// -----------------------------------------------------------------------------
// Utilities (若有公開的工具類)
// -----------------------------------------------------------------------------
// export 'src/utils/layout_extensions.dart'; // 建議導出 Layout Extension 方便 Context 呼叫