import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/assets_constants.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/login/cubit/seguimiento_cubit.dart';
import 'package:sigev/presentation/pages/login/cubit/seguimiento_state.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';

class SeguimientoTramitePage extends StatelessWidget {
  const SeguimientoTramitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => SeguimientoCubit(context: context),
            child: BlocBuilder<SeguimientoCubit, SeguimientoState>(
              builder: (context, state) {
                switch (state) {
                  case SeguimientoError():
                    return cuerpoWgt(context);
                  case SeguimientoLoading():
                    return const AppLoader();
                  case SeguimientoData():
                    return cuerpoWgt(context);
                  case SeguimientoInitial():
                    return cuerpoWgt(context);
                  default:
                    return const AppLoader();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget cuerpoWgt(BuildContext context) {
  final seguimientoCubit = context.read<SeguimientoCubit>();
  return Stack(
    children: [
      Positioned(
        bottom: 0,
        child: Opacity(
          opacity: .1,
          child: Image.asset(AssetsConstants.flechaLoco),
        ),
      ),
      Form(
        key: seguimientoCubit.fomularioState,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                AppLocale.lavelTituloSeguimiento.getString(context),
                style: context.headingLargeTextStyle,
              ),
              SizedBox(height: context.spacing24),
              AppTextFormField(
                key: UniqueKey(),
                keyboardType: TextInputType.text,
                controller: seguimientoCubit.codigoTramiteController,
                labelText: AppLocale.codigoTramiteController.getString(context),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
              SizedBox(height: context.spacing24),
              AppTextFormField(
                key: UniqueKey(),
                keyboardType: TextInputType.number,
                controller: seguimientoCubit.anioVehiculoController,
                labelText: AppLocale.anioVehiculoController.getString(context),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
              SizedBox(height: context.spacing24),
              Row(
                children: [
                  AppIconButton(
                    icon: AppIcons.arrowBack,
                    iconSize: IconSize.medium,
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: AppPrimaryButton(
                      onPressed: () => seguimientoCubit.apiGetSeguimiento(),
                      label: AppLocale.comprobarEstadoController.getString(
                        context,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.spacing72),
            ],
          ),
        ),
      ),
    ],
  );
}
