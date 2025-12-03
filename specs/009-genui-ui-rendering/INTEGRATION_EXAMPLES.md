# Advanced Integration Examples

This guide provides advanced patterns for integrating GenUI into your Flutter application.

## Custom Type Conversion

If your components require complex types not handled by the default `DynamicWidgetBuilder`, you can implement custom parsing logic within your component builder.

```dart
registry.register('ChartWidget', (context, props) {
  // Custom parsing for a list of data points
  final dataPoints = (props['data'] as List?)
      ?.map((e) => DataPoint.fromJson(e))
      .toList() ?? [];

  return ChartWidget(data: dataPoints);
});
```

## Error Handling Strategies

### Global Error Handler

You can wrap `GenUiContainer` with a custom error boundary if you want to catch errors that bubble up from the orchestration layer (though `GenUiContainer` handles most internal errors).

### Component-Level Fallbacks

For critical components, you might want to provide a specific fallback UI instead of the generic `FallbackCard`.

```dart
registry.register('CriticalWidget', (context, props) {
  try {
    return CriticalWidget(id: props['id']!);
  } catch (e) {
    return Text('Critical component failed to load.');
  }
});
```

## Performance Tuning

### Lazy Loading Components

If you have a massive registry, consider lazy-loading heavy assets or dependencies only when the component is actually instantiated.

```dart
registry.register('HeavyMapWidget', (context, props) {
  return LazyLoadWrapper(
    loader: () => loadMapAssets(),
    child: HeavyMapWidget(...),
  );
});
```

### Registry Scope

You can create scoped registries for different parts of your app (e.g., a `SettingsRegistry` vs. a `DashboardRegistry`) to keep lookups fast and relevant.

```dart
final settingsRegistry = ComponentRegistry();
// ... register settings-specific components

final dashboardRegistry = ComponentRegistry();
// ... register dashboard components
```
