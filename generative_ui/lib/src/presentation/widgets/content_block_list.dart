import 'package:flutter/material.dart';
import 'package:generative_ui/src/domain/entities/content_block.dart';
import 'package:generative_ui/src/presentation/widgets/dynamic_builder.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Widget for rendering a list of content blocks (Text + Tools)
class ContentBlockList extends StatelessWidget {
  final List<ContentBlock> blocks;
  final DynamicWidgetBuilder builder;

  const ContentBlockList({
    required this.blocks,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (blocks.isEmpty) {
      // Fallback for empty content? Or just nothing.
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Assume wrapped in ScrollView
      itemCount: blocks.length,
      separatorBuilder: (context, index) => AppGap.md(),
      itemBuilder: (context, index) {
        final block = blocks[index];
        return builder.buildBlock(block, context);
      },
    );
  }
}
