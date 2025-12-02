import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Dialog for exporting and copying generated theme code
class ExportDialog extends StatefulWidget {
  final String generatedCode;

  const ExportDialog({
    required this.generatedCode,
    super.key,
  });

  @override
  State<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  bool _copied = false;

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.generatedCode));
    setState(() {
      _copied = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _copied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Export Theme Code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(),
          // Code display area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: SelectableText(
                  widget.generatedCode,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                ),
              ),
            ),
          ),
          const Divider(),
          // Footer with copy button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_copied)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      'Copied!',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ElevatedButton.icon(
                  icon: Icon(_copied ? Icons.check : Icons.copy),
                  label: Text(_copied ? 'Copied' : 'Copy to Clipboard'),
                  onPressed: _copyToClipboard,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
