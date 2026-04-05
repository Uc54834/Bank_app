import 'package:flutter/material.dart';

/// Responsive breakpoints for adaptive layouts
class ResponsiveBreakpoints {
  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double wide = 1440;
}

/// Extension on BuildContext for responsive utilities
extension ResponsiveContext on BuildContext {
  // Screen size helpers
  bool get isMobile =>
      MediaQuery.of(this).size.width < ResponsiveBreakpoints.mobile;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= ResponsiveBreakpoints.mobile &&
      MediaQuery.of(this).size.width < ResponsiveBreakpoints.desktop;
  bool get isDesktop =>
      MediaQuery.of(this).size.width >= ResponsiveBreakpoints.desktop;
  bool get isWide =>
      MediaQuery.of(this).size.width >= ResponsiveBreakpoints.wide;

  // Screen width
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // Adaptive padding based on screen size
  double get adaptivePadding => isMobile
      ? 16.0
      : isTablet
      ? 24.0
      : 32.0;
  double get adaptiveHorizontalPadding => isMobile
      ? 16.0
      : isTablet
      ? 32.0
      : 48.0;
  double get adaptiveVerticalPadding => isMobile
      ? 16.0
      : isTablet
      ? 24.0
      : 32.0;

  // Adaptive spacing
  double get spacingXs => 4.0;
  double get spacingSmall => 8.0;
  double get spacingMedium => 16.0;
  double get spacingLarge => 24.0;
  double get spacingXl => 32.0;
  double get spacingXxl => 48.0;

  // Adaptive widget sizes
  double get buttonHeight => isMobile ? 48.0 : 52.0;
  double get inputHeight => isMobile ? 52.0 : 56.0;
  double get cardElevation => 0.0;
  double get borderRadius => 12.0;
}

/// Screen type enum
enum ScreenType { mobile, tablet, desktop, wide }

/// Get current screen type
ScreenType getScreenType(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < ResponsiveBreakpoints.mobile) return ScreenType.mobile;
  if (width < ResponsiveBreakpoints.tablet) return ScreenType.tablet;
  if (width < ResponsiveBreakpoints.desktop) return ScreenType.desktop;
  return ScreenType.wide;
}

/// Responsive layout builder widget
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? wide;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = getScreenType(context);
    switch (screenType) {
      case ScreenType.wide:
        return wide ?? desktop ?? tablet ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.mobile:
        return mobile;
    }
  }
}

/// Adaptive container that constrains width on larger screens
class AdaptiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const AdaptiveContainer({super.key, required this.child, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: maxWidth != null
            ? BoxConstraints(maxWidth: maxWidth!)
            : null,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.adaptiveHorizontalPadding,
        ),
        child: child,
      ),
    );
  }
}

/// Get cross axis count for grid based on screen size
int getCrossAxisCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width >= ResponsiveBreakpoints.desktop) return 4;
  if (width >= ResponsiveBreakpoints.tablet) return 3;
  if (width >= ResponsiveBreakpoints.mobile) return 2;
  return 2;
}

/// Orientation builder for portrait/landcape
class AdaptiveOrientationBuilder extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;

  const AdaptiveOrientationBuilder({
    super.key,
    required this.portrait,
    required this.landscape,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait ? portrait : landscape;
      },
    );
  }
}

/// Spacing constants
class Spacing {
  static const double xs = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

/// SizedBox shortcuts
class AppSpacing extends StatelessWidget {
  final double width;
  final double height;

  const AppSpacing({
    super.key,
    this.width = Spacing.medium,
    this.height = Spacing.medium,
  });

  const AppSpacing.xxs({super.key}) : width = Spacing.xs, height = Spacing.xs;
  const AppSpacing.xs({super.key})
    : width = Spacing.small,
      height = Spacing.small;
  const AppSpacing.s({super.key})
    : width = Spacing.medium,
      height = Spacing.medium;
  const AppSpacing.m({super.key})
    : width = Spacing.large,
      height = Spacing.large;
  const AppSpacing.l({super.key}) : width = Spacing.xl, height = Spacing.xl;
  const AppSpacing.xl({super.key}) : width = Spacing.xxl, height = Spacing.xxl;
  const AppSpacing.vertical({super.key, required this.height}) : width = 0;
  const AppSpacing.horizontal({super.key, required this.width}) : height = 0;

  @override
  Widget build(BuildContext context) => SizedBox(width: width, height: height);
}
