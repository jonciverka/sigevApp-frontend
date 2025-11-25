import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/extra.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_dropdown.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class DatosDetalleExtrasPage extends StatelessWidget {
  const DatosDetalleExtrasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing16,
        vertical: context.spacing20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocale.lavelExtrasNuevoTramite.getString(context),
                style: context.headingLargeTextStyle,
              ),
              AppSecondaryIconButton(
                icon: AppIcons.close,
                onPressed: () {
                  if (context.read<NuevoTramiteCubit>().validateExtras()) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          AppTramiteDetalleBody(),
        ],
      ),
    );
  }
}

class AppTramiteDetalleBody extends StatelessWidget {
  const AppTramiteDetalleBody({super.key});
  @override
  Widget build(BuildContext context) {
    var nuevoTramiteCubit = context.watch<NuevoTramiteCubit>();
    return Form(
      child: Expanded(
        child: Column(
          children: [
            SizedBox(height: context.spacing20),
            AppDropDown<String>(
              hint: AppLocale.lavelExtrasNuevoTramite.getString(context),
              items:
                  nuevoTramiteCubit.state.catalogos.extras
                      ?.map((e) => e.alias ?? '')
                      .toList() ??
                  [],
              onSelectItem: (value) => nuevoTramiteCubit.addExtras(
                nuevoTramiteCubit.state.catalogos.extras?.firstWhere(
                      (e) => e.alias == value,
                    ) ??
                    Extra(),
              ),
              labelBuilder: (item) => item,
              validator: (p0) {
                return null;
              },
            ),
            SizedBox(height: context.spacing20),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: nuevoTramiteCubit.formularioStateExtras,
                  child: Column(
                    children: [
                      ...nuevoTramiteCubit.extras.map((e) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: context.spacing12,
                            left: context.spacing12,
                            right: context.spacing12,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(flex: 2, child: Text(e.alias ?? '')),
                              Expanded(
                                flex: 5,
                                child: AppTextFormField(
                                  initialValue: e.monto?.toString(),
                                  keyboardType: TextInputType.number,
                                  labelText: AppLocale.inputExtras.getString(
                                    context,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocale.campoObligatorio
                                          .getString(context);
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    e.monto = double.tryParse(value);
                                  },
                                ),
                              ),
                              AppSecondaryIconButton(
                                icon: AppIcons.close,
                                onPressed: () =>
                                    nuevoTramiteCubit.removeExtras(e),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AppPrimaryButton(
                    label: AppLocale.textButtonAgregar.getString(context),
                    onPressed: () {
                      if (context.read<NuevoTramiteCubit>().validateExtras()) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}
