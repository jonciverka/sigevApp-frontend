import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/core/utilities/utilities.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class TramiteBusqueda extends StatefulWidget {
  const TramiteBusqueda({super.key, required this.initialValue});
  final String initialValue;

  @override
  State<TramiteBusqueda> createState() => _TramiteBusquedaState();
}

class _TramiteBusquedaState extends State<TramiteBusqueda> {
  final TextEditingController busquedaController = TextEditingController();
  @override
  void initState() {
    super.initState();
    busquedaController.text = widget.initialValue;
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.spacing16),
        Row(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: AppTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: busquedaController,
                  suffixIcon: AppIcons.refresh,
                  onIconButtonPressed: () =>
                      busquedaController.text = Utilities().getYearWeek(),
                  hintText: AppLocale.inputSearchTramite.getString(context),
                  validator: (value) {
                    final regex = RegExp(
                      r'^\d{4}-W(0[1-9]|[1-4][0-9]|5[0-3])$',
                    );
                    if (value!.isEmpty) {
                      return AppLocale.campoObligatorio.getString(context);
                    }
                    if (!regex.hasMatch(value)) {
                      return AppLocale.errorFormaBusquedaString.getString(
                        context,
                      );
                    }
                    return null;
                  },
                  onChanged: (_) {},
                ),
              ),
            ),
            // AppSecondaryIconButton(
            //   icon: AppIcons.refresh,
            //   onPressed: () {
            //     busquedaController.text = Utilities().getYearWeek();
            //   },
            // ),
          ],
        ),
        SizedBox(height: context.spacing24),
        AppPrimaryButton(
          label: "${AppLocale.textRadioAplica.getString(context)}r",
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            Navigator.pop(context, busquedaController.text);
          },
        ),
        SizedBox(height: context.spacing16),
        AppSecondaryButton(
          label: AppLocale.textButtonCancelar.getString(context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
