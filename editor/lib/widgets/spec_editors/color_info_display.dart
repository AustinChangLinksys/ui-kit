import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Read-only color info display widget
/// Used in spec editors to show colors managed by ColorScheme
class ColorInfoDisplay extends StatelessWidget {
  final String label;
  final Color color;
  final String sourceColor;
  final String note;

  const ColorInfoDisplay({
    required this.label,
    required this.color,
    required this.sourceColor,
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const Gap(6),
        Text(
          'From: $sourceColor',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
                fontSize: 11,
              ),
        ),
        Text(
          note,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.blue,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
        ),
      ],
    );
  }
}
