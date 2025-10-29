import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';
import 'package:sigev/presentation/widgets/app_dropdown.dart';

class DatosContribuyenteSucursalPage extends StatelessWidget {
  const DatosContribuyenteSucursalPage({
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
    return Form(
      key: nuevoTramiteCubit.formularioStateContribuyente,
      child: Column(
        children: [
          Text(
            AppLocale.subtituloDatosContribuyenteNuevoTramite.getString(
              context,
            ),
            style: context.headingLargeTextStyle,
          ),
          SizedBox(height: context.spacing20),
          AppDropDown<String>(
            hint: AppLocale.lavelSucursalNuevoTramite.getString(context),
            items:
                nuevoTramiteCubit.state.catalogos.sucursal
                    ?.map((e) => e.nombre ?? '')
                    .toList() ??
                [],
            onSelectItem: (value) =>
                nuevoTramiteCubit.sucursal = nuevoTramiteCubit
                    .state
                    .catalogos
                    .sucursal
                    ?.firstWhere((e) => e.nombre == value),
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
