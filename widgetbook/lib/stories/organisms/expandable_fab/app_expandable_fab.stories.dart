import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'AppExpandableFab',
  type: AppExpandableFab,
)
Widget appExpandableFabUseCase(BuildContext context) {
  return Scaffold(
    body: const Center(child: Text('Tap FAB to expand')),
    floatingActionButton: AppExpandableFab(
      children: [
        FloatingActionButton(
          onPressed: () {},
          mini: true,
          child: const Icon(Icons.image),
        ),
        FloatingActionButton(
          onPressed: () {},
          mini: true,
          child: const Icon(Icons.camera),
        ),
      ],
    ),
  );
}
