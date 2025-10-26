import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class DatosDetallePago extends StatelessWidget {
  const DatosDetallePago({
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
          AppLocale.subtituloDetalleDePagoNuevoTramite.getString(context),
          style: context.headingLargeTextStyle,
        ),
        SizedBox(height: context.spacing20),

        AppTextFormField(
          keyboardType: TextInputType.number,
          controller: nuevoTramiteCubit.subtotalController,
          hintText: AppLocale.lavelSubtotalNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        SizedBox(height: context.spacing20),
        AppTextFormField(
          keyboardType: TextInputType.number,
          controller: nuevoTramiteCubit.extrasController,
          hintText: AppLocale.lavelExtrasNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        SizedBox(height: context.spacing20),
        AppTextFormField(
          keyboardType: TextInputType.number,
          controller: nuevoTramiteCubit.descuentoController,
          hintText: AppLocale.lavelDescuentoNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        SizedBox(height: context.spacing20),
        AppTextFormField(
          keyboardType: TextInputType.number,
          controller: nuevoTramiteCubit.totalController,
          hintText: AppLocale.lavelTotalNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        SizedBox(height: context.spacing20),
        AppTextFormField(
          keyboardType: TextInputType.number,
          controller: nuevoTramiteCubit.aCuentaController,
          hintText: AppLocale.lavelACuentaNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
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
