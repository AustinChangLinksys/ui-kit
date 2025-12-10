import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTheme.create(
      child: MaterialApp(
        home: DebugColWidthTest(),
      ),
    );
  }
}

class DebugColWidthTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageView(
      showGridOverlay: true,
      child: (context, constraints) {
        // Calculate values for debugging
        final screenWidth = MediaQuery.sizeOf(context).width;
        final pageMargin = context.pageMargin;
        final gutter = context.currentGutter;
        final maxCols = context.currentMaxColumns;
        final colWidth3WithMargins = context.colWidth(3);
        final colWidth3WithoutMargins = context.colWidth(3, useMargins: false);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Screen Width: $screenWidth'),
              Text('Page Margin: $pageMargin'),
              Text('Gutter: $gutter'),
              Text('Max Columns: $maxCols'),
              Text('colWidth(3) with margins: $colWidth3WithMargins'),
              Text('colWidth(3) without margins: $colWidth3WithoutMargins'),
              SizedBox(height: 20),
              Container(
                height: 100,
                width: colWidth3WithoutMargins,
                color: Colors.red.withOpacity(0.5),
                child: Center(child: Text('3 Columns\n(no margins)')),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: colWidth3WithoutMargins,
                    color: Colors.blue.withOpacity(0.5),
                    child: Center(child: Text('Menu\n3 cols')),
                  ),
                  SizedBox(width: gutter),
                  Expanded(
                    child: Container(
                      height: 50,
                      color: Colors.green.withOpacity(0.5),
                      child: Center(child: Text('Content\n(Expanded)')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}