// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;
import 'package:widgetbook_workspace/stories/atoms/assets.stories.dart'
    as _widgetbook_workspace_stories_atoms_assets_stories;
import 'package:widgetbook_workspace/stories/atoms/layout/app_divider_stories.dart'
    as _widgetbook_workspace_stories_atoms_layout_app_divider_stories;
import 'package:widgetbook_workspace/stories/atoms/loading/app_skeleton.stories.dart'
    as _widgetbook_workspace_stories_atoms_loading_app_skeleton_stories;
import 'package:widgetbook_workspace/stories/atoms/selection/app_checkbox.stories.dart'
    as _widgetbook_workspace_stories_atoms_selection_app_checkbox_stories;
import 'package:widgetbook_workspace/stories/atoms/selection/app_radio.stories.dart'
    as _widgetbook_workspace_stories_atoms_selection_app_radio_stories;
import 'package:widgetbook_workspace/stories/atoms/selection/app_slider.stories.dart'
    as _widgetbook_workspace_stories_atoms_selection_app_slider_stories;
import 'package:widgetbook_workspace/stories/atoms/surfaces/app_surface.stories.dart'
    as _widgetbook_workspace_stories_atoms_surfaces_app_surface_stories;
import 'package:widgetbook_workspace/stories/atoms/typography/app_text.stories.dart'
    as _widgetbook_workspace_stories_atoms_typography_app_text_stories;
import 'package:widgetbook_workspace/stories/examples/dashboard_page.stories.dart'
    as _widgetbook_workspace_stories_examples_dashboard_page_stories;
import 'package:widgetbook_workspace/stories/examples/design_style_gallery.stories.dart'
    as _widgetbook_workspace_stories_examples_design_style_gallery_stories;
import 'package:widgetbook_workspace/stories/examples/internet_settings_page.stories.dart'
    as _widgetbook_workspace_stories_examples_internet_settings_page_stories;
import 'package:widgetbook_workspace/stories/examples/mockup_page.stories.dart'
    as _widgetbook_workspace_stories_examples_mockup_page_stories;
import 'package:widgetbook_workspace/stories/layouts/app_gap_stories.dart'
    as _widgetbook_workspace_stories_layouts_app_gap_stories;
import 'package:widgetbook_workspace/stories/layouts/app_page_view.stories.dart'
    as _widgetbook_workspace_stories_layouts_app_page_view_stories;
import 'package:widgetbook_workspace/stories/molecules/buttons/app_buttons.stories.dart'
    as _widgetbook_workspace_stories_molecules_buttons_app_buttons_stories;
import 'package:widgetbook_workspace/stories/molecules/cards/app_card.stories.dart'
    as _widgetbook_workspace_stories_molecules_cards_app_card_stories;
import 'package:widgetbook_workspace/stories/molecules/dialogs/app_dialog.stories.dart'
    as _widgetbook_workspace_stories_molecules_dialogs_app_dialog_stories;
import 'package:widgetbook_workspace/stories/molecules/display/app_tooltip.stories.dart'
    as _widgetbook_workspace_stories_molecules_display_app_tooltip_stories;
import 'package:widgetbook_workspace/stories/molecules/feedback/app_loader.stories.dart'
    as _widgetbook_workspace_stories_molecules_feedback_app_loader_stories;
import 'package:widgetbook_workspace/stories/molecules/feedback/app_toast.stories.dart'
    as _widgetbook_workspace_stories_molecules_feedback_app_toast_stories;
import 'package:widgetbook_workspace/stories/molecules/forms/app_dropdown.stories.dart'
    as _widgetbook_workspace_stories_molecules_forms_app_dropdown_stories;
import 'package:widgetbook_workspace/stories/molecules/forms/app_text_form_field.stories.dart'
    as _widgetbook_workspace_stories_molecules_forms_app_text_form_field_stories;
import 'package:widgetbook_workspace/stories/molecules/inputs/network_inputs_stories.dart'
    as _widgetbook_workspace_stories_molecules_inputs_network_inputs_stories;
import 'package:widgetbook_workspace/stories/molecules/layout/app_list_tile.stories.dart'
    as _widgetbook_workspace_stories_molecules_layout_app_list_tile_stories;
import 'package:widgetbook_workspace/stories/molecules/toggles/app_switch.stories.dart'
    as _widgetbook_workspace_stories_molecules_toggles_app_switch_stories;
import 'package:widgetbook_workspace/stories/navigation/app_navigation_bar.story.dart'
    as _widgetbook_workspace_stories_navigation_app_navigation_bar_story;
import 'package:widgetbook_workspace/stories/navigation/app_navigation_rail.stories.dart'
    as _widgetbook_workspace_stories_navigation_app_navigation_rail_stories;
import 'package:widgetbook_workspace/stories/status/app_avatar.stories.dart'
    as _widgetbook_workspace_stories_status_app_avatar_stories;
import 'package:widgetbook_workspace/stories/status/app_badge.stories.dart'
    as _widgetbook_workspace_stories_status_app_badge_stories;
import 'package:widgetbook_workspace/stories/status/app_tag.stories.dart'
    as _widgetbook_workspace_stories_status_app_tag_stories;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'Design Language Gallery',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'AppDesignTheme',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Brutal Style (Mechanical)',
            builder:
                _widgetbook_workspace_stories_examples_design_style_gallery_stories
                    .buildBrutalGallery,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Flat Style (Standard)',
            builder:
                _widgetbook_workspace_stories_examples_design_style_gallery_stories
                    .buildFlatGallery,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Glass Style (Liquid)',
            builder:
                _widgetbook_workspace_stories_examples_design_style_gallery_stories
                    .buildGlassGallery,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Neumorphic Style (Tactile)',
            builder:
                _widgetbook_workspace_stories_examples_design_style_gallery_stories
                    .buildNeumorphicGallery,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Pixel Style (Retro)',
            builder:
                _widgetbook_workspace_stories_examples_design_style_gallery_stories
                    .buildPixelGallery,
          ),
        ],
      )
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'Examples',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'DashboardPage',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Home Dashboard',
            builder:
                _widgetbook_workspace_stories_examples_dashboard_page_stories
                    .buildDashboardStory,
          )
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'InternetSettingsPage',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Internet Settings',
            builder:
                _widgetbook_workspace_stories_examples_internet_settings_page_stories
                    .buildInternetSettingsStory,
          )
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'MockupPage',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Mockup Page',
            builder: _widgetbook_workspace_stories_examples_mockup_page_stories
                .buildMockupPageStory,
          )
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'atoms',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'icons',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppIcon',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Icon Playground',
                builder: _widgetbook_workspace_stories_atoms_assets_stories
                    .buildAppIcon,
              )
            ],
          )
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'images',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ProductImage',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Product Image (Dimming)',
                builder: _widgetbook_workspace_stories_atoms_assets_stories
                    .buildProductImage,
              )
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'ThemeAwareImage',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Multi-colored PNG (Switching)',
                builder: _widgetbook_workspace_stories_atoms_assets_stories
                    .buildThemeAwareImage,
              )
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'ThemeAwareSvg',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Multi-colored SVG (Switching)',
                builder: _widgetbook_workspace_stories_atoms_assets_stories
                    .buildThemeAwareSvg,
              )
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'layout',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppDivider',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Divider',
                builder:
                    _widgetbook_workspace_stories_atoms_layout_app_divider_stories
                        .buildDividerUseCase,
              )
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppGap',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Playground',
                builder: _widgetbook_workspace_stories_layouts_app_gap_stories
                    .buildInteractiveGap,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Size Gallery',
                builder: _widgetbook_workspace_stories_layouts_app_gap_stories
                    .buildGapGallery,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'loading',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppSkeleton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Dialog Skeleton',
                builder:
                    _widgetbook_workspace_stories_atoms_loading_app_skeleton_stories
                        .buildDialogSkeleton,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Standard Playground',
                builder:
                    _widgetbook_workspace_stories_atoms_loading_app_skeleton_stories
                        .buildAppSkeletonPlayground,
              ),
            ],
          )
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'surfaces',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppSurface',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder:
                    _widgetbook_workspace_stories_atoms_surfaces_app_surface_stories
                        .buildAppSurfaceInteractive,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Variants',
                builder:
                    _widgetbook_workspace_stories_atoms_surfaces_app_surface_stories
                        .buildAppSurfaceVariants,
              ),
            ],
          )
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'typography',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppText',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Playground',
                builder:
                    _widgetbook_workspace_stories_atoms_typography_app_text_stories
                        .buildInteractiveText,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Typography Gallery',
                builder:
                    _widgetbook_workspace_stories_atoms_typography_app_text_stories
                        .buildTypographyGallery,
              ),
            ],
          )
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'layout',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'AppPageView',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Grid Layout Playground',
            builder: _widgetbook_workspace_stories_layouts_app_page_view_stories
                .buildAppPageView,
          )
        ],
      )
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'molecules',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'buttons',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'All States (Static)',
                builder:
                    _widgetbook_workspace_stories_molecules_buttons_app_buttons_stories
                        .buildAppButtonStates,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Playground',
                builder:
                    _widgetbook_workspace_stories_molecules_buttons_app_buttons_stories
                        .buildInteractiveAppButton,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppIconButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'All States (Static)',
                builder:
                    _widgetbook_workspace_stories_molecules_buttons_app_buttons_stories
                        .buildIconButtonStates,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Playground',
                builder:
                    _widgetbook_workspace_stories_molecules_buttons_app_buttons_stories
                        .buildInteractiveIconButton,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'cards',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppCard',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Standard',
                builder:
                    _widgetbook_workspace_stories_molecules_cards_app_card_stories
                        .buildAppCard,
              )
            ],
          )
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'dialogs',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppDialog',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Dialog Demo (Popup)',
                builder:
                    _widgetbook_workspace_stories_molecules_dialogs_app_dialog_stories
                        .buildAppDialogPopup,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Standard Dialog',
                builder:
                    _widgetbook_workspace_stories_molecules_dialogs_app_dialog_stories
                        .buildAppDialog,
              ),
            ],
          )
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'display',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppTooltip',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Tooltip',
                builder:
                    _widgetbook_workspace_stories_molecules_display_app_tooltip_stories
                        .buildInteractiveTooltip,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Positions Gallery',
                builder:
                    _widgetbook_workspace_stories_molecules_display_app_tooltip_stories
                        .buildTooltipGallery,
              ),
            ],
          )
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'feedback',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppLoader',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Loading Indicators',
                builder:
                    _widgetbook_workspace_stories_molecules_feedback_app_loader_stories
                        .buildAppLoader,
              )
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppToast',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Toasts',
                builder:
                    _widgetbook_workspace_stories_molecules_feedback_app_toast_stories
                        .buildAppToast,
              )
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'forms',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppDropdown',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Dropdown Selection',
                builder:
                    _widgetbook_workspace_stories_molecules_forms_app_dropdown_stories
                        .buildAppDropdown,
              )
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppTextFormField',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Form Field',
                builder:
                    _widgetbook_workspace_stories_molecules_forms_app_text_form_field_stories
                        .buildAppTextFormField,
              )
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'inputs',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'network',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'AppIpv4TextField',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Network Inputs',
                    builder:
                        _widgetbook_workspace_stories_molecules_inputs_network_inputs_stories
                            .buildNetworkInputsUseCase,
                  )
                ],
              )
            ],
          )
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'layout',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppListTile',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Standard List Tile',
                builder:
                    _widgetbook_workspace_stories_molecules_layout_app_list_tile_stories
                        .buildAppListTile,
              )
            ],
          )
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'navigation',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppNavigationBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Playground',
                builder:
                    _widgetbook_workspace_stories_navigation_app_navigation_bar_story
                        .buildAppNavigationBar,
              )
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppNavigationRail',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Rail (Desktop Layout)',
                builder:
                    _widgetbook_workspace_stories_navigation_app_navigation_rail_stories
                        .buildNavigationRail,
              )
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'selection',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppCheckbox',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'All States (Static)',
                builder:
                    _widgetbook_workspace_stories_atoms_selection_app_checkbox_stories
                        .buildCheckboxStates,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Checkbox',
                builder:
                    _widgetbook_workspace_stories_atoms_selection_app_checkbox_stories
                        .buildInteractiveCheckbox,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppRadio',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'All States (Static)',
                builder:
                    _widgetbook_workspace_stories_atoms_selection_app_radio_stories
                        .buildRadioStates,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Radio Group',
                builder:
                    _widgetbook_workspace_stories_atoms_selection_app_radio_stories
                        .buildInteractiveRadioGroup,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppSlider',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'All States (Static)',
                builder:
                    _widgetbook_workspace_stories_atoms_selection_app_slider_stories
                        .buildSliderStates,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Slider',
                builder:
                    _widgetbook_workspace_stories_atoms_selection_app_slider_stories
                        .buildInteractiveSlider,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'status',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppAvatar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'All States (Static)',
                builder: _widgetbook_workspace_stories_status_app_avatar_stories
                    .buildAvatarStates,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Avatar',
                builder: _widgetbook_workspace_stories_status_app_avatar_stories
                    .buildInteractiveAvatar,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppBadge',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'All States (Static)',
                builder: _widgetbook_workspace_stories_status_app_badge_stories
                    .buildBadgeStates,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Badge',
                builder: _widgetbook_workspace_stories_status_app_badge_stories
                    .buildInteractiveBadge,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppTag',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'All States (Static)',
                builder: _widgetbook_workspace_stories_status_app_tag_stories
                    .buildTagStates,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Tag',
                builder: _widgetbook_workspace_stories_status_app_tag_stories
                    .buildInteractiveTag,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'toggles',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppSwitch',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'All States',
                builder:
                    _widgetbook_workspace_stories_molecules_toggles_app_switch_stories
                        .appSwitchStates,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive Playground',
                builder:
                    _widgetbook_workspace_stories_molecules_toggles_app_switch_stories
                        .interactiveAppSwitch,
              ),
            ],
          )
        ],
      ),
    ],
  ),
];
