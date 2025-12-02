import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../widgets/control_panel.dart';
import '../widgets/preview_area.dart';

/// Main page for the Live Theme Editor
/// Displays control panel on left and live preview on right
class LiveEditorPage extends StatefulWidget {
  const LiveEditorPage({super.key});

  @override
  State<LiveEditorPage> createState() => _LiveEditorPageState();
}

class _LiveEditorPageState extends State<LiveEditorPage> {
  bool _isMobilePreviewWidth = false;

  void _togglePreviewWidth() {
    setState(() {
      _isMobilePreviewWidth = !_isMobilePreviewWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTabletLayout = MediaQuery.of(context).size.width < 900;

    if (isTabletLayout) {
      // Mobile layout: stacked vertically
      return Scaffold(
        appBar: AppBar(title: const Text('Live Theme Editor')),
        body: ListView(
          children: [
            // Preview Area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: PreviewArea(
                    previewWidth: _isMobilePreviewWidth ? 375 : null,
                  ),
                ),
              ),
            ),
            const Divider(),
            // Control Panel
            ControlPanel(
              onPreviewWidthToggle: _togglePreviewWidth,
              isMobilePreviewWidth: _isMobilePreviewWidth,
            ),
          ],
        ),
      );
    } else {
      // Desktop layout: side by side
      return Scaffold(
        appBar: AppBar(title: const Text('Live Theme Editor')),
        body: Row(
          children: [
            // Control Panel (Left side)
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: ControlPanel(
                  onPreviewWidthToggle: _togglePreviewWidth,
                  isMobilePreviewWidth: _isMobilePreviewWidth,
                ),
              ),
            ),
            // Preview Area (Right side)
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DesignSystem.init(
                  context,
                  PreviewArea(previewWidth: _isMobilePreviewWidth ? 375 : null),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
