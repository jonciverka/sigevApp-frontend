import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

class PreviewImagePage extends StatelessWidget {
  const PreviewImagePage({
    super.key,
    required this.bytes,
    required this.onBackPressed,
  });
  final Uint8List bytes;
  final Function(Uint8List) onBackPressed;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIconButton(
                icon: AppIcons.close,
                onPressed: () => Navigator.pop(context),
                iconSize: IconSize.medium,
              ),
              PinchZoom(
                maxScale: 2.5,
                onZoomStart: () {},
                onZoomEnd: () {},
                child: Image.memory(bytes, fit: BoxFit.contain),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.spacing12,
                  horizontal: context.spacing12,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: AppIconButton(
                    icon: AppIcons.arrowForward,
                    onPressed: () {
                      onBackPressed(bytes);
                      Navigator.pop(context);
                    },
                    iconSize: IconSize.medium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
