library ui_kit;

// -----------------------------------------------------------------------------
// Foundation (地基)
// 包含：主題工廠、佈局設定、顏色定義、文字定義、特殊材質主題
// -----------------------------------------------------------------------------
export 'src/foundation/theme/app_theme.dart';
export 'src/foundation/theme/app_colors.dart';
export 'src/foundation/theme/app_typography.dart';
export 'src/foundation/theme/glass_theme.dart';

// Unified Design System
export 'src/foundation/theme/design_system/app_design_theme.dart';
export 'src/foundation/theme/design_system/surface_style.dart';
export 'src/foundation/theme/design_system/styles/glass_design_theme.dart';
export 'src/foundation/theme/design_system/styles/brutal_design_theme.dart';
export 'src/foundation/theme/design_system/styles/flat_design_theme.dart';
export 'src/foundation/theme/design_system/styles/neumorphic_design_theme.dart';

export 'src/foundation/gen/assets.gen.dart';
export 'src/foundation/icons/app_font_icons.dart';
export 'src/atoms/images/theme_aware_svg.dart';
export 'src/atoms/images/theme_aware_image.dart';

// -----------------------------------------------------------------------------
// Atoms (原子元件)
// 包含：按鈕、圖示、圖片、標籤
// -----------------------------------------------------------------------------
export 'src/atoms/icons/app_icon.dart';
export 'src/atoms/images/product_image.dart';
export 'src/atoms/loading/app_skeleton.dart';
export 'src/atoms/surfaces/app_surface.dart'; // 👈 新增：通用表面
export 'src/atoms/typography/app_text.dart'; // 👈 新增：通用文字
export 'src/atoms/layout/app_gap.dart';
// -----------------------------------------------------------------------------
// Molecules (分子元件)
// 包含：卡片、列表項
// -----------------------------------------------------------------------------
export 'src/molecules/cards/app_card.dart'; // 👈 新增：通用卡片
export 'src/molecules/dialogs/app_dialog.dart'; // 👈 新增：通用對話框
export 'src/molecules/toggles/app_switch.dart';
export 'src/molecules/buttons/app_button.dart';
export 'src/molecules/buttons/app_icon_button.dart';
export 'src/molecules/navigation/app_navigation_bar.dart';
export 'src/molecules/navigation/app_navigation_item.dart';
export 'src/molecules/selection/app_checkbox.dart';
export 'src/molecules/selection/app_radio.dart';
export 'src/molecules/selection/app_slider.dart';
export 'src/molecules/status/app_tag.dart';
export 'src/molecules/status/app_badge.dart';
export 'src/molecules/status/app_avatar.dart';
export 'src/molecules/navigation/app_navigation_rail.dart';
export 'src/molecules/inputs/app_text_field.dart';
// Layout
export 'src/layout/layout_extensions.dart';
export 'src/layout/app_page_view.dart';
