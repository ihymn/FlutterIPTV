import 'dart:ui';
import 'package:flutter/material.dart';

class AppTheme {
  // Lotus Theme - Brand Colors
  // 莲花粉紫渐变作为主色调
  static const Color primaryColor = Color(0xFFE91E8C); // Lotus Pink
  static const Color primaryLight = Color(0xFFFF6EB4); // Light Pink
  static const Color primaryDark = Color(0xFFAD1457); // Deep Pink

  static const Color secondaryColor = Color(0xFF9C27B0); // Purple
  static const Color accentColor = Color(0xFF00BCD4); // Cyan accent

  // Background Colors - 纯黑/极深灰
  static const Color backgroundColor = Color(0xFF000000); // Pure Black
  static const Color surfaceColor = Color(0xFF0A0A0A); // Near Black
  static const Color cardColor = Color(0xFF121212); // Dark Grey
  static const Color cardHoverColor = Color(0xFF1A1A1A);

  // Glassmorphism Colors
  static const Color glassColor = Color(0x1AFFFFFF); // 10% white
  static const Color glassBorderColor = Color(0x33FFFFFF); // 20% white
  static const Color glassHighlight = Color(0x0DFFFFFF); // 5% white

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0); // Grey 400
  static const Color textMuted = Color(0xFF757575); // Grey 500

  // Focus Colors (for TV navigation) - Lotus gradient
  static const Color focusColor = Color(0xFFE91E8C);
  static const Color focusBorderColor = Color(0xFFFF6EB4);

  // Status Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFFF5252);
  static const Color warningColor = Color(0xFFFFB74D);
  static const Color infoColor = Color(0xFF29B6F6);

  // Lotus Gradient - 莲花渐变
  static const LinearGradient lotusGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE91E8C), // Pink
      Color(0xFF9C27B0), // Purple
    ],
  );

  static const LinearGradient lotusSoftGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x66E91E8C), // Pink 40%
      Color(0x669C27B0), // Purple 40%
    ],
  );

  // Card Gradient - Glassmorphism
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x1AFFFFFF), // 10% white
      Color(0x0DFFFFFF), // 5% white
    ],
  );

  // Overlay Gradients for Player
  static const LinearGradient overlayGradientTop = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xCC000000), // 80% black
      Colors.transparent,
    ],
    stops: [0.0, 1.0],
  );

  static const LinearGradient overlayGradientBottom = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xE6000000), // 90% black
    ],
    stops: [0.0, 1.0],
  );

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusPill = 50.0;

  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'NotoSansSC', // 思源黑体
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
        onError: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(
        color: textSecondary,
        size: 24,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: -0.25,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textMuted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textMuted,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusPill),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusPill),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: glassColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: glassBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: glassBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: errorColor),
        ),
        hintStyle: const TextStyle(color: textMuted),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cardColor,
        contentTextStyle: const TextStyle(color: textPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF1F1F1F),
        thickness: 1,
        space: 1,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        inactiveTrackColor: glassColor,
        thumbColor: primaryColor,
        overlayColor: primaryColor.withAlpha(51),
        trackHeight: 4,
      ),
    );
  }
}

// Glassmorphism Card Decoration
class GlassDecoration extends BoxDecoration {
  GlassDecoration({
    bool focused = false,
    double borderRadius = AppTheme.radiusMedium,
    Color? glowColor,
  }) : super(
          borderRadius: BorderRadius.circular(borderRadius),
          color: AppTheme.glassColor,
          border: Border.all(
            color: focused
                ? (glowColor ?? AppTheme.focusBorderColor)
                : AppTheme.glassBorderColor,
            width: focused ? 2 : 1,
          ),
          boxShadow: focused
              ? [
                  BoxShadow(
                    color: (glowColor ?? AppTheme.focusColor).withAlpha(102),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        );
}

// TV-specific focus decoration with Lotus glow
class TVFocusDecoration extends BoxDecoration {
  TVFocusDecoration({bool focused = false})
      : super(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: focused ? AppTheme.focusBorderColor : Colors.transparent,
            width: focused ? 3 : 0,
          ),
          boxShadow: focused
              ? [
                  BoxShadow(
                    color: AppTheme.focusColor.withAlpha(102),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ]
              : null,
        );
}

// Glass Card Widget
class GlassCard extends StatelessWidget {
  final Widget child;
  final bool focused;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? glowColor;

  const GlassCard({
    super.key,
    required this.child,
    this.focused = false,
    this.borderRadius = AppTheme.radiusMedium,
    this.padding,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AnimatedContainer(
          duration: AppTheme.animationFast,
          decoration: GlassDecoration(
            focused: focused,
            borderRadius: borderRadius,
            glowColor: glowColor,
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
