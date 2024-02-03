import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w300,
      );
  static get bodyLargeBluegray70001 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray70001,
        fontWeight: FontWeight.w300,
      );
  static get bodyLargeBluegray70001_1 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray70001,
      );
  static get bodyLargeGray30002 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray30002,
      );
  static get bodyLargeGray600 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray600,
      );
  static get bodyLargeIBMPlexMonoBlack900 =>
      theme.textTheme.bodyLarge!.iBMPlexMono.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w300,
      );
  static get bodyLargeIBMPlexMonoBlack900ExtraLight =>
      theme.textTheme.bodyLarge!.iBMPlexMono.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w200,
      );
  static get bodyLargeOnPrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodyLargeRobotoBlack900 =>
      theme.textTheme.bodyLarge!.roboto.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w300,
      );
  static get bodyLargeff6c757d => theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF6C757D),
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumBluegray200 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray200,
      );
  static get bodyMediumGray600 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray600,
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 13.fSize,
      );
  static get bodyMediumff495057 => theme.textTheme.bodyMedium!.copyWith(
        color: const Color(0XFF495057),
      );
  static get bodyMediumff52b788 => theme.textTheme.bodyMedium!.copyWith(
        color: const Color(0XFF52B788),
      );
  static get bodySmallGray600 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallGray600Regular => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallGray600_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
      );
  static get bodySmallOnPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallRegular => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallff495057 => theme.textTheme.bodySmall!.copyWith(
        color: const Color(0XFF495057),
      );
  static get bodySmallff6c757d => theme.textTheme.bodySmall!.copyWith(
        color: const Color(0XFF6C757D),
        fontWeight: FontWeight.w400,
      );
  // Headline text style
  static get headlineLargeBaloo =>
      theme.textTheme.headlineLarge!.baloo.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get headlineLargePrimary => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get headlineSmallBaloo =>
      theme.textTheme.headlineSmall!.baloo.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get headlineSmallBalooff000000 =>
      theme.textTheme.headlineSmall!.baloo.copyWith(
        color: const Color(0XFF000000),
        fontWeight: FontWeight.w400,
      );
  static get headlineSmallBalooff6c757d =>
      theme.textTheme.headlineSmall!.baloo.copyWith(
        color: const Color(0XFF6C757D),
        fontWeight: FontWeight.w400,
      );
  static get headlineSmallBlack900 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static get headlineSmallBlack900_1 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
      );
  static get headlineSmallFigmaHand => theme.textTheme.headlineSmall!.figmaHand;
  static get headlineSmallFigmaHandBlack900 =>
      theme.textTheme.headlineSmall!.figmaHand.copyWith(
        color: appTheme.black900,
      );
  static get headlineSmallFigmaHandff000000 =>
      theme.textTheme.headlineSmall!.figmaHand.copyWith(
        color: const Color(0XFF000000),
      );
  static get headlineSmallPrimary => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get headlineSmallff000000 => theme.textTheme.headlineSmall!.copyWith(
        color: const Color(0XFF000000),
      );
  // Inter text style
  static get interOnPrimaryContainer => TextStyle(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w600,
      ).inter;
  // Label text style
  static get labelMediumPrimary => theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelSmallGray600 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w600,
      );
  // Title text style
  static get titleLargeBluegray70001 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray70001,
        fontSize: 22.fSize,
      );
  static get titleLargeBluegray7000123 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray70001,
        fontSize: 23.fSize,
      );
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumBlack90018 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
      );
  static get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumOnPrimaryContainerSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumOnPrimaryContainer_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get titleMediumff52b788 => theme.textTheme.titleMedium!.copyWith(
        color: const Color(0XFF52B788),
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallBluegray200 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray200,
      );
  static get titleSmallOnPrimaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallOnPrimaryContainer_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
        decorationColor: theme.colorScheme.primary,
      );
  static get titleSmallSemiBold => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleSmallff52b788 => theme.textTheme.titleSmall!.copyWith(
        color: const Color(0XFF52B788),
      );
}

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get figmaHand {
    return copyWith(
      fontFamily: 'Figma Hand',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get iBMPlexMono {
    return copyWith(
      fontFamily: 'IBM Plex Mono',
    );
  }

  TextStyle get baloo {
    return copyWith(
      fontFamily: 'Baloo',
    );
  }
}
