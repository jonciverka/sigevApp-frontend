import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/entidad.dart';
import 'package:sigev/domain/models/tipo_tramite.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';
import 'package:sigev/presentation/widgets/app_dropdown.dart';

class DatosTramitePage extends StatelessWidget {
  const DatosTramitePage({
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
    var nuevoTramiteCubit = context.watch<NuevoTramiteCubit>();
    var catalogos = nuevoTramiteCubit.state.catalogos;
    var spacer = SizedBox(height: context.spacing16);
    return Form(
      key: nuevoTramiteCubit.formularioStateDatosTramite,
      child: Column(
        children: [
          Text(
            AppLocale.subtituloDatosDelTramiteNuevoTramite.getString(context),
            style: context.headingMediumTextStyle,
          ),
          spacer,
          AppDropDown<TipoTramite>(
            initialValue: nuevoTramiteCubit.tipoTramite,
            hint: AppLocale.lavelTipoDeTramiteNuevoTramite.getString(context),
            items: catalogos.tiposTramite?.toList() ?? [],
            onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
              nuevoTramiteCubit.tipoTramite = catalogos.tiposTramite
                  ?.firstWhere((e) => e == value);
            }),
            labelBuilder: (item) => "${item.alias} - ${item.nombre}",
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return AppLocale.campoObligatorio.getString(context);
              }
              return null;
            },
          ),
          spacer,
          AppDropDown<String>(
            initialValue: nuevoTramiteCubit.tipoVehiculo?.nombre,
            hint: AppLocale.lavelTipoVehiculoNuevoTramite.getString(context),
            items:
                catalogos.tipoVehiculo?.map((e) => e.nombre ?? '').toList() ??
                [],
            onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
              nuevoTramiteCubit.tipoVehiculo = catalogos.tipoVehiculo
                  ?.firstWhere((e) => e.nombre == value);
            }),
            labelBuilder: (item) => item,
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return AppLocale.campoObligatorio.getString(context);
              }
              return null;
            },
          ),
          spacer,
          AppDropDown<Entidad>(
            initialValue: nuevoTramiteCubit.entidad,
            hint: AppLocale.lavelEntidadNuevoTramite.getString(context),
            items: catalogos.entidad?.toList() ?? [],
            onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
              nuevoTramiteCubit.entidad = catalogos.entidad?.firstWhere(
                (e) => e == value,
              );
            }),
            labelBuilder: (item) => item.entidadAbreviatura ?? '',
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return AppLocale.campoObligatorio.getString(context);
              }
              return null;
            },
          ),
          spacer,
          AppDropDown<String>(
            initialValue: nuevoTramiteCubit.tipoServicio?.nombre,
            hint: AppLocale.lavelTipoDeServicioNuevoTramite.getString(context),
            items:
                catalogos.tipoServicio?.map((e) => e.nombre ?? '').toList() ??
                [],
            onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
              nuevoTramiteCubit.tipoServicio = catalogos.tipoServicio
                  ?.firstWhere((e) => e.nombre == value);
            }),
            labelBuilder: (item) => item,
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return AppLocale.campoObligatorio.getString(context);
              }
              return null;
            },
          ),
          Spacer(),
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
