import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
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
    var nuevoTramiteCubit = context.read<NuevoTramiteCubit>();
    return Column(
      children: [
        Text(
          AppLocale.subtituloDatosDelTramiteNuevoTramite.getString(context),
          style: context.headingLargeTextStyle,
        ),
        AppDropDown<String>(
          hint: AppLocale.lavelTipoDeTramiteNuevoTramite.getString(context),
          items:
              nuevoTramiteCubit.state.catalogos.tiposTramite
                  ?.map((e) => e.nombre ?? '')
                  .toList() ??
              [],
          onSelectItem: (value) => print(value),
          labelBuilder: (item) {
            return item;
          },
          validator: (p0) {
            return null;
          },
        ),
        SizedBox(height: context.spacing20),
        AppDropDown<String>(
          hint: AppLocale.lavelTipoVehiculoNuevoTramite.getString(context),
          items:
              nuevoTramiteCubit.state.catalogos.tipoVehiculo
                  ?.map((e) => e.nombre ?? '')
                  .toList() ??
              [],
          onSelectItem: (value) => print(value),
          labelBuilder: (item) {
            return item;
          },
          validator: (p0) {
            return null;
          },
        ),
        SizedBox(height: context.spacing20),
        AppDropDown<String>(
          hint: AppLocale.lavelEntidadNuevoTramite.getString(context),
          items:
              nuevoTramiteCubit.state.catalogos.entidad
                  ?.map((e) => e.entidadNombre ?? '')
                  .toList() ??
              [],
          onSelectItem: (value) => print(value),
          labelBuilder: (item) {
            return item;
          },
          validator: (p0) {
            return null;
          },
        ),
        SizedBox(height: context.spacing20),
        AppDropDown<String>(
          hint: AppLocale.lavelTipoDeServicioNuevoTramite.getString(context),
          items:
              nuevoTramiteCubit.state.catalogos.tipoServicio
                  ?.map((e) => e.nombre ?? '')
                  .toList() ??
              [],
          onSelectItem: (value) => print(value),
          labelBuilder: (item) {
            return item;
          },
          validator: (p0) {
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
    );
  }
}
