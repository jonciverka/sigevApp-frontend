import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/core/utilities/utilities_headers.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_detalle_cubit.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet_pregunta.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';

class AppTramitesDocumentos extends StatefulWidget {
  const AppTramitesDocumentos({super.key, required this.tramite});
  final Tramite tramite;

  @override
  State<AppTramitesDocumentos> createState() => _AppTramitesDocumentosState();
}

class _AppTramitesDocumentosState extends State<AppTramitesDocumentos> {
  @override
  Widget build(BuildContext context) {
    var tramiteDetalleCubit = context.watch<TramiteDetalleCubit>();
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.spacing24),

                ...tramiteDetalleCubit.state.documentacion.map(
                  (documentacion) => InkWell(
                    onTap: () => showAppBottomSheetPregunta(
                      context: context,
                      title: AppLocale.textTituloSubirDocumento.getString(
                        context,
                      ),
                      yes: AppLocale.buttonSubirDocumentoTramites.getString(
                        context,
                      ),
                      onYes: () =>
                          tramiteDetalleCubit.selectFile(documentacion),
                      no: AppLocale.buttonTomarFotoTramites.getString(context),
                      onNo: () => tramiteDetalleCubit.takePhoto(documentacion),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${documentacion.apellido ?? ''} *",
                          style: context.bodyBoldTextStyle,
                        ),
                        SizedBox(height: context.spacing8),
                        Container(
                          margin: EdgeInsets.only(bottom: context.spacing24),
                          height:
                              documentacion.file != null ||
                                  documentacion.haveUrlRecurso
                              ? null
                              : context.spacing120,
                          width: double.infinity,
                          child: DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              strokeWidth: 2,
                              dashPattern: [10, 5],
                              radius: Radius.circular(context.spacing24),
                            ),
                            child: documentacion.file != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      context.spacing24,
                                    ),
                                    child: Image.file(
                                      documentacion.file!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : documentacion.haveUrlRecurso
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      context.spacing24,
                                    ),
                                    child: Image.network(
                                      documentacion.urlRecurso ?? '',
                                      headers: UtilitiesHeaders.getHeader(),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.spacing16,
                                    ),
                                    child: Center(child: Icon(AppIcons.add)),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: context.spacing12),
        AppPrimaryButton(
          label: AppLocale.buttonEnviarDocumentos.getString(context),
          onPressed: tramiteDetalleCubit.haveAllDocuments
              ? () => tramiteDetalleCubit.sendDocumentation()
              : null,
        ),
      ],
    );
  }
}
