import 'package:equatable/equatable.dart';

/// Configuration class for page app bar display and behavior
///
/// This class follows UI Kit constitutional compliance by using Equatable
/// for value equality and providing immutable configuration options.
class PageAppBarConfig extends Equatable {
  /// The title text displayed in the app bar
  final String? title;

  /// Whether to show the back button in the app bar
  final bool showBackButton;

  /// Whether to enable sliver behavior for collapsible app bar
  final bool enableSliver;

  /// Custom toolbar height (null uses default)
  final double? toolbarHeight;

  /// Creates a new PageAppBarConfig instance
  const PageAppBarConfig({
    this.title,
    this.showBackButton = false,
    this.enableSliver = false,
    this.toolbarHeight,
  });

  /// Creates a copy of this config with the given fields replaced
  PageAppBarConfig copyWith({
    String? title,
    bool? showBackButton,
    bool? enableSliver,
    double? toolbarHeight,
  }) {
    return PageAppBarConfig(
      title: title ?? this.title,
      showBackButton: showBackButton ?? this.showBackButton,
      enableSliver: enableSliver ?? this.enableSliver,
      toolbarHeight: toolbarHeight ?? this.toolbarHeight,
    );
  }

  @override
  List<Object?> get props => [
        title,
        showBackButton,
        enableSliver,
        toolbarHeight,
      ];

  @override
  bool get stringify => true;
}
