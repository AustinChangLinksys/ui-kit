import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppDropdown<T> extends StatefulWidget {
  const AppDropdown({
    required this.items,
    required this.onChanged,
    this.value,
    this.itemBuilder,
    this.itemAsString,
    this.itemValue,
    this.label,
    this.hint,
    super.key,
  });

  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Widget Function(BuildContext, T, bool isSelected)? itemBuilder;
  final String Function(T)? itemAsString;
  final dynamic Function(T)? itemValue;
  final String? label;
  final String? hint;

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final style = theme.inputStyle.outlineStyle;

    return TapRegion(
      onTapOutside: (event) {
        if (_isMenuOpen) {
          setState(() => _isMenuOpen = false);
        }
      },
      child: PortalTarget(
        visible: _isMenuOpen,
        anchor: const Aligned(
          follower: Alignment.topLeft,
          target: Alignment.bottomLeft,
          widthFactor: 1,
          offset: Offset(0, 8),
        ),
        closeDuration: const Duration(milliseconds: 100),
        portalFollower: _buildMenu(theme),
        child: AppSurface(
          style: style,
          interactive: true,
          onTap: () => setState(() => _isMenuOpen = !_isMenuOpen),
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacingFactor * 12,
            vertical: theme.spacingFactor * 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _displayString(widget.value),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: widget.value == null
                        ? style.contentColor.withValues(alpha: 0.5)
                        : style.contentColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                _isMenuOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: style.contentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(AppDesignTheme theme) {
    return AppSurface(
      style: theme.surfaceElevated,
      padding: EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: theme.spacingFactor * 4),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            final isSelected = _areEqual(item, widget.value);

            return InkWell(
              onTap: () {
                widget.onChanged?.call(item);
                setState(() => _isMenuOpen = false);
              },
              child: widget.itemBuilder?.call(context, item, isSelected) ??
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.spacingFactor * 12,
                      vertical: theme.spacingFactor * 12,
                    ),
                    child: Text(
                      _displayString(item),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isSelected
                            ? theme.surfaceHighlight.contentColor
                            : theme.surfaceElevated.contentColor,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
            );
          },
        ),
      ),
    );
  }

  String _displayString(T? item) {
    if (item == null) return widget.hint ?? '';
    if (widget.itemAsString != null) return widget.itemAsString!(item);
    return item.toString();
  }

  bool _areEqual(T a, T? b) {
    if (b == null) return false;
    if (widget.itemValue != null) {
      return widget.itemValue!(a) == widget.itemValue!(b);
    }
    return a == b;
  }
}
