import 'dart:core';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

@UseCase(name: 'Default', type: AppStyledText)
Widget buildAppStyledTextUseCase(BuildContext context) {
  final textContent = context.knobs.string(
    label: 'Text Content',
    initialValue:
        'Welcome <b>{{user:John Doe}}</b>! Please read our {{terms:Terms of Service}} and {{privacy:Privacy Policy}}.',
  );

  final alignment = context.knobs.object.dropdown<TextAlign>(
    label: 'Text Alignment',
    options: [
      TextAlign.start,
      TextAlign.center,
      TextAlign.end,
      TextAlign.justify,
    ],
    labelBuilder: (alignment) {
      switch (alignment) {
        case TextAlign.start:
          return 'Start';
        case TextAlign.center:
          return 'Center';
        case TextAlign.end:
          return 'End';
        case TextAlign.justify:
          return 'Justify';
        default:
          return 'Unknown';
      }
    },
  );

  final maxLines = context.knobs.int.slider(
    label: 'Max Lines',
    min: 1,
    max: 10,
    divisions: 9,
  );

  return Container(
    padding: const EdgeInsets.all(16.0),
    width: double.infinity,
    child: AppStyledText(
      text: textContent,
      textAlign: alignment,
      maxLines: maxLines,
      onTapHandlers: {
        'user': () => _showSnackBar(context, 'User profile clicked!'),
        'terms': () => _showSnackBar(context, 'Terms of Service clicked!'),
        'privacy': () => _showSnackBar(context, 'Privacy Policy clicked!'),
        'link': () => _showSnackBar(context, 'Generic link clicked!'),
      },
    ),
  );
}

@UseCase(name: 'XML Tags Demo', type: AppStyledText)
Widget buildAppStyledTextXmlUseCase(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    width: double.infinity,
    child: const AppStyledText(
      text: 'XML Tags Demo:\n\n'
          'This text contains <b>bold</b>, <i>italic</i>, and <u>underlined</u> formatting.\n\n'
          'You can also use <color>colored text</color>, <large>large text</large>, '
          'and <small>small text</small> for variety.',
    ),
  );
}

@UseCase(name: 'Parametrized Tags Demo', type: AppStyledText)
Widget buildAppStyledTextParametrizedUseCase(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    width: double.infinity,
    child: AppStyledText(
      text: 'Parametrized Tags Demo:\n\n'
          'Click on {{action:this action}} or {{setting:change settings}}.\n\n'
          'Visit our {{website:official website}} for more {{info:information}}.',
      onTapHandlers: {
        'action': () => _showSnackBar(context, 'Action clicked!'),
        'setting': () => _showSnackBar(context, 'Settings clicked!'),
        'website': () => _showSnackBar(context, 'Website clicked!'),
        'info': () => _showSnackBar(context, 'More info clicked!'),
      },
    ),
  );
}

@UseCase(name: 'Mixed Format Demo', type: AppStyledText)
Widget buildAppStyledTextMixedUseCase(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    width: double.infinity,
    child: AppStyledText(
      text: 'Mixed Format Demo:\n\n'
          'Hello <b>{{name:John Smith}}</b>! Your account has <i>{{status:premium access}}</i>.\n\n'
          'You have <color>{{notifications:3 new messages}}</color> waiting. '
          '<small>Last updated: {{time:2 minutes ago}}</small>',
      onTapHandlers: {
        'name': () => _showSnackBar(context, 'User profile clicked!'),
        'status': () => _showSnackBar(context, 'Account status clicked!'),
        'notifications': () => _showSnackBar(context, 'Notifications clicked!'),
        'time': () => _showSnackBar(context, 'Timestamp clicked!'),
      },
    ),
  );
}

@UseCase(name: 'Theme Adaptation', type: AppStyledText)
Widget buildAppStyledTextThemeAdaptationUseCase(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    width: double.infinity,
    child: AppStyledText(
      text: 'Theme Adaptation Demo:\n\n'
          'Links adapt to current theme:\n'
          '• {{pixel:Pixel theme}} (underlined)\n'
          '• {{glass:Glass theme}} (glowing)\n'
          '• {{brutal:Brutal theme}} (background)\n'
          '• {{flat:Flat theme}} (underlined)',
      onTapHandlers: {
        'pixel': () => _showSnackBar(context, 'Pixel theme link clicked!'),
        'glass': () => _showSnackBar(context, 'Glass theme link clicked!'),
        'brutal': () => _showSnackBar(context, 'Brutal theme link clicked!'),
        'flat': () => _showSnackBar(context, 'Flat theme link clicked!'),
      },
    ),
  );
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}
