import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';

enum ToastType { success, error, warning, info }

void showToastNotification({
  required ToastType type,
  required String message,
  required BuildContext context,
  int durationInSeconds = 4,
}) {
  // final SnackBar snackBar = SnackBar(
  //   backgroundColor: Colors.transparent,
  //   elevation: 0,
  //   content: AppToastNotification(type: type, message: message),
  //   duration: Duration(seconds: durationInSeconds),
  // );

  // SchedulerBinding.instance.addPostFrameCallback((_) {
  //   if (context.mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // });
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => _TopToastWidget(
      onDismissed: () => overlayEntry.remove(),
      durationInSeconds: durationInSeconds,
      child: AppToastNotification(type: type, message: message),
    ),
  );

  overlay.insert(overlayEntry);
}

class _TopToastWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;
  final int durationInSeconds;

  const _TopToastWidget({
    required this.child,
    required this.onDismissed,
    required this.durationInSeconds,
  });

  @override
  State<_TopToastWidget> createState() => _TopToastWidgetState();
}

class _TopToastWidgetState extends State<_TopToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _offsetAnimation =
        Tween<Offset>(
          begin: const Offset(0, -1.0), // Comienza fuera de pantalla
          end: const Offset(0, 0), // Termina en su posición final
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut, // 👈 Animación suave sin rebote
          ),
        );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // Desaparece después de los segundos indicados
    Future.delayed(Duration(seconds: widget.durationInSeconds), () async {
      await _controller.reverse();
      if (mounted) widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0, // MediaQuery.of(context).padding.top, // Debajo del status bar
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(color: Colors.transparent, child: widget.child),
        ),
      ),
    );
  }
}

class AppToastNotification extends StatelessWidget {
  const AppToastNotification({
    super.key,
    required this.type,
    required this.message,
  });

  final ToastType type;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          // constraints: BoxConstraints(
          //   maxWidth: AppTheme.convertPixelsToLogicalPixels(context, 400),
          // ),
          width: double.infinity,
          // margin: EdgeInsets.symmetric(horizontal: context.spacing12),
          padding: EdgeInsets.only(
            bottom: context.spacing16,
            right: context.spacing16,
            left: context.spacing16,
            top: MediaQuery.paddingOf(context).top,
            // top: context.spacing12,
          ),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(12),
            color: switch (type) {
              ToastType.success => AppTheme.semanticColorSuccess,
              ToastType.error => AppTheme.semanticColorError,
              ToastType.warning => AppTheme.semanticColorWarning,
              ToastType.info => AppTheme.semanticColorInfo,
            },
          ),
          child: Row(
            children: [
              AppIcons.mediumIcon(switch (type) {
                ToastType.success => AppIcons.checkCircle,
                ToastType.error => AppIcons.error,
                ToastType.warning => AppIcons.warning,
                ToastType.info => AppIcons.warning,
              }, color: AppTheme.neutralColorWhite),
              SizedBox(width: context.spacing12),
              Expanded(
                child: Text(
                  message,
                  style: context.bodyBoldTextStyle.copyWith(
                    color: AppTheme.neutralColorWhite,
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
