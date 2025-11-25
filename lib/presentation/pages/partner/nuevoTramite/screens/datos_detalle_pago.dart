import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/screens/datos_detalle_extras_page.dart';
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

  Future<T?> showExtrasModalDialog<T extends Object?>({
    required BuildContext context,
  }) {
    final nuevoTramiteCubit = context.read<NuevoTramiteCubit>();

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 1,
          child: BlocProvider.value(
            value: nuevoTramiteCubit,
            child: const DatosDetalleExtrasPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var nuevoTramiteCubit = context.read<NuevoTramiteCubit>();
    var spacer = SizedBox(height: context.spacing16);
    return Form(
      key: nuevoTramiteCubit.formularioStateDetalleDePago,
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
                    controller: nuevoTramiteCubit.subtotalController,
                    labelText: AppLocale.lavelSubtotalNuevoTramite.getString(
                      context,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocale.campoObligatorio.getString(context);
                      }
                      return null;
                    },
                    onChanged: (p0) => nuevoTramiteCubit.setTotal(),
                  ),
                  spacer,
                  AppTextFormField(
                    keyboardType: TextInputType.number,
                    controller: nuevoTramiteCubit.extrasController,
                    labelText: AppLocale.lavelExtrasNuevoTramite.getString(
                      context,
                    ),
                    validator: (value) {
                      return null;
                    },
                    readOnly: true,
                    onTap: () => showExtrasModalDialog(context: context),
                    onChanged: (p0) => nuevoTramiteCubit.setTotal(),
                  ),
                  spacer,
                  AppTextFormField(
                    keyboardType: TextInputType.number,
                    controller: nuevoTramiteCubit.descuentoController,
                    labelText: AppLocale.lavelDescuentoNuevoTramite.getString(
                      context,
                    ),
                    validator: (value) {
                      return null;
                    },
                    onChanged: (p0) => nuevoTramiteCubit.setTotal(),
                  ),

                  spacer,
                  AppTextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    controller: nuevoTramiteCubit.totalController,
                    labelText: AppLocale.lavelTotalNuevoTramite.getString(
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
