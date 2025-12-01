import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/documentacion.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';

class DatosDocumentos extends StatelessWidget {
  const DatosDocumentos({
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
    return Column(
      children: [
        Text(
          AppLocale.subtituloDocumentosNuevoTramite.getString(context),
          style: context.headingMediumTextStyle,
        ),
        SizedBox(height: context.spacing8),
        Text(
          AppLocale.textoInstruccionDocumentos.getString(context),
          style: context.bodyBoldTextStyle,
          textAlign: TextAlign.justify,
        ),
        spacer,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children:
                  nuevoTramiteCubit.state.catalogos.documentaciones
                      ?.map(
                        (e) => AppCardDocumentacion(
                          documentacion: e,
                          isSelected: nuevoTramiteCubit.haveDocumentacion(
                            documentacion: e,
                          ),
                          addDocumentacion: () => nuevoTramiteCubit
                              .addDocumentacion(documentacion: e),
                          removeDocumentacion: () => nuevoTramiteCubit
                              .removeDocumentacion(documentacion: e),
                        ),
                      )
                      .toList() ??
                  [],
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
    );
  }
}

class AppCardDocumentacion extends StatelessWidget {
  const AppCardDocumentacion({
    super.key,
    required this.documentacion,
    required this.isSelected,
    required this.addDocumentacion,
    required this.removeDocumentacion,
  });

  final Documentacion documentacion;
  final bool isSelected;
  final Function() addDocumentacion;
  final Function() removeDocumentacion;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red,
      onTap: () {
        if (isSelected) {
          removeDocumentacion();
        } else {
          addDocumentacion();
        }
      },
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (value) {
              if (!(value ?? false)) {
                removeDocumentacion();
              } else {
                addDocumentacion();
              }
            },
          ),
          Text(documentacion.nombre ?? '', style: context.bodyRegularTextStyle),
        ],
      ),
    );
  }
}
