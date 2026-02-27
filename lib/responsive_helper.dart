import 'package:flutter/material.dart';

class ResponsiveHelper {
  /// Check if screen is compact (small Android phones)
  static bool isCompactScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return width < 360 || height < 640;
  }

  /// Check if screen is medium (most Android phones)
  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 360 && width < 400;
  }

  /// Check if screen is large (modern Android phones)
  static bool isLargeScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 400;
  }

  /// Get responsive font size based on screen
  static double fontSize(BuildContext context, double baseSize, {double? maxSize}) {
    final width = MediaQuery.of(context).size.width;

    // Scale factor based on screen width
    double scaleFactor;
    if (width < 360) {
      scaleFactor = 0.85; // Compact phones (e.g., Galaxy S10e)
    } else if (width < 400) {
      scaleFactor = 1.0;  // Standard phones (e.g., Pixel 5)
    } else {
      scaleFactor = 1.1;  // Large phones (e.g., Samsung S24, Pixel 8)
    }

    final calculated = baseSize * scaleFactor;
    return maxSize != null ? calculated.clamp(baseSize, maxSize) : calculated;
  }

  /// Get responsive spacing
  static double spacing(BuildContext context, double baseSpacing) {
    final height = MediaQuery.of(context).size.height;

    if (height < 640) {
      return baseSpacing * 0.75; // Compact vertical space
    } else if (height < 750) {
      return baseSpacing * 0.9;  // Medium vertical space
    } else {
      return baseSpacing;        // Full vertical space
    }
  }

  /// Get safe padding for notches/navigation bars
  static EdgeInsets getSafePadding(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return EdgeInsets.only(
      top: padding.top,
      bottom: padding.bottom,
    );
  }
}