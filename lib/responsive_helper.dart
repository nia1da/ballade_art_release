import 'package:flutter/material.dart';

class ResponsiveHelper {
  // Yeni eşikler (senin istediğin gibi biraz büyütüldü)
  static const double _compactMaxWidth = 370;
  static const double _compactMaxHeight = 650;

  static const double _largeMinWidth = 410;

  /// Check if screen is compact (small Android phones)
  static bool isCompactScreen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return width <= _compactMaxWidth || height <= _compactMaxHeight;
  }

  /// Check if screen is medium (most Android phones)
  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > _compactMaxWidth && width < _largeMinWidth;
  }

  /// Check if screen is large (modern Android phones)
  static bool isLargeScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _largeMinWidth;
  }

  /// Get responsive font size based on screen
  static double fontSize(
      BuildContext context,
      double baseSize, {
        double? maxSize,
        double? minSize,
      }) {
    final width = MediaQuery.of(context).size.width;

    double scaleFactor;
    if (width <= _compactMaxWidth) {
      scaleFactor = 0.50; // Compact phones (senin mevcut değerini korudum)
    } else if (width < _largeMinWidth) {
      scaleFactor = 1.0; // Standard phones
    } else {
      scaleFactor = 1.1; // Large phones
    }

    final calculated = baseSize * scaleFactor;

    final effectiveMin = minSize ?? (baseSize * 0.75);
    final effectiveMax = maxSize ?? (baseSize * 1.5);
    return calculated.clamp(effectiveMin, effectiveMax);
  }

  /// Get responsive spacing
  static double spacing(BuildContext context, double baseSpacing) {
    final height = MediaQuery.of(context).size.height;

    if (height <= _compactMaxHeight) {
      return baseSpacing * 0.62; // Compact vertical space (senin mevcut değerini korudum)
    } else if (height < 750) {
      return baseSpacing * 0.9; // Medium vertical space
    } else {
      return baseSpacing; // Full vertical space
    }
  }

  /// Get safe padding for notches/navigation bars
  static EdgeInsets getSafePadding(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    if (isCompactScreen(context)) {
      const reduceFactor = 0.65; // senin mevcut değerini korudum
      return EdgeInsets.only(
        top: padding.top * reduceFactor,
        bottom: padding.bottom * reduceFactor,
      );
    }

    return EdgeInsets.only(
      top: padding.top,
      bottom: padding.bottom,
    );
  }
}