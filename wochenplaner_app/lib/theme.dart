import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 90, 99, 90),
      surfaceTint: Color(0xff39693c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbaf0b7),
      onPrimaryContainer: Color(0xff002106),
      secondary: Color(0xff526350),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd5e8d0),
      onSecondaryContainer: Color(0xff101f10),
      tertiary: Color(0xff39656b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcebf2),
      onTertiaryContainer: Color(0xff001f23),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff7fbf2),
      onBackground: Color(0xff181d17),
      surface: Color(0xfff7fbf2),
      onSurface: Color(0xff181d17),
      surfaceVariant: Color(0xffdee5d9),
      onSurfaceVariant: Color(0xff424940),
      outline: Color(0xff72796f),
      outlineVariant: Color(0xffc2c9bd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inverseOnSurface: Color(0xffeef2e9),
      inversePrimary: Color(0xff9ed49c),
      primaryFixed: Color(0xffbaf0b7),
      onPrimaryFixed: Color(0xff002106),
      primaryFixedDim: Color(0xff9ed49c),
      onPrimaryFixedVariant: Color(0xff205026),
      secondaryFixed: Color(0xffd5e8d0),
      onSecondaryFixed: Color(0xff101f10),
      secondaryFixedDim: Color(0xffb9ccb4),
      onSecondaryFixedVariant: Color(0xff3a4b39),
      tertiaryFixed: Color(0xffbcebf2),
      onTertiaryFixed: Color(0xff001f23),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff1f4d53),
      surfaceDim: Color(0xffd7dbd3),
      surfaceBright: Color(0xfff7fbf2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffebefe6),
      surfaceContainerHigh: Color(0xffe6e9e1),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff1c4c22),
      surfaceTint: Color(0xff39693c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4f8050),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff374735),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff687965),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1a494f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4f7c82),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7fbf2),
      onBackground: Color(0xff181d17),
      surface: Color(0xfff7fbf2),
      onSurface: Color(0xff181d17),
      surfaceVariant: Color(0xffdee5d9),
      onSurfaceVariant: Color(0xff3e453c),
      outline: Color(0xff5a6158),
      outlineVariant: Color(0xff767d73),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inverseOnSurface: Color(0xffeef2e9),
      inversePrimary: Color(0xff9ed49c),
      primaryFixed: Color(0xff4f8050),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff366639),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff687965),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4f604d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4f7c82),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff366369),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dbd3),
      surfaceBright: Color(0xfff7fbf2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffebefe6),
      surfaceContainerHigh: Color(0xffe6e9e1),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002909),
      surfaceTint: Color(0xff39693c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1c4c22),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff162616),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff374735),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00272b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a494f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7fbf2),
      onBackground: Color(0xff181d17),
      surface: Color(0xfff7fbf2),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdee5d9),
      onSurfaceVariant: Color(0xff1f261e),
      outline: Color(0xff3e453c),
      outlineVariant: Color(0xff3e453c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffc3fac0),
      primaryFixed: Color(0xff1c4c22),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff01350e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff374735),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff213120),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1a494f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003238),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dbd3),
      surfaceBright: Color(0xfff7fbf2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffebefe6),
      surfaceContainerHigh: Color(0xffe6e9e1),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9ed49c),
      surfaceTint: Color(0xff9ed49c),
      onPrimary: Color(0xff053911),
      primaryContainer: Color(0xff205026),
      onPrimaryContainer: Color(0xffbaf0b7),
      secondary: Color(0xffb9ccb4),
      onSecondary: Color(0xff243424),
      secondaryContainer: Color(0xff3a4b39),
      onSecondaryContainer: Color(0xffd5e8d0),
      tertiary: Color(0xffa1ced5),
      onTertiary: Color(0xff00363c),
      tertiaryContainer: Color(0xff1f4d53),
      onTertiaryContainer: Color(0xffbcebf2),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff101410),
      onBackground: Color(0xffe0e4db),
      surface: Color(0xff101410),
      onSurface: Color(0xffe0e4db),
      surfaceVariant: Color(0xff424940),
      onSurfaceVariant: Color(0xffc2c9bd),
      outline: Color(0xff8c9388),
      outlineVariant: Color(0xff424940),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inverseOnSurface: Color(0xff2d322c),
      inversePrimary: Color(0xff39693c),
      primaryFixed: Color(0xffbaf0b7),
      onPrimaryFixed: Color(0xff002106),
      primaryFixedDim: Color(0xff9ed49c),
      onPrimaryFixedVariant: Color(0xff205026),
      secondaryFixed: Color(0xffd5e8d0),
      onSecondaryFixed: Color(0xff101f10),
      secondaryFixedDim: Color(0xffb9ccb4),
      onSecondaryFixedVariant: Color(0xff3a4b39),
      tertiaryFixed: Color(0xffbcebf2),
      onTertiaryFixed: Color(0xff001f23),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff1f4d53),
      surfaceDim: Color(0xff101410),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff181d17),
      surfaceContainer: Color(0xff1c211b),
      surfaceContainerHigh: Color(0xff272b26),
      surfaceContainerHighest: Color(0xff313630),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa3d8a0),
      surfaceTint: Color(0xff9ed49c),
      onPrimary: Color(0xff001b04),
      primaryContainer: Color(0xff6a9d6a),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbdd0b9),
      onSecondary: Color(0xff0a1a0b),
      secondaryContainer: Color(0xff839680),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa5d3da),
      onTertiary: Color(0xff001a1d),
      tertiaryContainer: Color(0xff6c989f),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101410),
      onBackground: Color(0xffe0e4db),
      surface: Color(0xff101410),
      onSurface: Color(0xfff8fcf3),
      surfaceVariant: Color(0xff424940),
      onSurfaceVariant: Color(0xffc6cdc1),
      outline: Color(0xff9ea59a),
      outlineVariant: Color(0xff7e857b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inverseOnSurface: Color(0xff272b26),
      inversePrimary: Color(0xff225227),
      primaryFixed: Color(0xffbaf0b7),
      onPrimaryFixed: Color(0xff001603),
      primaryFixedDim: Color(0xff9ed49c),
      onPrimaryFixedVariant: Color(0xff0d3f17),
      secondaryFixed: Color(0xffd5e8d0),
      onSecondaryFixed: Color(0xff061407),
      secondaryFixedDim: Color(0xffb9ccb4),
      onSecondaryFixedVariant: Color(0xff2a3a29),
      tertiaryFixed: Color(0xffbcebf2),
      onTertiaryFixed: Color(0xff001417),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff083c42),
      surfaceDim: Color(0xff101410),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff181d17),
      surfaceContainer: Color(0xff1c211b),
      surfaceContainerHigh: Color(0xff272b26),
      surfaceContainerHighest: Color(0xff313630),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff0ffeb),
      surfaceTint: Color(0xff9ed49c),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa3d8a0),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff0ffeb),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbdd0b9),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff0fdff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa5d3da),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101410),
      onBackground: Color(0xffe0e4db),
      surface: Color(0xff101410),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff424940),
      onSurfaceVariant: Color(0xfff6fdf1),
      outline: Color(0xffc6cdc1),
      outlineVariant: Color(0xffc6cdc1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff00320c),
      primaryFixed: Color(0xffbef5bb),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa3d8a0),
      onPrimaryFixedVariant: Color(0xff001b04),
      secondaryFixed: Color(0xffd9ecd4),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbdd0b9),
      onSecondaryFixedVariant: Color(0xff0a1a0b),
      tertiaryFixed: Color(0xffc1eff6),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa5d3da),
      onTertiaryFixedVariant: Color(0xff001a1d),
      surfaceDim: Color(0xff101410),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff181d17),
      surfaceContainer: Color(0xff1c211b),
      surfaceContainerHigh: Color(0xff272b26),
      surfaceContainerHighest: Color(0xff313630),
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
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  /// Late
  static const late = ExtendedColor(
    seed: Color(0xffd4005e),
    value: Color(0xffd4005e),
    light: ColorFamily(
      color: Color(0xff8d4959),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffd9df),
      onColorContainer: Color(0xff3a0718),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff8d4959),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffd9df),
      onColorContainer: Color(0xff3a0718),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff8d4959),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffd9df),
      onColorContainer: Color(0xff3a0718),
    ),
    dark: ColorFamily(
      color: Color(0xffffb1c1),
      onColor: Color(0xff551d2c),
      colorContainer: Color(0xff713342),
      onColorContainer: Color(0xffffd9df),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb1c1),
      onColor: Color(0xff551d2c),
      colorContainer: Color(0xff713342),
      onColorContainer: Color(0xffffd9df),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb1c1),
      onColor: Color(0xff551d2c),
      colorContainer: Color(0xff713342),
      onColorContainer: Color(0xffffd9df),
    ),
  );

  /// in Progress
  static const inProgress = ExtendedColor(
    seed: Color(0xffbaaa00),
    value: Color(0xffbaaa00),
    light: ColorFamily(
      color: Color(0xff685f12),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff1e48a),
      onColorContainer: Color(0xff201c00),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff685f12),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff1e48a),
      onColorContainer: Color(0xff201c00),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff685f12),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff1e48a),
      onColorContainer: Color(0xff201c00),
    ),
    dark: ColorFamily(
      color: Color(0xffd4c871),
      onColor: Color(0xff363100),
      colorContainer: Color(0xff4f4800),
      onColorContainer: Color(0xfff1e48a),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffd4c871),
      onColor: Color(0xff363100),
      colorContainer: Color(0xff4f4800),
      onColorContainer: Color(0xfff1e48a),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffd4c871),
      onColor: Color(0xff363100),
      colorContainer: Color(0xff4f4800),
      onColorContainer: Color(0xfff1e48a),
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
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
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
