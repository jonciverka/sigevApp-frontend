import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';

class AppTheme {
  // Primary Color
  static const Color primaryColor = Color(0xff04569a);
  static const Color primaryColorHover = Color.fromARGB(255, 4, 74, 132);
  static const Color primaryColorDisabled = Color.fromARGB(255, 13, 141, 245);

  //Neutrals Colors
  static const Color neutralColorGrey950 = Color(0xFF101223);
  static const Color neutralColorGrey700 = Color(0xFF818181);
  static const Color neutralColorGrey400 = Color(0xFFBDBDBD);
  static const Color neutralColorGrey100 = Color(0xFFEFEFEF);
  static const Color neutralColorWhite = Color(0xFFFFFFFF);

  // Semantics Colors
  static const Color semanticColorError = Color(0xFFF73B3B);
  static const Color semanticColorSuccess = Color(0xFF46B477);
  static const Color semanticColorWarning = Color(0xFFFFBC00);
  static const Color semanticColorInfo = Color(0xFF006FF0);

  // Fonts Family
  static const String headLineFontFamily = 'RedHatDisplay_bold';
  static const String bodyFontFamily = "Montserrat";
  static const String buttonFontFamily = 'RedHatDisplay_bold';
  static const String captionFontFamily = 'Montserrat';

  // Headings Mobile text styles
  static TextStyle headingLarge(BuildContext context) => TextStyle(
    fontFamily: headLineFontFamily,
    fontWeight: FontWeight.w700,
    height: convertPixelsToLogicalPixels(context, 1.1),
    fontSize: convertPixelsToLogicalPixels(context, 24),
    color: neutralColorGrey950,
    letterSpacing: 0.0,
  );

  static TextStyle headingMedium(BuildContext context) => TextStyle(
    fontFamily: headLineFontFamily,
    fontWeight: FontWeight.w700,
    height: convertPixelsToLogicalPixels(context, 1.1),
    fontSize: convertPixelsToLogicalPixels(context, 20),
    color: neutralColorGrey950,
    letterSpacing: 0.0,
  );

  static TextStyle headingSmall(BuildContext context) => TextStyle(
    fontFamily: headLineFontFamily,
    fontWeight: FontWeight.w700,
    height: convertPixelsToLogicalPixels(context, 1.1),
    fontSize: convertPixelsToLogicalPixels(context, 16),
    color: neutralColorGrey950,
    letterSpacing: 0.0,
  );

  // Body Text Styles
  static TextStyle bodyRegular(BuildContext context) => TextStyle(
    fontFamily: bodyFontFamily,
    fontWeight: FontWeight.w400,
    height: convertPixelsToLogicalPixels(context, 1.1),
    fontSize: convertPixelsToLogicalPixels(context, 16),
    color: neutralColorGrey950,
    letterSpacing: 0.0,
  );

  static TextStyle bodyBold(BuildContext context) => TextStyle(
    fontFamily: bodyFontFamily,
    fontWeight: FontWeight.w700,
    height: convertPixelsToLogicalPixels(context, 1.1),
    fontSize: convertPixelsToLogicalPixels(context, 16),
    color: neutralColorGrey950,
    letterSpacing: 0.0,
  );
  // inputs text style
  static TextStyle inputRegular(BuildContext context) => TextStyle(
    fontFamily: bodyFontFamily,
    fontWeight: FontWeight.w400,
    height: convertPixelsToLogicalPixels(context, 1.1),
    fontSize: convertPixelsToLogicalPixels(context, 16),
    color: neutralColorGrey700,
    letterSpacing: 0.0,
  );

  //Error Text Styles
  static TextStyle errorRegular(BuildContext context) => TextStyle(
    fontFamily: bodyFontFamily,
    fontWeight: FontWeight.w400,
    height: convertPixelsToLogicalPixels(context, 1.1),
    fontSize: convertPixelsToLogicalPixels(context, 12),
    color: semanticColorError,
    letterSpacing: 0.0,
  );

  // Button Text Styles
  static TextStyle buttonTextStyle(BuildContext context) => TextStyle(
    fontFamily: buttonFontFamily,
    fontWeight: FontWeight.w700,
    fontSize: convertPixelsToLogicalPixels(context, 14),
    height: convertPixelsToLogicalPixels(context, 1.1),
    letterSpacing: 0.0,
  );

  // Caption Text Styles

  static TextStyle captionRegular(BuildContext context) => TextStyle(
    fontFamily: captionFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: convertPixelsToLogicalPixels(context, 12),
    height: convertPixelsToLogicalPixels(context, 1.1),
    color: neutralColorGrey950,
    letterSpacing: 0.0,
  );

  static TextStyle captionBold(BuildContext context) => TextStyle(
    fontFamily: captionFontFamily,
    fontWeight: FontWeight.w700,
    fontSize: convertPixelsToLogicalPixels(context, 12),
    color: neutralColorGrey950,
    letterSpacing: 0.0,
  );

  // Spacing sizes
  static int spacing2(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 2).floor();
  static int spacing4(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 4).floor();
  static int spacing8(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 8).floor();
  static int spacing12(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 12).floor();
  static int spacing16(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 16).floor();
  static int spacing20(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 20).floor();
  static int spacing24(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 24).floor();
  static int spacing32(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 32).floor();
  static int spacing40(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 40).floor();
  static int spacing44(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 44).floor();
  static int spacing48(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 48).floor();
  static int spacing56(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 56).floor();
  static int spacing64(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 64).floor();
  static int spacing72(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 72).floor();
  static int spacing80(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 80).floor();
  static int spacing88(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 88).floor();
  static int spacing120(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 120).floor();
  static int spacing134(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 134).floor();
  static int spacing240(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 240).floor();
  static int spacing340(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 340).floor();
  static int spacing360(BuildContext context) =>
      convertPixelsToLogicalPixels(context, 360).floor();

  // Elevation shadows
  static const List<BoxShadow> smallElevationShadow = [
    BoxShadow(
      color: Color(0x1A101223), // 10% opacity
      offset: Offset(2, 2),
      blurRadius: 6,
    ),
    BoxShadow(
      color: Color(0x17101223), // 9% opacity
      offset: Offset(8, 7),
      blurRadius: 11,
    ),
    BoxShadow(
      color: Color(0x0D101223), // 5% opacity
      offset: Offset(17, 16),
      blurRadius: 14,
    ),
    BoxShadow(
      color: Color(0x03101223), // 1% opacity
      offset: Offset(31, 29),
      blurRadius: 17,
    ),
  ];

  static const List<BoxShadow> largeElevationShadow = [
    BoxShadow(
      color: Color(0x1A101223), // 10% opacity
      offset: Offset(4, 4),
      blurRadius: 13,
    ),
    BoxShadow(
      color: Color(0x17101223), // 9% opacity
      offset: Offset(16, 17),
      blurRadius: 23,
    ),
    BoxShadow(
      color: Color(0x0D101223), // 5% opacity
      offset: Offset(35, 39),
      blurRadius: 32,
    ),
    BoxShadow(
      color: Color(0x03101223), // 1% opacity
      offset: Offset(63, 69),
      blurRadius: 38,
    ),
  ];

  // Button styles
  static ButtonStyle primaryFilledButtonStyle(BuildContext context) =>
      ButtonStyle(
        elevation: WidgetStateProperty.resolveWith<double?>((
          Set<WidgetState> states,
        ) {
          return 0;
        }),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((
          Set<WidgetState> states,
        ) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          );
        }),
        textStyle: WidgetStateProperty.resolveWith<TextStyle?>((
          Set<WidgetState> states,
        ) {
          return buttonTextStyle(context);
        }),
        fixedSize: WidgetStateProperty.resolveWith<Size?>((
          Set<WidgetState> states,
        ) {
          return Size.fromHeight(convertPixelsToLogicalPixels(context, 40));
        }),
        minimumSize: WidgetStateProperty.resolveWith<Size?>((
          Set<WidgetState> states,
        ) {
          return Size.fromWidth(spacing64(context).toDouble());
        }),
        side: WidgetStateProperty.resolveWith<BorderSide?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(
              color: semanticColorInfo,
              width: convertPixelsToLogicalPixels(context, 2).toDouble(),
            );
          }
          return BorderSide.none;
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey400;
          }
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return primaryColorHover;
          }
          return primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey700;
          }
          return neutralColorWhite;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return primaryColorHover;
          }
          return null;
        }),
      );

  static ButtonStyle secondaryFilledButtonStyle(BuildContext context) =>
      ButtonStyle(
        elevation: WidgetStateProperty.resolveWith<double?>((
          Set<WidgetState> states,
        ) {
          return 0;
        }),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((
          Set<WidgetState> states,
        ) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          );
        }),
        textStyle: WidgetStateProperty.resolveWith<TextStyle?>((
          Set<WidgetState> states,
        ) {
          return buttonTextStyle(context);
        }),
        fixedSize: WidgetStateProperty.resolveWith<Size?>((
          Set<WidgetState> states,
        ) {
          return Size.fromHeight(convertPixelsToLogicalPixels(context, 40));
        }),
        minimumSize: WidgetStateProperty.resolveWith<Size?>((
          Set<WidgetState> states,
        ) {
          return Size.fromWidth(spacing64(context).toDouble());
        }),
        side: WidgetStateProperty.resolveWith<BorderSide?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return BorderSide.none;
          }
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: neutralColorGrey400,
              width: convertPixelsToLogicalPixels(context, 2).toDouble(),
            );
          }
          if (states.contains(WidgetState.focused)) {
            return BorderSide(
              color: semanticColorInfo,
              width: convertPixelsToLogicalPixels(context, 2).toDouble(),
            );
          }
          return BorderSide(
            color: primaryColor,
            width: convertPixelsToLogicalPixels(context, 2).toDouble(),
          );
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.transparent;
          }
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return primaryColor;
          }
          if (states.contains(WidgetState.focused)) {
            return semanticColorInfo;
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return neutralColorWhite;
          }
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey400;
          }
          if (states.contains(WidgetState.focused)) {
            return neutralColorWhite;
          }
          return primaryColor;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return primaryColor;
          }
          return null;
        }),
      );

  static ButtonStyle tertiaryButtonStyle(
    BuildContext context, {
    bool withFixedHeight = true,
    bool isSelected = false,
  }) => ButtonStyle(
    elevation: WidgetStateProperty.resolveWith<double?>((
      Set<WidgetState> states,
    ) {
      return 0;
    }),
    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((
      Set<WidgetState> states,
    ) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(50));
    }),
    textStyle: WidgetStateProperty.resolveWith<TextStyle?>((
      Set<WidgetState> states,
    ) {
      return buttonTextStyle(context);
    }),
    fixedSize: withFixedHeight
        ? WidgetStateProperty.resolveWith<Size?>((Set<WidgetState> states) {
            return Size.fromHeight(convertPixelsToLogicalPixels(context, 40));
          })
        : null,
    minimumSize: WidgetStateProperty.resolveWith<Size?>((
      Set<WidgetState> states,
    ) {
      return Size.fromWidth(spacing64(context).toDouble());
    }),
    side: WidgetStateProperty.resolveWith<BorderSide?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.focused)) {
        return BorderSide(
          color: semanticColorInfo,
          width: convertPixelsToLogicalPixels(context, 2).toDouble(),
        );
      }
      return BorderSide.none;
    }),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      return Colors.transparent;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.pressed)) {
        return primaryColor;
      }
      if (states.contains(WidgetState.disabled)) {
        return neutralColorGrey400;
      }
      return isSelected ? primaryColor : Colors.black;
    }),
  );

  static ButtonStyle primaryIconButtonStyle(BuildContext context) =>
      ButtonStyle(
        elevation: WidgetStateProperty.resolveWith<double?>((
          Set<WidgetState> states,
        ) {
          return 0;
        }),
        side: WidgetStateProperty.resolveWith<BorderSide?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(
              color: semanticColorInfo,
              width: convertPixelsToLogicalPixels(context, 2).toDouble(),
            );
          }
          return BorderSide.none;
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey400;
          }
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return primaryColorHover;
          }
          return primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey700;
          }
          return neutralColorWhite;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return primaryColorHover;
          }
          return null;
        }),
      );
  static ButtonStyle primaryIconButtonStyleWhats(BuildContext context) =>
      ButtonStyle(
        elevation: WidgetStateProperty.resolveWith<double?>((
          Set<WidgetState> states,
        ) {
          return 0;
        }),
        side: WidgetStateProperty.resolveWith<BorderSide?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(
              color: semanticColorSuccess,
              width: convertPixelsToLogicalPixels(context, 2).toDouble(),
            );
          }
          return BorderSide.none;
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey400;
          }
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return semanticColorSuccess;
          }
          return semanticColorSuccess;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey700;
          }
          return neutralColorWhite;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return primaryColorHover;
          }
          return null;
        }),
      );

  static ButtonStyle primaryIconButtonChatStyle(BuildContext context) =>
      ButtonStyle(
        fixedSize: WidgetStateProperty.resolveWith<Size?>((
          Set<WidgetState> states,
        ) {
          return Size.fromRadius(convertPixelsToLogicalPixels(context, 25));
        }),
        elevation: WidgetStateProperty.all(20),
        shadowColor: WidgetStateProperty.all(
          Colors.black.withValues(alpha: 1),
        ), // Color de la sombra
        shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((
          Set<WidgetState> states,
        ) {
          return const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(500),
              topRight: Radius.circular(500),
              bottomLeft: Radius.circular(500),
            ),
          );
        }),
        side: WidgetStateProperty.resolveWith<BorderSide?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(
              color: semanticColorInfo,
              width: convertPixelsToLogicalPixels(context, 2).toDouble(),
            );
          }
          return BorderSide(
            strokeAlign: .5,
            color: neutralColorWhite,
            width: convertPixelsToLogicalPixels(context, 3).toDouble(),
          );
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey400;
          }
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return primaryColorHover;
          }
          return primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey700;
          }
          return neutralColorWhite;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return primaryColorHover;
          }
          return null;
        }),
      );
  static ButtonStyle secondaryIconButtonStyle(BuildContext context) =>
      ButtonStyle(
        padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry?>((
          Set<WidgetState> states,
        ) {
          return EdgeInsets.zero;
        }),
        elevation: WidgetStateProperty.resolveWith<double?>((
          Set<WidgetState> states,
        ) {
          return 0;
        }),
        side: WidgetStateProperty.resolveWith<BorderSide?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(
              color: semanticColorInfo,
              width: convertPixelsToLogicalPixels(context, 2).toDouble(),
            );
          }
          return BorderSide.none;
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return neutralColorGrey400;
          }
          return null;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey400;
          }
          return neutralColorGrey950;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return neutralColorGrey400;
          }
          return null;
        }),
      );

  static ButtonStyle secondaryIconButtonStyleWithBadge(BuildContext context) =>
      ButtonStyle(
        elevation: WidgetStateProperty.resolveWith<double?>((
          Set<WidgetState> states,
        ) {
          return 0;
        }),
        side: WidgetStateProperty.resolveWith<BorderSide?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(
              color: semanticColorInfo,
              width: convertPixelsToLogicalPixels(context, 2).toDouble(),
            );
          }
          return BorderSide.none;
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return neutralColorGrey400;
          }
          return neutralColorGrey400;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return neutralColorGrey400;
          }
          return Colors.black;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return neutralColorGrey400;
          }
          return null;
        }),
      );

  static ButtonStyle cartIconButtonStyle(BuildContext context) => ButtonStyle(
    padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry?>((
      Set<WidgetState> states,
    ) {
      return EdgeInsets.zero;
    }),
    elevation: WidgetStateProperty.resolveWith<double?>((
      Set<WidgetState> states,
    ) {
      return 0;
    }),
    side: WidgetStateProperty.resolveWith<BorderSide?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.focused)) {
        return BorderSide(
          color: semanticColorInfo,
          width: convertPixelsToLogicalPixels(context, 2).toDouble(),
        );
      }
      return BorderSide.none;
    }),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.disabled)) {
        return neutralColorGrey400;
      }
      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered)) {
        return primaryColorHover;
      }
      return primaryColor;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.disabled)) {
        return neutralColorGrey700;
      }
      return neutralColorWhite;
    }),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered)) {
        return primaryColorHover;
      }
      return null;
    }),
  );

  // Input Styles
  static InputDecoration textFieldDecoration(
    BuildContext context, {
    String? labelText,
    String? errorText,
    IconData? suffixIcon,
    IconData? prefixIcon,
    bool isEnabled = true,
    bool ifSuffixIconAButton = false,
    bool smallBorderRadius = false,
    bool applyConstraints = false,
    VoidCallback? onIconButtonPressed,
    bool showFocusedBorder = true,
    bool showBorder = true,
    required hintText, // <-- nuevo parámetro
  }) {
    final double inputBorderRadius = smallBorderRadius ? 8 : 12;
    return InputDecoration(
      labelText: labelText,
      alignLabelWithHint: true,
      errorMaxLines: 3,
      floatingLabelStyle: context.captionRegularTextStyle.copyWith(
        color: neutralColorGrey700,
      ),
      labelStyle: context.bodyRegularTextStyle.copyWith(
        color: neutralColorGrey700,
      ),
      hintText: hintText,
      hintStyle: context.bodyRegularTextStyle.copyWith(
        color: neutralColorGrey700,
      ),
      errorText: errorText,
      errorStyle: context.captionRegularTextStyle.copyWith(
        color: semanticColorError,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      isDense: true,
      contentPadding: EdgeInsets.all(
        kIsWeb ? context.spacing16 : context.spacing12,
      ),
      prefixIcon: prefixIcon == null
          ? null
          : AppIcons.mediumIcon(
              prefixIcon,
              color: isEnabled ? neutralColorGrey700 : neutralColorGrey400,
            ),
      suffixIconConstraints: BoxConstraints(
        maxHeight: context.spacing32,
        maxWidth: convertPixelsToLogicalPixels(context, 42),
      ),
      suffixIcon: suffixIcon == null
          ? null
          : onIconButtonPressed != null
          ? Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: onIconButtonPressed,
                  focusColor: AppTheme.neutralColorGrey400,
                  borderRadius: BorderRadius.circular(10000),
                  child: Container(
                    alignment: Alignment.center, // Asegura el centrado
                    child: AppIcons.mediumIcon(
                      suffixIcon,
                      color: isEnabled
                          ? neutralColorGrey700
                          : neutralColorGrey400,
                    ),
                  ),
                ),
              ),
            )
          : Container(
              margin: const EdgeInsets.only(right: 10),
              child: AppIcons.mediumIcon(
                suffixIcon,
                color: isEnabled ? neutralColorGrey700 : neutralColorGrey400,
              ),
            ),
      filled: true,
      fillColor: showBorder ? neutralColorWhite : Colors.transparent,
      focusColor: showBorder ? neutralColorWhite : Colors.transparent,
      hoverColor: showBorder ? neutralColorGrey100 : Colors.transparent,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputBorderRadius),
        borderSide: BorderSide(
          color: semanticColorError,
          width: context.spacing2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputBorderRadius),
        borderSide: BorderSide(
          color: showBorder ? neutralColorGrey700 : Colors.transparent,
          width: context.spacing2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputBorderRadius),
        borderSide: BorderSide(
          color: showBorder ? semanticColorError : Colors.transparent,
          width: context.spacing2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputBorderRadius),
        borderSide: BorderSide(
          color: showBorder ? neutralColorGrey400 : Colors.transparent,
          width: context.spacing2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputBorderRadius),
        borderSide: BorderSide(
          color: showBorder ? neutralColorGrey700 : Colors.transparent,
          width: context.spacing2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputBorderRadius),
        borderSide: BorderSide(
          color: showBorder ? neutralColorGrey700 : Colors.transparent,
          width: context.spacing2,
        ),
      ),
      constraints: applyConstraints
          ? BoxConstraints(
              maxHeight: context.spacing40,
              minHeight: context.spacing40,
            )
          : null,
    );
  }

  static RadioThemeData radioTheme = RadioThemeData(
    overlayColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.pressed)) {
        return primaryColorDisabled;
      }
      if (states.contains(WidgetState.hovered)) {
        return neutralColorGrey100;
      }

      if (states.contains(WidgetState.focused)) {
        return neutralColorGrey400;
      }
      return null;
    }),
  );

  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
      fontFamily: "intro_regular",
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: neutralColorWhite,
        secondary: neutralColorWhite,
        onSecondary: neutralColorGrey950,
        error: semanticColorError,
        onError: neutralColorWhite,
        surface: neutralColorWhite,
        onSurface: neutralColorGrey950,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: neutralColorWhite,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        bodyLarge: bodyRegular(context),
        bodyMedium: buttonTextStyle(context),
        bodySmall: captionRegular(context),
        titleLarge: headingLarge(context),
        titleMedium: headingMedium(context),
        titleSmall: headingSmall(context),
      ),
      radioTheme: radioTheme,
    );
  }

  // Helpers
  static double convertPixelsToLogicalPixels(
    BuildContext context,
    double physicalFontSize,
  ) {
    // double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return physicalFontSize; //physicalFontSize / devicePixelRatio;
  }
}

// Extensions
extension SpacingExtension on BuildContext {
  double get spacing2 => AppTheme.spacing2(this).toDouble();
  double get spacing4 => AppTheme.spacing4(this).toDouble();
  double get spacing8 => AppTheme.spacing8(this).toDouble();
  double get spacing12 => AppTheme.spacing12(this).toDouble();
  double get spacing16 => AppTheme.spacing16(this).toDouble();

  double get spacing20 => AppTheme.spacing20(this).toDouble();
  double get spacing24 => AppTheme.spacing24(this).toDouble();
  double get spacing32 => AppTheme.spacing32(this).toDouble();
  double get spacing40 => AppTheme.spacing40(this).toDouble();
  double get spacing44 => AppTheme.spacing44(this).toDouble();
  double get spacing48 => AppTheme.spacing48(this).toDouble();
  double get spacing56 => AppTheme.spacing56(this).toDouble();
  double get spacing64 => AppTheme.spacing64(this).toDouble();
  double get spacing72 => AppTheme.spacing72(this).toDouble();
  double get spacing80 => AppTheme.spacing80(this).toDouble();
  double get spacing88 => AppTheme.spacing88(this).toDouble();
  double get spacing120 => AppTheme.spacing120(this).toDouble();
  double get spacing134 => AppTheme.spacing134(this).toDouble();
  double get spacing240 => AppTheme.spacing240(this).toDouble();
  double get spacing340 => AppTheme.spacing340(this).toDouble();
  double get spacing360 => AppTheme.spacing360(this).toDouble();
}

extension TextStylesExtension on BuildContext {
  TextStyle get bodyRegularTextStyle => AppTheme.bodyRegular(this);
  TextStyle get bodyRegularInputStyle => AppTheme.inputRegular(this);
  TextStyle get bodyBoldTextStyle => AppTheme.bodyBold(this);
  TextStyle get headingLargeTextStyle => AppTheme.headingLarge(this);
  TextStyle get headingMediumTextStyle => AppTheme.headingMedium(this);
  TextStyle get headingSmallTextStyle => AppTheme.headingSmall(this);
  TextStyle get buttonTextStyle => AppTheme.buttonTextStyle(this);
  TextStyle get captionBoldTextStyle => AppTheme.captionBold(this);
  TextStyle get captionRegularTextStyle => AppTheme.captionRegular(this);
  TextStyle get errorTextstStyle => AppTheme.errorRegular(this);
}
