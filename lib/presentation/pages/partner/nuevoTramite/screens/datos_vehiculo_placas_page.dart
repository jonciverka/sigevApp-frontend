import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/models/entidad.dart';
import 'package:sigev/domain/models/tipo_desecho.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_row_opcions_radio_button.dart';
import 'package:sigev/presentation/widgets/app_dropdown.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';
import 'package:sigev/presentation/widgets/app_radio_button.dart';

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
  Widget columnPlacaActual({
    required NuevoTramiteCubit nuevoTramiteCubit,
    required CatalogoCotizacion catalogos,
    required BuildContext context,
  }) {
    return Column(
      children: [
        SizedBox(height: context.spacing12),
        AppTextFormField(
          keyboardType: TextInputType.text,
          controller: nuevoTramiteCubit.placaActualController,
          hintText: AppLocale.lavelPlacaActualNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        SizedBox(height: context.spacing12),
        AppDropDown<Entidad>(
          initialValue: nuevoTramiteCubit.entidadPlacaActual,
          hint: AppLocale.lavelEntidadDeLaPlacaActualNuevoTramite.getString(
            context,
          ),
          items: catalogos.entidad?.toList() ?? [],
          onSelectItem: (value) => nuevoTramiteCubit.entidadPlacaActual =
              catalogos.entidad?.firstWhere((e) => e == value),
          labelBuilder: (item) => item.entidadAbreviatura ?? '',
          validator: (p0) {
            if (p0?.isEmpty ?? true) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
        ),
        SizedBox(height: context.spacing20),
      ],
    );
  }

  Widget columnDesechoPlaca({
    required NuevoTramiteCubit nuevoTramiteCubit,
    required CatalogoCotizacion catalogos,
    required BuildContext context,
  }) {
    return Column(
      children: [
        SizedBox(height: context.spacing12),
        AppDropDown<TipoDesecho>(
          initialValue: nuevoTramiteCubit.tipoDesechoPlacaEntregado,
          hint: AppLocale.lavelDesechoDePlacaNuevaNuevoTramite.getString(
            context,
          ),
          items: catalogos.tipoDesecho?.toList() ?? [],
          onSelectItem: (value) => nuevoTramiteCubit.tipoDesechoPlacaEntregado =
              catalogos.tipoDesecho?.firstWhere((e) => e == value),
          labelBuilder: (item) => item.nombre ?? '',
          validator: (p0) {
            if (p0?.isEmpty ?? true) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
        ),
        SizedBox(height: context.spacing12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppRadioButton<String>(
              label: AppLocale.textRadioEntregado.getString(context),
              value: "1",
              groupValue:
                  nuevoTramiteCubit.groupRadioButtonDesechoPlacaEntregado,
              onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
                value ?? '',
                "groupRadioButtonDesechoPlacaEntregado",
              ),
            ),
            AppRadioButton<String>(
              label: AppLocale.textRadioPendiente.getString(context),
              value: "2",
              groupValue:
                  nuevoTramiteCubit.groupRadioButtonDesechoPlacaEntregado,
              onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
                value ?? '',
                "groupRadioButtonDesechoPlacaEntregado",
              ),
            ),
          ],
        ),
        SizedBox(height: context.spacing20),
      ],
    );
  }

  Widget columnDesechoTarjetaCirulacion({
    required NuevoTramiteCubit nuevoTramiteCubit,
    required CatalogoCotizacion catalogos,
    required BuildContext context,
  }) {
    return Column(
      children: [
        SizedBox(height: context.spacing12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppRadioButton<String>(
              label: AppLocale.textRadioEntregado.getString(context),
              value: "1",
              groupValue:
                  nuevoTramiteCubit.groupRadioButtonDesechoTarjetaEntregado,
              onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
                value ?? '',
                "groupRadioButtonDesechoTarjetaEntregado",
              ),
            ),
            AppRadioButton<String>(
              label: AppLocale.textRadioPendiente.getString(context),
              value: "2",
              groupValue:
                  nuevoTramiteCubit.groupRadioButtonDesechoTarjetaEntregado,
              onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
                value ?? '',
                "groupRadioButtonDesechoTarjetaEntregado",
              ),
            ),
          ],
        ),
        SizedBox(height: context.spacing20),
      ],
    );
  }

  Widget columnTerminacionPlacaNueva({
    required NuevoTramiteCubit nuevoTramiteCubit,
    required CatalogoCotizacion catalogos,
    required BuildContext context,
  }) {
    return Column(
      children: [
        SizedBox(height: context.spacing12),
        AppDropDown<String>(
          initialValue:
              nuevoTramiteCubit.terminacionPlacaEntregadoOpcionUno?.nombre,
          hint: AppLocale.lavelOpcionUnoNuevoTramite.getString(context),
          items:
              catalogos.terminacionPlaca?.map((e) => e.nombre ?? '').toList() ??
              [],
          onSelectItem: (value) =>
              nuevoTramiteCubit.terminacionPlacaEntregadoOpcionUno = catalogos
                  .terminacionPlaca
                  ?.firstWhere((e) => e.nombre == value),
          labelBuilder: (item) => item,
          validator: (p0) {
            if (p0?.isEmpty ?? true) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
        ),
        SizedBox(height: context.spacing12),
        AppDropDown<String>(
          initialValue:
              nuevoTramiteCubit.terminacionPlacaEntregadoOpcionDos?.nombre,
          hint: AppLocale.lavelOpcionDosNuevoTramite.getString(context),
          items:
              catalogos.terminacionPlaca?.map((e) => e.nombre ?? '').toList() ??
              [],
          onSelectItem: (value) =>
              nuevoTramiteCubit.terminacionPlacaEntregadoOpcionDos = catalogos
                  .terminacionPlaca
                  ?.firstWhere((e) => e.nombre == value),
          labelBuilder: (item) => item,
          validator: (p0) {
            if (p0?.isEmpty ?? true) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
        ),
        SizedBox(height: context.spacing20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var nuevoTramiteCubit = context.read<NuevoTramiteCubit>();
    var catalogos = nuevoTramiteCubit.state.catalogos;
    return Form(
      key: nuevoTramiteCubit.formularioStateVehiculoPlaca,
      child: Column(
        children: [
          Text(
            AppLocale.subtituloDatosDelVehiculoNuevoTramite.getString(context),
            style: context.headingMediumTextStyle,
          ),
          SizedBox(height: context.spacing20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppRowOpcionsRadioButton(
                    groupValue: nuevoTramiteCubit.groupRadioButtonPlacaActual,
                    label: AppLocale.lavelPlacaActualNuevoTramite.getString(
                      context,
                    ),
                    child: columnPlacaActual(
                      nuevoTramiteCubit: nuevoTramiteCubit,
                      catalogos: catalogos,
                      context: context,
                    ),
                    onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
                      value ?? '',
                      "groupRadioButtonPlacaActual",
                    ),
                  ),
                  SizedBox(height: context.spacing12),
                  AppRowOpcionsRadioButton(
                    groupValue: nuevoTramiteCubit.groupRadioButtonDesechoPlaca,
                    label: AppLocale.lavelDesechoDePlacaNuevoTramite.getString(
                      context,
                    ),
                    child: columnDesechoPlaca(
                      nuevoTramiteCubit: nuevoTramiteCubit,
                      catalogos: catalogos,
                      context: context,
                    ),
                    onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
                      value ?? '',
                      "groupRadioButtonDesechoPlaca",
                    ),
                  ),
                  SizedBox(height: context.spacing12),
                  AppRowOpcionsRadioButton(
                    groupValue:
                        nuevoTramiteCubit.groupRadioButtonDesechoTarjeta,
                    label: AppLocale
                        .lavelDesechoDeTarjetaDeCirculacionNuevaNuevoTramite
                        .getString(context),
                    child: columnDesechoTarjetaCirulacion(
                      nuevoTramiteCubit: nuevoTramiteCubit,
                      catalogos: catalogos,
                      context: context,
                    ),
                    onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
                      value ?? '',
                      "groupRadioButtonDesechoTarjeta",
                    ),
                  ),
                  SizedBox(height: context.spacing12),
                  AppRowOpcionsRadioButton(
                    groupValue:
                        nuevoTramiteCubit.groupRadioButtonTerminacionPlacaNueva,
                    label: AppLocale.lavelTerminacionDePlacaNuevoTramite
                        .getString(context),
                    child: columnTerminacionPlacaNueva(
                      nuevoTramiteCubit: nuevoTramiteCubit,
                      catalogos: catalogos,
                      context: context,
                    ),
                    onChanged: (value) => nuevoTramiteCubit.changeValueRadio(
                      value ?? '',
                      "groupRadioButtonTerminacionPlacaNueva",
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppFooter(
            onButtonBackPressed: onButtonBackPressed,
            onButtonCatalogPressed: onButtonCatalogPressed,
            onButtonGenerateCodePressed: onButtonGenerateCodePressed,
            onButtonNextPressed: onButtonNextPressed,
          ),
        ],
      ),
    );
  }
}
