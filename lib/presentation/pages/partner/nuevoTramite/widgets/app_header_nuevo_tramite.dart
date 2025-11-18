import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';

class AppHeaderNuevoTramite extends StatelessWidget {
  const AppHeaderNuevoTramite({super.key});
  @override
  Widget build(BuildContext context) {
    var nuevoTramiteCubit = context.read<NuevoTramiteCubit>();
    final cubit = context.watch<NuevoTramiteCubit>();
    final nombre = cubit.nombreController.text.trim();
    final apellido = cubit.apellidoController.text.trim();
    final nombreCompleto = "$nombre $apellido";
    final tipoTramite = nuevoTramiteCubit.tipoTramite?.nombre ?? '';
    final entidad = nuevoTramiteCubit.entidad?.entidadNombre ?? '';
    final hasNombreCompleto = nombre.isNotEmpty && apellido.isNotEmpty;
    final hasTipoTramite = tipoTramite.isNotEmpty;
    final hasEntidad = entidad.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.start,
          AppLocale.textTituloNuevoTramiteNuevoTramite.getString(context),
          style: context.headingLargeTextStyle.copyWith(
            color: AppTheme.primaryColorHover,
          ),
        ),
        if (hasNombreCompleto) SizedBox(height: context.spacing8),
        if (hasNombreCompleto)
          Text(nombreCompleto, style: context.bodyRegularTextStyle),
        if (hasTipoTramite || hasEntidad) SizedBox(height: context.spacing8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (hasTipoTramite)
              Text(tipoTramite, style: context.bodyRegularTextStyle),
            if (hasEntidad) Text(entidad, style: context.bodyRegularTextStyle),
          ],
        ),
      ],
    );
  }
}
