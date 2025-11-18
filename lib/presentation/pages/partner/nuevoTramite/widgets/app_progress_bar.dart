import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({super.key});
  @override
  Widget build(BuildContext context) {
    var nuevoTramiteCubit = context.watch<NuevoTramiteCubit>();

    Color getColor(ProgressBarStatus status) {
      if (status.value == nuevoTramiteCubit.getStatusPage().value) {
        return AppTheme.semanticColorSuccess;
      } else if (status.value < nuevoTramiteCubit.getStatusPage().value) {
        return AppTheme.semanticColorSuccess;
      }
      return AppTheme.neutralColorDarkGrey;
    }

    return Stack(
      children: [
        SizedBox(
          width: 288,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: getColor(ProgressBarStatus.contribuyente),
                child: Icon(AppIcons.person, size: AppIcons.iconSmallSize),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: 100,
                  backgroundColor: AppTheme.neutralColorDarkGrey,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    getColor(ProgressBarStatus.tramite),
                  ),
                  minHeight: context.spacing4,
                ),
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: getColor(ProgressBarStatus.tramite),
                child: Icon(AppIcons.list, size: AppIcons.iconSmallSize),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: 100,
                  backgroundColor: AppTheme.neutralColorDarkGrey,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    getColor(ProgressBarStatus.vehiculo),
                  ),
                  minHeight: context.spacing4,
                ),
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: getColor(ProgressBarStatus.vehiculo),
                child: Icon(
                  AppIcons.directionCar,
                  size: AppIcons.iconSmallSize,
                ),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: 100,
                  backgroundColor: AppTheme.neutralColorDarkGrey,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    getColor(ProgressBarStatus.pago),
                  ),
                  minHeight: context.spacing4,
                ),
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: getColor(ProgressBarStatus.pago),
                child: Icon(AppIcons.dollar, size: AppIcons.iconSmallSize),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
