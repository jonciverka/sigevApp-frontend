import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/config/theme/app_theme.dart';

enum StatusCreandoTramite {
  inicio(0),
  creandoCotizacion(10),
  creandoTramite(50),
  esperando(60),
  finalizado(100);

  final double value;
  const StatusCreandoTramite(this.value);
}

class AppLoaderCreandoTramite extends StatelessWidget {
  const AppLoaderCreandoTramite({super.key, required this.status});

  final StatusCreandoTramite status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing24,
        vertical: context.spacing32,
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StaticText(
              text: AppLocale.textGenerandoCodigo.getString(context),
              isActive: status == StatusCreandoTramite.creandoCotizacion,
            ),

            if (status != StatusCreandoTramite.creandoCotizacion)
              const SizedBox(height: 32),

            if (status != StatusCreandoTramite.creandoCotizacion)
              _AnimatedAppearText(
                key: const ValueKey('documentos'),
                text: AppLocale.textSolicitandoDocumentos.getString(context),
                isActive: status == StatusCreandoTramite.creandoTramite,
              ),

            if (status != StatusCreandoTramite.creandoCotizacion &&
                status != StatusCreandoTramite.creandoTramite)
              const SizedBox(height: 32),

            if (status != StatusCreandoTramite.creandoCotizacion &&
                status != StatusCreandoTramite.creandoTramite)
              _AnimatedAppearText(
                key: const ValueKey('cargando'),
                text: AppLocale.textCargando.getString(context),
                isActive: status == StatusCreandoTramite.esperando,
              ),

            const SizedBox(height: 32),

            Padding(
              padding: EdgeInsets.symmetric(vertical: context.spacing12),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: status.value / 100),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryColor,
                    ),
                    minHeight: 5,
                    borderRadius: BorderRadius.circular(context.spacing16),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StaticText extends StatelessWidget {
  const _StaticText({required this.text, required this.isActive});

  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.headingLargeTextStyle.copyWith(
        color: isActive
            ? AppTheme.neutralColorGrey950
            : AppTheme.neutralColorGrey400,
      ),
    );
  }
}

class _AnimatedAppearText extends StatefulWidget {
  const _AnimatedAppearText({
    super.key,
    required this.text,
    required this.isActive,
  });

  final String text;
  final bool isActive;

  @override
  State<_AnimatedAppearText> createState() => _AnimatedAppearTextState();
}

class _AnimatedAppearTextState extends State<_AnimatedAppearText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    // 👇 entra desde abajo hacia arriba
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Text(
          widget.text,
          style: context.headingLargeTextStyle.copyWith(
            color: widget.isActive
                ? AppTheme.neutralColorGrey950
                : AppTheme.neutralColorGrey400,
          ),
        ),
      ),
    );
  }
}
