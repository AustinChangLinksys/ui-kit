import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

@UseCase(
  name: 'Basic Surface',
  type: AppSlideAction,
)
Widget appSlideActionBasicUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 375,
      child: AppSlideAction(
        actions: [
          SlideActionItem(
            label: 'Archive',
            icon: const Icon(Icons.archive),
            onTap: () {},
            variant: SlideActionVariant.neutral,
          ),
          SlideActionItem(
            label: 'Delete',
            icon: const Icon(Icons.delete),
            onTap: () {},
            variant: SlideActionVariant.destructive,
          ),
        ],
        child: const AppSurface(
          variant: SurfaceVariant.base,
          height: 72,
          child: Center(child: Text('Swipe me left')),
        ),
      ),
    ),
  );
}

@UseCase(
  name: 'With AppListTile',
  type: AppSlideAction,
)
Widget appSlideActionListTileUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 375,
      child: AppSlideAction(
        actions: [
          SlideActionItem(
            label: 'Archive',
            icon: const Icon(Icons.archive),
            onTap: () {},
            variant: SlideActionVariant.neutral,
          ),
          SlideActionItem(
            label: 'Delete',
            icon: const Icon(Icons.delete),
            onTap: () {},
            variant: SlideActionVariant.destructive,
          ),
        ],
        child: AppListTile(
          leading: const Icon(Icons.mail),
          title: const Text('Email Notification'),
          subtitle: const Text('You have a new message'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ),
    ),
  );
}

@UseCase(
  name: 'Single Action',
  type: AppSlideAction,
)
Widget appSlideActionSingleUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 375,
      child: AppSlideAction(
        actions: [
          SlideActionItem(
            label: 'Delete',
            icon: const Icon(Icons.delete),
            onTap: () {},
            variant: SlideActionVariant.destructive,
          ),
        ],
        child: AppListTile(
          leading: const Icon(Icons.file_copy),
          title: const Text('Document.pdf'),
          subtitle: const Text('2.4 MB - Modified yesterday'),
          trailing: const Icon(Icons.more_vert),
          onTap: () {},
        ),
      ),
    ),
  );
}
