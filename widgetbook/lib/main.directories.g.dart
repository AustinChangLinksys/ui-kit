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
import 'package:widgetbook_workspace/stories/layouts/app_page_view.stories.dart'
    as _widgetbook_workspace_stories_layouts_app_page_view_stories;
import 'package:widgetbook_workspace/stories/molecules/cards/liquid_glass_card.stories.dart'
    as _widgetbook_workspace_stories_molecules_cards_liquid_glass_card_stories;
import 'package:widgetbook_workspace/stories/molecules/dialogs/liquid_glass_dialog.stories.dart'
    as _widgetbook_workspace_stories_molecules_dialogs_liquid_glass_dialog_stories;

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
            name: 'LiquidGlassCard',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Playground',
                builder:
                    _widgetbook_workspace_stories_molecules_cards_liquid_glass_card_stories
                        .buildLiquidGlassCard,
              )
            ],
          )
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'dialogs',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'LiquidGlassDialog',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Alert Dialog (Popup)',
                builder:
                    _widgetbook_workspace_stories_molecules_dialogs_liquid_glass_dialog_stories
                        .buildLiquidGlassDialogPopup,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Alert Dialog Style',
                builder:
                    _widgetbook_workspace_stories_molecules_dialogs_liquid_glass_dialog_stories
                        .buildLiquidGlassDialogAlert,
              ),
            ],
          )
        ],
      ),
    ],
  ),
];
