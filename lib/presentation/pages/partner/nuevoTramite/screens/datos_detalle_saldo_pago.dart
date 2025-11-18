import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class DatosDetalleSaldoPago extends StatelessWidget {
  const DatosDetalleSaldoPago({
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
    var spacer = SizedBox(height: context.spacing16);
    return Form(
      key: nuevoTramiteCubit.formularioStateDetalleDePagoSaldo,
      child: Column(
        children: [
          Text(
            AppLocale.subtituloDetalleDePagoNuevoTramite.getString(context),
            style: context.headingMediumTextStyle,
          ),
          spacer,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppTextFormField(
                    keyboardType: TextInputType.number,
                    controller: nuevoTramiteCubit.aCuentaController,
                    labelText: AppLocale.lavelACuentaNuevoTramite.getString(
                      context,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocale.campoObligatorio.getString(context);
                      }
                      if ((nuevoTramiteCubit.state.catalogos
                                  .valorSiNombreCoincide(
                                    nuevoTramiteCubit.tipoTramite?.alias ?? '',
                                  ) ??
                              0) >=
                          (double.tryParse(value) ?? 0)) {
                        return AppLocale.errorNoCumpleConElMontoMinimoAnticipo
                            .getString(context);
                      }
                      return null;
                    },
                    onChanged: (p0) => nuevoTramiteCubit.setSaldo(),
                  ),
                  spacer,
                  AppTextFormField(
                    keyboardType: TextInputType.number,
                    controller: nuevoTramiteCubit.saldoController,
                    labelText: AppLocale.lavelSaldoNuevoTramite.getString(
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
                  spacer,
                  AppTextFormField(
                    maxLines: 8,
                    maxLengthFormatter: 1000,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: nuevoTramiteCubit.notasController,
                    labelText: AppLocale.lavelNotasNuevoTramite.getString(
                      context,
                    ),
                    validator: (value) {
                      return null;
                    },
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.spacing12),
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
