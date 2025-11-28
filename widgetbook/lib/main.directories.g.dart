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
import 'package:widgetbook_workspace/stories/atoms/loading/app_skeleton.stories.dart'
    as _widgetbook_workspace_stories_atoms_loading_app_skeleton_stories;
import 'package:widgetbook_workspace/stories/atoms/surfaces/app_surface.stories.dart'
    as _widgetbook_workspace_stories_atoms_surfaces_app_surface_stories;
import 'package:widgetbook_workspace/stories/layouts/app_page_view.stories.dart'
    as _widgetbook_workspace_stories_layouts_app_page_view_stories;
import 'package:widgetbook_workspace/stories/molecules/cards/app_card.stories.dart'
    as _widgetbook_workspace_stories_molecules_cards_app_card_stories;
import 'package:widgetbook_workspace/stories/molecules/dialogs/app_dialog.stories.dart'
    as _widgetbook_workspace_stories_molecules_dialogs_app_dialog_stories;
import 'package:widgetbook_workspace/stories/molecules/toggles/app_switch.stories.dart'
    as _widgetbook_workspace_stories_molecules_toggles_app_switch_stories;

final directories = <_widgetbook.WidgetbookNode>[
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
