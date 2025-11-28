import 'package:flutter/material.dart';
import '../app_design_theme.dart';
import '../surface_style.dart';

class NeumorphicDesignTheme extends AppDesignTheme {
  // Default to Light
  const NeumorphicDesignTheme() : this.light();

  const NeumorphicDesignTheme.light()
      : super(
          surfaceBase: const SurfaceStyle(
            backgroundColor: Color(0xFFE0E5EC), // Classic Neu base
            borderColor: Colors.transparent, // Usually borderless
            borderWidth: 0.0,
            borderRadius: 16.0,
            shadows: [
              BoxShadow(
                color: Colors.white, // Light shadow (top-left)
                offset: Offset(-6, -6),
                blurRadius: 12,
              ),
              BoxShadow(
                color: Color(0xFFA3B1C6), // Dark shadow (bottom-right)
                offset: Offset(6, 6),
                blurRadius: 12,
              ),
            ],
            blurStrength: 0.0,
            contentColor: Color(0xFF4A5568),
          ),
          surfaceElevated: const SurfaceStyle(
            backgroundColor: Color(0xFFE0E5EC),
            borderColor: Colors.transparent,
            borderWidth: 0.0,
            borderRadius: 20.0,
            shadows: [
              BoxShadow(
                color: Colors.white,
                offset: Offset(-8, -8),
                blurRadius: 16,
              ),
              BoxShadow(
                color: Color(0xFFA3B1C6),
                offset: Offset(8, 8),
                blurRadius: 16,
              ),
            ],
            blurStrength: 0.0,
            contentColor: Color(0xFF4A5568),
          ),
          surfaceHighlight: const SurfaceStyle(
            backgroundColor: Color(0xFFE0E5EC),
            borderColor: Color(0xFF007AFF), // Blue border for highlight
            borderWidth: 1.5,
            borderRadius: 12.0,
            shadows: [
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: Color(0xFFA3B1C6),
                offset: Offset(4, 4),
                blurRadius: 8,
              ),
            ],
            blurStrength: 0.0,
            contentColor: Color(0xFF007AFF),
          ),
          typography: const TypographySpec(
            bodyFontFamily: 'Nunito', // Soft modern
            displayFontFamily: 'Nunito',
          ),
          animation: const AnimationSpec(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
          spacingFactor: 1.2, // Needs space for shadows
        );

  const NeumorphicDesignTheme.dark()
      : super(
          surfaceBase: const SurfaceStyle(
            backgroundColor: Color(0xFF2D2D2D),
            borderColor: Colors.transparent,
            borderWidth: 0.0,
            borderRadius: 16.0,
            shadows: [
              BoxShadow(
                color: Color(0xFF3D3D3D), // Light shadow (top-left)
                offset: Offset(-5, -5),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Color(0xFF1D1D1D), // Dark shadow (bottom-right)
                offset: Offset(5, 5),
                blurRadius: 10,
              ),
            ],
            blurStrength: 0.0,
            contentColor: Color(0xFFE0E0E0),
          ),
          surfaceElevated: const SurfaceStyle(
            backgroundColor: Color(0xFF2D2D2D),
            borderColor: Colors.transparent,
            borderWidth: 0.0,
            borderRadius: 20.0,
            shadows: [
              BoxShadow(
                color: Color(0xFF3D3D3D),
                offset: Offset(-8, -8),
                blurRadius: 16,
              ),
              BoxShadow(
                color: Color(0xFF1D1D1D),
                offset: Offset(8, 8),
                blurRadius: 16,
              ),
            ],
            blurStrength: 0.0,
            contentColor: Colors.white,
          ),
          surfaceHighlight: const SurfaceStyle(
            backgroundColor: Color(0xFF2D2D2D),
            borderColor: Color(0xFF0A84FF),
            borderWidth: 1.5,
            borderRadius: 12.0,
            shadows: [
              BoxShadow(
                color: Color(0xFF3D3D3D),
                offset: Offset(-4, -4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: Color(0xFF1D1D1D),
                offset: Offset(4, 4),
                blurRadius: 8,
              ),
            ],
            blurStrength: 0.0,
            contentColor: Color(0xFF0A84FF),
          ),
          typography: const TypographySpec(
            bodyFontFamily: 'Nunito',
            displayFontFamily: 'Nunito',
          ),
          animation: const AnimationSpec(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
          spacingFactor: 1.2,
        );
}
