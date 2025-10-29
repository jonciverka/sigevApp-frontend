import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class DatosContribuyentePage extends StatelessWidget {
  const DatosContribuyentePage({
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
      key: nuevoTramiteCubit.formularioStateDatosContribuyente,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocale.subtituloDatosContribuyenteNuevoTramite.getString(
              context,
            ),
            style: context.headingLargeTextStyle,
          ),
          SizedBox(height: context.spacing20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: nuevoTramiteCubit.correoElectronicoController,
                    hintText: AppLocale.lavelCorreoElectronicoNuevoTramite
                        .getString(context),
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
                    keyboardType: TextInputType.text,
                    controller: nuevoTramiteCubit.nombreController,
                    hintText: AppLocale.lavelNombreNuevoTramite.getString(
                      context,
                    ),
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
                    keyboardType: TextInputType.text,
                    controller: nuevoTramiteCubit.apellidoController,
                    hintText: AppLocale.lavelApellidosNuevoTramite.getString(
                      context,
                    ),
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
                    maxLengthFormatter: 10,
                    controller: nuevoTramiteCubit.telefonoController,
                    hintText: AppLocale.lavelTelefonoMovilNuevoTramite
                        .getString(context),
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
                    controller: nuevoTramiteCubit.telefonoAlternoController,
                    hintText: AppLocale.lavelTelefonoMovilAlternoNuevoTramite
                        .getString(context),
                    validator: (value) {
                      return null;
                    },
                    onChanged: (_) {},
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
