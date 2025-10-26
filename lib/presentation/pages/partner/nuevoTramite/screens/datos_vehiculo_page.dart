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
    return Column(
      children: [
        Text(
          AppLocale.subtituloDatosDelVehiculoNuevoTramite.getString(context),
          style: context.headingLargeTextStyle,
        ),
        AppDropDown<String>(
          hint: AppLocale.lavelMarcaNuevoTramite.getString(context),
          items:
              nuevoTramiteCubit.state.catalogos.vehiculos
                  ?.map((e) => e.marca ?? '')
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
          hint: AppLocale.lavelMarcaNuevoTramite.getString(context),
          items:
              nuevoTramiteCubit.state.catalogos.tipoModelo
                  ?.map((e) => e.anio ?? '')
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
          hint: AppLocale.lavelColorNuevoTramite.getString(context),
          items:
              nuevoTramiteCubit.state.catalogos.colores
                  ?.map((e) => e.color ?? '')
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
