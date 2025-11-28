import 'package:flutter/material.dart';
import '../app_design_theme.dart';
import '../surface_style.dart';

class FlatDesignTheme extends AppDesignTheme {
  // Default to Light
  const FlatDesignTheme() : this.light();

  const FlatDesignTheme.light()
      : super(
          surfaceBase: const SurfaceStyle(
            backgroundColor: Colors.white,
            borderColor: Color(0xFFE0E0E0), // Light Grey
            borderWidth: 1.0,
            borderRadius: 8.0,
            shadows: [], // No shadows for Flat
            blurStrength: 0.0,
            contentColor: Colors.black87,
          ),
          surfaceElevated: const SurfaceStyle(
            backgroundColor: Colors.white,
            borderColor: Color(0xFFBDBDBD),
            borderWidth: 1.0,
            borderRadius: 12.0,
            shadows: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ], // Minimal shadow for elevation
            blurStrength: 0.0,
            contentColor: Colors.black87,
          ),
          surfaceHighlight: const SurfaceStyle(
            backgroundColor: Color(0xFFF5F5F5),
            borderColor: Colors.transparent,
            borderWidth: 0.0,
            borderRadius: 4.0,
            shadows: [],
            blurStrength: 0.0,
            contentColor: Colors.black,
          ),
          typography: const TypographySpec(
            bodyFontFamily: 'Roboto', // Clean sans-serif
            displayFontFamily: 'Roboto',
          ),
          animation: const AnimationSpec(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          ),
          spacingFactor: 1.0,
        );

  const FlatDesignTheme.dark()
      : super(
          surfaceBase: const SurfaceStyle(
            backgroundColor: Color(0xFF1E1E1E),
            borderColor: Color(0xFF333333),
            borderWidth: 1.0,
            borderRadius: 8.0,
            shadows: [],
            blurStrength: 0.0,
            contentColor: Colors.white70,
          ),
          surfaceElevated: const SurfaceStyle(
            backgroundColor: Color(0xFF2C2C2C),
            borderColor: Color(0xFF424242),
            borderWidth: 1.0,
            borderRadius: 12.0,
            shadows: [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
            blurStrength: 0.0,
            contentColor: Colors.white,
          ),
          surfaceHighlight: const SurfaceStyle(
            backgroundColor: Color(0xFF333333),
            borderColor: Colors.transparent,
            borderWidth: 0.0,
            borderRadius: 4.0,
            shadows: [],
            blurStrength: 0.0,
            contentColor: Colors.white,
          ),
          typography: const TypographySpec(
            bodyFontFamily: 'Roboto',
            displayFontFamily: 'Roboto',
          ),
          animation: const AnimationSpec(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          ),
          spacingFactor: 1.0,
        );
}
