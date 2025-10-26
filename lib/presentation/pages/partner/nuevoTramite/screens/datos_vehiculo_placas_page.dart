import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_row_opcions_radio_button.dart';

class DatosVehiculoPlacasPage extends StatelessWidget {
  const DatosVehiculoPlacasPage({
    super.key,
    this.onButtonNextPressed,
    this.onButtonBackPressed,
    this.onButtonCatalogPressed,
    this.onButtonGenerateCodePressed,
  });
  final void Function()? onButtonNextPressed;
  final void Function()? onButtonBackPressed;
  final void Function()? onButtonCatalogPressed;
  final void Function()? onButtonGenerateCodePressed;

  @override
  Widget build(BuildContext context) {
    var nuevoTramiteCubit = context.read<NuevoTramiteCubit>();
    return Column(
      children: [
        Text(
          AppLocale.subtituloDatosDelVehiculoNuevoTramite.getString(context),
          style: context.headingLargeTextStyle,
        ),
        SizedBox(height: context.spacing20),
        AppRowOpcionsRadioButton(
          groupValue: nuevoTramiteCubit.groupRadioButtonPlacaActual,
          label: AppLocale.lavelPlacaActualNuevoTramite.getString(context),
          child: SizedBox.shrink(),
          onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
            value ?? '',
            "groupRadioButtonPlacaActual",
          ),
        ),
        SizedBox(height: context.spacing12),
        AppRowOpcionsRadioButton(
          groupValue: nuevoTramiteCubit.groupRadioButtonDesechoPlaca,
          label: AppLocale.lavelDesechoDePlacaNuevoTramite.getString(context),
          child: SizedBox.shrink(),
          onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
            value ?? '',
            "groupRadioButtonDesechoPlaca",
          ),
        ),
        SizedBox(height: context.spacing12),
        AppRowOpcionsRadioButton(
          groupValue: nuevoTramiteCubit.groupRadioButtonDesechoTarjeta,
          label: AppLocale.lavelDesechoDeTarjetaDeCirculacionNuevaNuevoTramite
              .getString(context),
          child: SizedBox.shrink(),
          onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
            value ?? '',
            "groupRadioButtonDesechoTarjeta",
          ),
        ),
        SizedBox(height: context.spacing12),
        AppRowOpcionsRadioButton(
          groupValue: nuevoTramiteCubit.groupRadioButtonTerminacionPlacaNueva,
          label: AppLocale.lavelTerminacionDePlacaNuevoTramite.getString(
            context,
          ),
          child: SizedBox.shrink(),
          onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
            value ?? '',
            "groupRadioButtonTerminacionPlacaNueva",
          ),
        ),
        Spacer(),
        AppFooter(
          onButtonBackPressed: onButtonBackPressed,
          onButtonCatalogPressed: onButtonCatalogPressed,
          onButtonGenerateCodePressed: onButtonGenerateCodePressed,
          onButtonNextPressed: onButtonNextPressed,
        ),
      ],
    );
  }
}
