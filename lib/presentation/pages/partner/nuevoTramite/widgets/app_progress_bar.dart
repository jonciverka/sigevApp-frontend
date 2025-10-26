import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({super.key});
  @override
  Widget build(BuildContext context) {
    var nuevoTramiteCubit = context.watch<NuevoTramiteCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.spacing12),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: (nuevoTramiteCubit.page) / 8),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
            minHeight: 10,
            borderRadius: BorderRadius.circular(context.spacing16),
          );
        },
      ),
    );
  }
}
