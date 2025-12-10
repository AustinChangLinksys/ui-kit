# Changelog

All notable changes to the UI Kit Library will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2025-12-10

### ✨ Added
- **Enhanced Button System**: Primary vs Secondary visual distinction with semantic variant colors
- **Semantic Golden Test Naming**: Renamed test files from technical names (highlight/tonal/base) to intuitive names (primary/secondary/tertiary)
- **Color Intensification System**: Advanced color processing for enhanced theme authenticity

### 🎨 Enhanced
- **Brutal Theme Colors**:
  - Implemented color intensification algorithm with 1.4x-1.5x saturation boost
  - Primary buttons now use intensified primary colors instead of generic red
  - Secondary buttons enhanced with bold secondary colors for maximum contrast
  - Colors are now truly "brutal" with dramatic contrast and intensity

- **Pixel Theme Colors**:
  - Implemented retro color saturation system with 90-95% saturation
  - Authentic 8-bit/16-bit arcade game aesthetics
  - Primary buttons use deep, saturated colors reminiscent of classic games
  - Secondary buttons feature vibrant retro colors for nostalgic gaming feel

### 🔧 Technical Improvements
- **Button Surface Resolution System**: New semantic variant color resolution logic
- **Color Processing Functions**:
  - `_intensifyColor()` for Brutal theme color enhancement
  - `_retroSaturateColor()` for Pixel theme retro aesthetics
  - `_getContrastingTextColor()` for optimal text contrast
- **Backwards Compatibility**: All existing button code continues to work unchanged

### 🧪 Testing
- Updated all 36 button golden tests across 5 themes × 2 brightness modes
- Semantic test naming alignment for better developer experience
- Comprehensive visual regression testing validation

---

## [2.0.0] - 2025-11-27

### 🚀 Major Release - Unified Design System

#### ✨ Added
- **Multi-Paradigm Theme Support**: Glass, Brutal, Flat, Neumorphic, and Pixel themes
- **Data-Driven Strategy (DDS)**: Runtime theme switching without business logic changes
- **App Unified Color System (v1.2)**: Material 3 compatible reactive color management
- **Constitutional Compliance Framework**: UI Kit Constitution (v3.1.1) with architectural principles

#### 🏗 Architecture
- **Atomic Design Structure**: Foundation, Atoms, Molecules, Organisms layers
- **Theme Tailor Integration**: Automated theme extension generation with `@TailorMixin()`
- **Physics-Based Interactions**: Components inherit behaviors via `InteractionSpec`
- **Smart Layouts**: Spacing adapts to theme density using `spacingFactor`

#### 🧩 Core Components
- **AppSurface**: Constitutional core renderer for surfaces with physics, borders, shadows
- **AppButton**: Theme-aware button with size variants and loading states
- **AppTextField**: Multi-variant input fields (outline, underline, filled)
- **Navigation Components**: AppNavigationBar, AppNavigationRail, AppTabs
- **Layout Components**: AppCard, AppDialog, AppListTile

#### 🎨 Theme System
- **Glass Theme**: Glassmorphism with blur effects and translucency
- **Brutal Theme**: Neo-Brutalism with bold borders and stark contrasts
- **Flat Theme**: Clean Material-style surfaces
- **Neumorphic Theme**: Soft shadows and embossed effects
- **Pixel Theme**: Retro 8-bit styling with instant animations

#### 🧪 Testing Framework
- **Golden Tests**: Alchemist-based visual regression testing
- **Safe Mode Testing**: 10-style matrix coverage (5 themes × Light/Dark)
- **Widgetbook Integration**: Interactive component catalog

---

## [1.0.0] - 2025-10-15

### 🎯 Foundation Release

#### ✨ Added
- **Basic Component Library**: Initial set of UI components
- **Theme System**: Basic light/dark theme support
- **Material Integration**: Flutter Material Design integration

#### 🧩 Initial Components
- Basic buttons, inputs, and layout components
- Simple theming system
- Standard Material widgets

#### 🏗 Architecture
- Initial project structure
- Basic component organization
- Flutter package setup

---

## [0.0.1] - 2025-09-01

### 🚀 Initial Release
- Project initialization
- Basic package structure
- Development environment setup

---

## Legend

- 🚀 **Major releases**
- ✨ **New features**
- 🎨 **Design/visual enhancements**
- 🔧 **Technical improvements**
- 🐛 **Bug fixes**
- 🧪 **Testing improvements**
- 🏗 **Architecture changes**
- 🧩 **Component additions**
- ⚠️ **Breaking changes**
- 📚 **Documentation**