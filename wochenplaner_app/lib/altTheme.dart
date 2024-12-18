import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff08677f),
      surfaceTint: Color(0xff08677f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb7eaff),
      onPrimaryContainer: Color(0xff001f28),
      secondary: Color(0xff4c626b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcfe6f1),
      onSecondaryContainer: Color(0xff071e26),
      tertiary: Color(0xff5a5b7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe1e0ff),
      onTertiaryContainer: Color(0xff171837),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1f),
      surfaceVariant: Color(0xffdbe4e8),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787c),
      outlineVariant: Color(0xffa9b0b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e0e0),
      inverseOnSurface: Color(0xfff5f5f5),
      inversePrimary: Color(0xffa0c4ff),
      primaryFixed: Color(0xffc0eaff),
      onPrimaryFixed: Color(0xff001f28),
      primaryFixedDim: Color(0xffa0c4ff),
      onPrimaryFixedVariant: Color(0xff001f28),
      secondaryFixed: Color(0xffd0e6f1),
      onSecondaryFixed: Color(0xff071e26),
      secondaryFixedDim: Color(0xffb0c4d8),
      onSecondaryFixedVariant: Color(0xff071e26),
      tertiaryFixed: Color(0xffe0e0ff),
      onTertiaryFixed: Color(0xff171837),
      tertiaryFixedDim: Color(0xffc0c0ff),
      onTertiaryFixedVariant: Color(0xff171837),
      surfaceDim: Color(0xffe0e0e0),
      surfaceBright: Color(0xfff5f5f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f0f0),
      surfaceContainer: Color(0xffe0e0e0),
      surfaceContainerHigh: Color(0xffd0d0d0),
      surfaceContainerHighest: Color(0xffc0c0c0),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff08677f),
      surfaceTint: Color(0xff08677f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb7eaff),
      onPrimaryContainer: Color(0xff001f28),
      secondary: Color(0xff4c626b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcfe6f1),
      onSecondaryContainer: Color(0xff071e26),
      tertiary: Color(0xff5a5b7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe1e0ff),
      onTertiaryContainer: Color(0xff171837),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1f),
      surfaceVariant: Color(0xffdbe4e8),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787c),
      outlineVariant: Color(0xffa9b0b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e0e0),
      inverseOnSurface: Color(0xfff5f5f5),
      inversePrimary: Color(0xffa0c4ff),
      primaryFixed: Color(0xffc0eaff),
      onPrimaryFixed: Color(0xff001f28),
      primaryFixedDim: Color(0xffa0c4ff),
      onPrimaryFixedVariant: Color(0xff001f28),
      secondaryFixed: Color(0xffd0e6f1),
      onSecondaryFixed: Color(0xff071e26),
      secondaryFixedDim: Color(0xffb0c4d8),
      onSecondaryFixedVariant: Color(0xff071e26),
      tertiaryFixed: Color(0xffe0e0ff),
      onTertiaryFixed: Color(0xff171837),
      tertiaryFixedDim: Color(0xffc0c0ff),
      onTertiaryFixedVariant: Color(0xff171837),
      surfaceDim: Color(0xffe0e0e0),
      surfaceBright: Color(0xfff5f5f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f0f0),
      surfaceContainer: Color(0xffe0e0e0),
      surfaceContainerHigh: Color(0xffd0d0d0),
      surfaceContainerHighest: Color(0xffc0c0c0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff08677f),
      surfaceTint: Color(0xff08677f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb7eaff),
      onPrimaryContainer: Color(0xff001f28),
      secondary: Color(0xff4c626b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcfe6f1),
      onSecondaryContainer: Color(0xff071e26),
      tertiary: Color(0xff5a5b7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe1e0ff),
      onTertiaryContainer: Color(0xff171837),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1f),
      surfaceVariant: Color(0xffdbe4e8),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787c),
      outlineVariant: Color(0xffa9b0b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e0e0),
      inverseOnSurface: Color(0xfff5f5f5),
      inversePrimary: Color(0xffa0c4ff),
      primaryFixed: Color(0xffc0eaff),
      onPrimaryFixed: Color(0xff001f28),
      primaryFixedDim: Color(0xffa0c4ff),
      onPrimaryFixedVariant: Color(0xff001f28),
      secondaryFixed: Color(0xffd0e6f1),
      onSecondaryFixed: Color(0xff071e26),
      secondaryFixedDim: Color(0xffb0c4d8),
      onSecondaryFixedVariant: Color(0xff071e26),
      tertiaryFixed: Color(0xffe0e0ff),
      onTertiaryFixed: Color(0xff171837),
      tertiaryFixedDim: Color(0xffc0c0ff),
      onTertiaryFixedVariant: Color(0xff171837),
      surfaceDim: Color(0xffe0e0e0),
      surfaceBright: Color(0xfff5f5f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f0f0),
      surfaceContainer: Color(0xffe0e0e0),
      surfaceContainerHigh: Color(0xffd0d0d0),
      surfaceContainerHighest: Color(0xffc0c0c0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4287156716),
      surfaceTint: Color(4287156716),
      onPrimary: Color(4278203716),
      primaryContainer: Color(4278209889),
      onPrimaryContainer: Color(4290243327),
      secondary: Color(4289972948),
      onSecondary: Color(4280169275),
      secondaryContainer: Color(4281616978),
      onSecondaryContainer: Color(4291815153),
      tertiary: Color(4291019755),
      onTertiary: Color(4281085517),
      tertiaryContainer: Color(4282598501),
      onTertiaryContainer: Color(4292993279),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279178262),
      onBackground: Color(4292797414),
      surface: Color(4279178262),
      onSurface: Color(4292797414),
      surfaceVariant: Color(4282402892),
      onSurfaceVariant: Color(4290758860),
      outline: Color(4287271574),
      outlineVariant: Color(4282402892),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797414),
      inverseOnSurface: Color(4281086260),
      inversePrimary: Color(4278740863),
      primaryFixed: Color(4290243327),
      onPrimaryFixed: Color(4278198056),
      primaryFixedDim: Color(4287156716),
      onPrimaryFixedVariant: Color(4278209889),
      secondaryFixed: Color(4291815153),
      onSecondaryFixed: Color(4278656550),
      secondaryFixedDim: Color(4289972948),
      onSecondaryFixedVariant: Color(4281616978),
      tertiaryFixed: Color(4292993279),
      onTertiaryFixed: Color(4279703607),
      tertiaryFixedDim: Color(4291019755),
      onTertiaryFixedVariant: Color(4282598501),
      surfaceDim: Color(4279178262),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849297),
      surfaceContainerLow: Color(4279704607),
      surfaceContainer: Color(4279967779),
      surfaceContainerHigh: Color(4280625965),
      surfaceContainerHighest: Color(4281349688),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff08677f),
      surfaceTint: Color(0xff08677f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb7eaff),
      onPrimaryContainer: Color(0xff001f28),
      secondary: Color(0xff4c626b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcfe6f1),
      onSecondaryContainer: Color(0xff071e26),
      tertiary: Color(0xff5a5b7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe1e0ff),
      onTertiaryContainer: Color(0xff171837),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1f),
      surfaceVariant: Color(0xffdbe4e8),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787c),
      outlineVariant: Color(0xffa9b0b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e0e0),
      inverseOnSurface: Color(0xfff5f5f5),
      inversePrimary: Color(0xffa0c4ff),
      primaryFixed: Color(0xffc0eaff),
      onPrimaryFixed: Color(0xff001f28),
      primaryFixedDim: Color(0xffa0c4ff),
      onPrimaryFixedVariant: Color(0xff001f28),
      secondaryFixed: Color(0xffd0e6f1),
      onSecondaryFixed: Color(0xff071e26),
      secondaryFixedDim: Color(0xffb0c4d8),
      onSecondaryFixedVariant: Color(0xff071e26),
      tertiaryFixed: Color(0xffe0e0ff),
      onTertiaryFixed: Color(0xff171837),
      tertiaryFixedDim: Color(0xffc0c0ff),
      onTertiaryFixedVariant: Color(0xff171837),
      surfaceDim: Color(0xffe0e0e0),
      surfaceBright: Color(0xfff5f5f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f0f0),
      surfaceContainer: Color(0xffe0e0e0),
      surfaceContainerHigh: Color(0xffd0d0d0),
      surfaceContainerHighest: Color(0xffc0c0c0),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff08677f),
      surfaceTint: Color(0xff08677f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb7eaff),
      onPrimaryContainer: Color(0xff001f28),
      secondary: Color(0xff4c626b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcfe6f1),
      onSecondaryContainer: Color(0xff071e26),
      tertiary: Color(0xff5a5b7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe1e0ff),
      onTertiaryContainer: Color(0xff171837),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1f),
      surfaceVariant: Color(0xffdbe4e8),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787c),
      outlineVariant: Color(0xffa9b0b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e0e0),
      inverseOnSurface: Color(0xfff5f5f5),
      inversePrimary: Color(0xffa0c4ff),
      primaryFixed: Color(0xffc0eaff),
      onPrimaryFixed: Color(0xff001f28),
      primaryFixedDim: Color(0xffa0c4ff),
      onPrimaryFixedVariant: Color(0xff001f28),
      secondaryFixed: Color(0xffd0e6f1),
      onSecondaryFixed: Color(0xff071e26),
      secondaryFixedDim: Color(0xffb0c4d8),
      onSecondaryFixedVariant: Color(0xff071e26),
      tertiaryFixed: Color(0xffe0e0ff),
      onTertiaryFixed: Color(0xff171837),
      tertiaryFixedDim: Color(0xffc0c0ff),
      onTertiaryFixedVariant: Color(0xff171837),
      surfaceDim: Color(0xffe0e0e0),
      surfaceBright: Color(0xfff5f5f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f0f0),
      surfaceContainer: Color(0xffe0e0e0),
      surfaceContainerHigh: Color(0xffd0d0d0),
      surfaceContainerHighest: Color(0xffc0c0c0),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  /// Late
  static const late = ExtendedColor(
    seed: Color(4292083806),
    value: Color(4292083806),
    light: ColorFamily(
      color: Color(4287449433),
      onColor: Color(4294967295),
      colorContainer: Color(4294957535),
      onColorContainer: Color(4281992984),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4287449433),
      onColor: Color(4294967295),
      colorContainer: Color(4294957535),
      onColorContainer: Color(4281992984),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4287449433),
      onColor: Color(4294967295),
      colorContainer: Color(4294957535),
      onColorContainer: Color(4281992984),
    ),
    dark: ColorFamily(
      color: Color(4294947265),
      onColor: Color(4283768108),
      colorContainer: Color(4285608770),
      onColorContainer: Color(4294957535),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4294947265),
      onColor: Color(4283768108),
      colorContainer: Color(4285608770),
      onColorContainer: Color(4294957535),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4294947265),
      onColor: Color(4283768108),
      colorContainer: Color(4285608770),
      onColorContainer: Color(4294957535),
    ),
  );

  /// in Progress
  static const inProgress = ExtendedColor(
    seed: Color(4290423296),
    value: Color(4290423296),
    light: ColorFamily(
      color: Color(4285030162),
      onColor: Color(4294967295),
      colorContainer: Color(4294042762),
      onColorContainer: Color(4280294400),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4285030162),
      onColor: Color(4294967295),
      colorContainer: Color(4294042762),
      onColorContainer: Color(4280294400),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4285030162),
      onColor: Color(4294967295),
      colorContainer: Color(4294042762),
      onColorContainer: Color(4280294400),
    ),
    dark: ColorFamily(
      color: Color(4292135025),
      onColor: Color(4281741568),
      colorContainer: Color(4283385856),
      onColorContainer: Color(4294042762),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4292135025),
      onColor: Color(4281741568),
      colorContainer: Color(4283385856),
      onColorContainer: Color(4294042762),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4292135025),
      onColor: Color(4281741568),
      colorContainer: Color(4283385856),
      onColorContainer: Color(4294042762),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        late,
        inProgress,
      ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
