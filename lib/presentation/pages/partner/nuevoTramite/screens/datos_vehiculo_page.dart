import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';
import 'package:sigev/presentation/widgets/app_dropdown.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class DatosVehiculoPage extends StatelessWidget {
  const DatosVehiculoPage({
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
    var catalogos = nuevoTramiteCubit.state.catalogos;
    return Form(
      key: nuevoTramiteCubit.formularioStateVehiculo,
      child: Column(
        children: [
          Text(
            AppLocale.subtituloDatosDelVehiculoNuevoTramite.getString(context),
            style: context.headingMediumTextStyle,
          ),
          SizedBox(height: context.spacing20),
          AppDropDown<String>(
            initialValue: nuevoTramiteCubit.vehiculo?.marca,
            hint: AppLocale.lavelMarcaNuevoTramite.getString(context),
            items:
                catalogos.vehiculos?.map((e) => e.marca ?? '').toList() ?? [],
            onSelectItem: (value) => nuevoTramiteCubit.vehiculo = catalogos
                .vehiculos
                ?.firstWhere((e) => e.marca == value),
            labelBuilder: (item) {
              return item;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocale.campoObligatorio.getString(context);
              }
              return null;
            },
          ),
          SizedBox(height: context.spacing20),
          AppTextFormField(
            keyboardType: TextInputType.text,
            controller: nuevoTramiteCubit.subMarcaController,
            hintText: AppLocale.lavelSubmarcaNuevoTramite.getString(context),
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocale.campoObligatorio.getString(context);
              }
              return null;
            },
            onChanged: (_) {},
          ),
          SizedBox(height: context.spacing20),
          AppDropDown<String>(
            initialValue: nuevoTramiteCubit.tipoModelo?.anio,
            hint: AppLocale.lavelModeloNuevoTramite.getString(context),
            items:
                catalogos.tipoModelo?.map((e) => e.anio ?? '').toList() ?? [],
            onSelectItem: (value) => nuevoTramiteCubit.tipoModelo = catalogos
                .tipoModelo
                ?.firstWhere((e) => e.anio == value),
            labelBuilder: (item) {
              return item;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocale.campoObligatorio.getString(context);
              }
              return null;
            },
          ),
          SizedBox(height: context.spacing20),
          AppDropDown<String>(
            initialValue: nuevoTramiteCubit.color?.color,
            hint: AppLocale.lavelColorNuevoTramite.getString(context),
            items: catalogos.colores?.map((e) => e.color ?? '').toList() ?? [],
            onSelectItem: (value) => nuevoTramiteCubit.color = catalogos.colores
                ?.firstWhere((e) => e.color == value),
            labelBuilder: (item) {
              return item;
            },
            validator: (value) {
              if (value!.isEmpty) {
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
