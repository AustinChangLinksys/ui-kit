import 'package:flutter/material.dart';
import '../app_design_theme.dart';
import '../surface_style.dart';

class GlassDesignTheme extends AppDesignTheme {
  const GlassDesignTheme() : this.light();

  const GlassDesignTheme.light()
      : super(
          surfaceBase: const SurfaceStyle(
            backgroundColor: Color(0x1AFFFFFF), // 10% White
            borderColor: Color(0x4DFFFFFF), // 30% White
            borderWidth: 1.0,
            borderRadius: 24.0,
            shadows: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(0, 10),
              )
            ],
            blurStrength: 15.0,
            contentColor: Colors.white,
          ),
          surfaceElevated: const SurfaceStyle(
            backgroundColor: Color(0x26FFFFFF), // 15% White
            borderColor: Color(0x66FFFFFF), // 40% White
            borderWidth: 1.0,
            borderRadius: 24.0,
            shadows: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 30,
                spreadRadius: 4,
                offset: Offset(0, 15),
              )
            ],
            blurStrength: 25.0,
            contentColor: Colors.white,
          ),
          surfaceHighlight: const SurfaceStyle(
            backgroundColor: Color(0x33FFFFFF), // 20% White
            borderColor: Color(0x80FFFFFF), // 50% White
            borderWidth: 1.5,
            borderRadius: 16.0,
            shadows: [
              BoxShadow(
                color: Color(0x4D000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
            blurStrength: 10.0,
            contentColor: Colors.white,
          ),
          typography: const TypographySpec(
            bodyFontFamily: null, // Default
            displayFontFamily: null,
          ),
          animation: const AnimationSpec(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          ),
          spacingFactor: 1.0,
        );

  const GlassDesignTheme.dark()
      : super(
          surfaceBase: const SurfaceStyle(
            backgroundColor: Color(0x80000000), // 50% Black
            borderColor: Color(0x1AFFFFFF), // 10% White
            borderWidth: 1.0,
            borderRadius: 24.0,
            shadows: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(0, 10),
              )
            ],
            blurStrength: 15.0,
            contentColor: Colors.white,
          ),
          surfaceElevated: const SurfaceStyle(
            backgroundColor: Color(0x99000000), // 60% Black
            borderColor: Color(0x26FFFFFF), // 15% White
            borderWidth: 1.0,
            borderRadius: 24.0,
            shadows: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 30,
                spreadRadius: 4,
                offset: Offset(0, 15),
              )
            ],
            blurStrength: 25.0,
            contentColor: Colors.white,
          ),
          surfaceHighlight: const SurfaceStyle(
            backgroundColor: Color(0x66000000), // 40% Black
            borderColor: Color(0x4DFFFFFF), // 30% White
            borderWidth: 1.5,
            borderRadius: 16.0,
            shadows: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
            blurStrength: 10.0,
            contentColor: Colors.white,
          ),
          typography: const TypographySpec(
            bodyFontFamily: null, // Default
            displayFontFamily: null,
          ),
          animation: const AnimationSpec(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          ),
          spacingFactor: 1.0,
        );
}
