import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_cubit.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: AppLocale.inputSearchTramite.getString(context),
      suffixIcon: AppIcons.search,
      onChanged: (p0) {
        context.read<TramitesCubit>().getTramitesBuscados(busqueda: p0);
      },
    );
  }
}
