import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_localization/flutter_localization.dart';
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
  List<DateTime> fechas = [
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  ];
  @override
  void initState() {
    super.initState();
    busquedaController.text = widget.initialValue;
    fechas = [
      Utilities.getDateFromIsoWeek(widget.initialValue),
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    ];
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DatePickerRangeStyles styles = DatePickerRangeStyles(
      selectedDateStyle: context.bodyRegularTextStyle.copyWith(
        color: AppTheme.neutralColorWhite,
      ),
      selectedPeriodLastDecoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(1000),
          bottomEnd: Radius.circular(1000),
        ),
      ),
      selectedPeriodStartDecoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(1000),
          bottomStart: Radius.circular(1000),
        ),
      ),
      selectedPeriodMiddleDecoration: BoxDecoration(
        color: AppTheme.primaryColor,
        shape: BoxShape.rectangle,
      ),
    );
    return Column(
      children: [
        SizedBox(height: context.spacing8),
        Row(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: AppTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: busquedaController,
                  enabled: false,
                  labelText: AppLocale.inputSearchTramite.getString(context),
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
          ],
        ),
        SizedBox(height: context.spacing16),
        WeekPicker(
          datePickerLayoutSettings: DatePickerLayoutSettings(),
          selectedDate: fechas.first,
          onChanged: (value) {
            setState(() {
              fechas.first = value.start;
              fechas.last = value.end;
              busquedaController.text = Utilities().getYearWeek(
                date: fechas.first,
              );
            });
          },
          firstDate: DateTime(2000, 1, 1),
          lastDate: DateTime.now(),
          datePickerStyles: styles,
        ),
        SizedBox(height: context.spacing16),
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
        SizedBox(height: MediaQuery.paddingOf(context).bottom),
      ],
    );
  }
}
