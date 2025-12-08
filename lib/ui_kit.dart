library ui_kit;

// -----------------------------------------------------------------------------
// Foundation
// Contains: Theme factory, layout settings, color definitions, text definitions, special material themes
// -----------------------------------------------------------------------------
export 'src/foundation/theme/tokens/app_theme.dart';
export 'src/foundation/theme/tokens/app_palette.dart';

export 'src/foundation/utils/app_validators.dart';
export 'src/foundation/utils/app_formatters.dart';

export 'src/foundation/theme/app_typography.dart';
export 'src/foundation/design_system.dart';

// Unified Design System
export 'src/foundation/theme/design_system/app_design_theme.dart';
export 'src/foundation/theme/design_system/specs/surface_style.dart';
export 'src/foundation/theme/design_system/specs/loader_style.dart';
export 'src/foundation/theme/design_system/specs/toast_style.dart';
export 'src/foundation/theme/design_system/specs/divider_style.dart';
export 'src/foundation/theme/design_system/specs/network_input_style.dart';
export 'src/foundation/theme/design_system/specs/input_style.dart';
export 'src/foundation/theme/design_system/specs/toggle_style.dart';
export 'src/foundation/theme/design_system/specs/navigation_style.dart';
export 'src/foundation/theme/design_system/styles/glass_design_theme.dart';
export 'src/foundation/theme/design_system/styles/brutal_design_theme.dart';
export 'src/foundation/theme/design_system/styles/flat_design_theme.dart';
export 'src/foundation/theme/design_system/styles/neumorphic_design_theme.dart';
export 'src/foundation/theme/design_system/styles/pixel_design_theme.dart';
export 'src/foundation/theme/design_system/specs/skeleton_style.dart';
export 'src/foundation/theme/design_system/specs/layout_spec.dart';
export 'src/foundation/theme/design_system/specs/app_bar_style.dart';
export 'src/foundation/theme/design_system/specs/app_menu_style.dart';
export 'src/foundation/theme/design_system/specs/dialog_style.dart';
export 'src/foundation/theme/design_system/specs/bottom_sheet_style.dart';
export 'src/foundation/theme/design_system/specs/side_sheet_style.dart';
export 'src/foundation/theme/design_system/specs/tabs_style.dart';
export 'src/foundation/theme/design_system/specs/stepper_style.dart';
export 'src/foundation/theme/design_system/specs/breadcrumb_style.dart';
export 'src/foundation/theme/design_system/specs/expansion_panel_style.dart';
export 'src/foundation/theme/design_system/specs/carousel_style.dart';
export 'src/foundation/theme/design_system/specs/chip_group_style.dart';
export 'src/foundation/theme/design_system/specs/topology_style.dart';
export 'src/foundation/theme/design_system/specs/table_style.dart'; // New export
export 'src/foundation/theme/design_system/specs/slide_action_style.dart'; // New export
export 'src/foundation/theme/design_system/specs/expandable_fab_style.dart'; // New export
export 'src/foundation/theme/design_system/specs/gauge_style.dart'; // New export
export 'src/foundation/theme/tokens/app_textures.dart';
export 'src/foundation/feedback/app_feedback.dart';

// Motion System
export 'src/foundation/motion/app_motion.dart';
export 'src/foundation/motion/motion_spec.dart';
export 'src/foundation/motion/flat_motion.dart';
export 'src/foundation/motion/glass_motion.dart';
export 'src/foundation/motion/pixel_motion.dart';
export 'src/foundation/motion/steps_curve.dart';

// Global Effects
export 'src/foundation/effects/global_effects_type.dart';
export 'src/foundation/effects/global_effects_overlay.dart';

// Icons
export 'src/foundation/icons/app_icon_style.dart';

export 'src/foundation/gen/assets.gen.dart';
export 'src/foundation/icons/app_font_icons.dart';
export 'src/atoms/images/theme_aware_svg.dart';
export 'src/atoms/images/theme_aware_image.dart';

// --- NEW APP COLOR SYSTEM EXPORTS ---
export 'src/foundation/theme/app_theme_config.dart';
export 'src/foundation/theme/app_color_scheme.dart';
export 'src/foundation/theme/app_color_factory.dart';

// -----------------------------------------------------------------------------
// Atoms (Atomic Components)
// Contains: buttons, icons, images, labels
// -----------------------------------------------------------------------------
export 'src/atoms/icons/app_icon.dart';
export 'src/atoms/images/product_image.dart';
export 'src/atoms/loading/app_skeleton.dart';
export 'src/atoms/surfaces/app_surface.dart';
export 'src/atoms/typography/app_text.dart';
export 'src/atoms/layout/app_gap.dart';
export 'src/atoms/layout/app_divider.dart';
// -----------------------------------------------------------------------------
// Molecules (Molecular Components)
// Contains: cards, list items
// -----------------------------------------------------------------------------
export 'src/molecules/cards/app_card.dart';
export 'src/molecules/dialogs/app_dialog.dart';
export 'src/molecules/toggles/app_switch.dart';
export 'src/molecules/buttons/app_button.dart';
export 'src/molecules/buttons/app_icon_button.dart';
export 'src/molecules/navigation/app_navigation_bar.dart';
export 'src/molecules/navigation/app_navigation_item.dart';
export 'src/molecules/navigation/app_navigation_rail.dart';
export 'src/molecules/expansion_panel/app_expansion_panel.dart'
    show AppExpansionPanel, ExpansionPanel, ExpansionPanelItem;
export 'src/molecules/carousel/app_carousel.dart'
    show AppCarousel, CarouselScrollBehavior;
export 'src/molecules/stepper/app_stepper.dart'
    show AppStepper, StepperStep, StepperVariant;
export 'src/molecules/bottom_sheet/app_bottom_sheet.dart'
    show AppBottomSheet, BottomSheetDisplayMode;
export 'src/molecules/side_sheet/app_side_sheet.dart'
    show AppSideSheet, AppDrawer, SideSheetPosition, SideSheetDisplayMode;
export 'src/molecules/tabs/app_tabs.dart' show AppTabs, TabItem, TabDisplayMode;
export 'src/molecules/breadcrumb/app_breadcrumb.dart'
    show AppBreadcrumb, BreadcrumbItem;
export 'src/molecules/chip_group/app_chip_group.dart'
    show AppChipGroup, ChipItem, ChipSelectionMode;
export 'src/molecules/selection/app_checkbox.dart';
export 'src/molecules/selection/app_radio.dart';
export 'src/molecules/selection/app_slider.dart';
export 'src/molecules/status/app_tag.dart';
export 'src/molecules/status/app_badge.dart';
export 'src/molecules/status/app_avatar.dart';
export 'src/molecules/inputs/app_text_field.dart';
export 'src/molecules/forms/app_text_form_field.dart';
export 'src/molecules/forms/app_dropdown.dart';
export 'src/molecules/inputs/network/app_ipv4_text_field.dart';
export 'src/molecules/inputs/network/app_mac_address_text_field.dart';
export 'src/molecules/inputs/network/app_ipv6_text_field.dart';
export 'src/molecules/inputs/app_number_text_field.dart';
export 'src/molecules/inputs/range/app_range_input.dart';
export 'src/molecules/inputs/pin/app_pin_input.dart';
export 'src/molecules/inputs/password/app_password_input.dart';
export 'src/molecules/inputs/password/app_password_rule.dart';
export 'src/molecules/feedback/app_loader.dart';
export 'src/molecules/feedback/app_toast.dart';
export 'src/molecules/layout/app_list_tile.dart';
export 'src/molecules/display/app_tooltip.dart';
export 'src/molecules/slide_action/app_slide_action.dart';
export 'src/molecules/slide_action/slide_action_item.dart';
export 'src/organisms/expandable_fab/app_expandable_fab.dart';
export 'src/organisms/gauge/app_gauge.dart';
export 'src/organisms/gauge/gauge_painter.dart';

export 'src/molecules/menu/app_popup_menu_item.dart';
export 'src/molecules/menu/app_popup_menu.dart';

export 'src/molecules/table/app_data_table.dart';
export 'src/molecules/table/table_column.dart';
export 'src/molecules/table/table_localization.dart';
export 'src/molecules/table/renderers/card_renderer.dart';
export 'src/molecules/table/renderers/grid_renderer.dart';

// -----------------------------------------------------------------------------
// Organisms (Complex Components)
// Contains: app bars, dialogs, menus, topology
// -----------------------------------------------------------------------------
export 'src/organisms/app_bar/app_unified_bar.dart';
export 'src/organisms/app_bar/app_unified_sliver_bar.dart';

// Topology - Mesh Network Visualization
export 'src/organisms/topology/topology.dart';
export 'src/organisms/topology/links/link_renderer.dart';

// Layout
export 'src/layout/layout_extensions.dart';
export 'src/layout/app_page_view.dart';