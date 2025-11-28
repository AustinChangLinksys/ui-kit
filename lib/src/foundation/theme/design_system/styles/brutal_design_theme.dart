import 'package:flutter/material.dart';
import '../app_design_theme.dart';
import '../surface_style.dart';

class BrutalDesignTheme extends AppDesignTheme {
  // Default to Light
  const BrutalDesignTheme() : this.light();

  const BrutalDesignTheme.light()
      : super(
          surfaceBase: const SurfaceStyle(
            backgroundColor: Colors.white,
            borderColor: Colors.black,
            borderWidth: 3.0,
            borderRadius: 0.0,
            shadows: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 0,
                offset: Offset(4, 4),
              )
            ],
            blurStrength: 0.0,
            contentColor: Colors.black,
          ),
          surfaceElevated: const SurfaceStyle(
            backgroundColor: Color(0xFFFFDE59), // Neo-Brutal Yellow
            borderColor: Colors.black,
            borderWidth: 3.0,
            borderRadius: 0.0,
            shadows: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 0,
                offset: Offset(8, 8),
              )
            ],
            blurStrength: 0.0,
            contentColor: Colors.black,
          ),
          surfaceHighlight: const SurfaceStyle(
            backgroundColor: Color(0xFFFF5757), // Neo-Brutal Red
            borderColor: Colors.black,
            borderWidth: 3.0,
            borderRadius: 4.0,
            shadows: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 0,
                offset: Offset(2, 2),
              )
            ],
            blurStrength: 0.0,
            contentColor: Colors.white,
          ),
          typography: const TypographySpec(
            bodyFontFamily: 'Courier',
            displayFontFamily: 'Courier',
          ),
          animation: const AnimationSpec(
            duration: Duration(milliseconds: 150),
            curve: Curves.elasticOut,
          ),
          spacingFactor: 1.5,
        );

  const BrutalDesignTheme.dark()
      : super(
          surfaceBase: const SurfaceStyle(
            backgroundColor: Colors.black,
            borderColor: Colors.white,
            borderWidth: 3.0,
            borderRadius: 0.0,
            shadows: [
              BoxShadow(
                color: Colors.white, // White shadow on black
                blurRadius: 0,
                offset: Offset(4, 4),
              )
            ],
            blurStrength: 0.0,
            contentColor: Colors.white,
          ),
          surfaceElevated: const SurfaceStyle(
            backgroundColor: Color(0xFF4A148C), // Deep Purple for dark mode elevated
            borderColor: Colors.white,
            borderWidth: 3.0,
            borderRadius: 0.0,
            shadows: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 0,
                offset: Offset(8, 8),
              )
            ],
            blurStrength: 0.0,
            contentColor: Colors.white,
          ),
          surfaceHighlight: const SurfaceStyle(
            backgroundColor: Color(0xFF00E676), // Neon Green for highlight
            borderColor: Colors.white,
            borderWidth: 3.0,
            borderRadius: 4.0,
            shadows: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 0,
                offset: Offset(2, 2),
              )
            ],
            blurStrength: 0.0,
            contentColor: Colors.black, // Black text on Neon Green
          ),
          typography: const TypographySpec(
            bodyFontFamily: 'Courier',
            displayFontFamily: 'Courier',
          ),
          animation: const AnimationSpec(
            duration: Duration(milliseconds: 150),
            curve: Curves.elasticOut,
          ),
          spacingFactor: 1.5,
        );
}
