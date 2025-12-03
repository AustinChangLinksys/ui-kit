import 'package:flutter_test/flutter_test.dart';

import 'package:generative_ui/src/data/utils/schema_generator.dart';

void main() {
  group('SchemaGenerator', () {
    test('generates schema for WifiSettingsCard component', () {
      final fields = {
        'ssid': SchemaField(name: 'ssid', type: 'string', description: 'Network name', required: true),
        'security': SchemaField(name: 'security', type: 'string', enumValues: ['WPA2', 'WPA3', 'Open']),
        'isEnabled': SchemaField(name: 'isEnabled', type: 'boolean', required: true),
      };

      final schema = SchemaGenerator.generateSchema(
        componentName: 'WifiSettingsCard',
        fields: fields,
      );

      expect(schema['type'], equals('object'));
      expect(schema['title'], equals('WifiSettingsCard'));
      expect(schema['properties'], isA<Map>());
      expect((schema['required'] as List).length, equals(2)); // ssid and isEnabled
    });

    test('generates schema for InfoCard component', () {
      final fields = {
        'title': SchemaField(name: 'title', type: 'string', required: true),
        'message': SchemaField(name: 'message', type: 'string', required: true),
        'type': SchemaField(name: 'type', type: 'string', enumValues: ['info', 'warning', 'error']),
      };

      final schema = SchemaGenerator.generateSchema(
        componentName: 'InfoCard',
        fields: fields,
      );

      expect(schema['properties'].containsKey('title'), true);
      expect(schema['properties'].containsKey('message'), true);
      expect((schema['required'] as List).length, equals(2));
    });

    test('includes enum values in schema', () {
      final fields = {
        'status': SchemaField(
          name: 'status',
          type: 'string',
          enumValues: ['pending', 'active', 'inactive'],
        ),
      };

      final schema = SchemaGenerator.generateSchema(
        componentName: 'StatusField',
        fields: fields,
      );

      expect(schema['properties']['status']['enum'], equals(['pending', 'active', 'inactive']));
    });

    test('validates JSON Schema Draft 7 structure', () {
      final validSchema = {
        'type': 'object',
        'title': 'TestComponent',
        'properties': {
          'field1': {'type': 'string'},
        },
      };

      expect(SchemaGenerator.isValidSchema(validSchema), equals(true));
    });

    test('rejects non-object schemas', () {
      final invalidSchema = {
        'type': 'array',
        'properties': {},
      };

      expect(SchemaGenerator.isValidSchema(invalidSchema), equals(false));
    });

    test('handles components with no required fields', () {
      final fields = {
        'optional1': SchemaField(name: 'optional1', type: 'string'),
        'optional2': SchemaField(name: 'optional2', type: 'string'),
      };

      final schema = SchemaGenerator.generateSchema(
        componentName: 'OptionalComponent',
        fields: fields,
      );

      expect(schema.containsKey('required'), false);
    });
  });
}
