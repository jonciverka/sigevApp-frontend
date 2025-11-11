// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:pdfx/pdfx.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/core/utilities/utilities.dart';
import 'package:sigev/domain/models/documentacion.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_detalle_state.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class TramiteDetalleCubit extends Cubit<TramiteDetalleState> {
  final provider = CotizacionTramiteProvider();
  final BuildContext _context;
  get haveAllDocuments => state.documentacion.every((e) => e.file != null);

  TramiteDetalleCubit({required BuildContext context, required Tramite tramite})
    : _context = context,
      super(
        TramiteDetalleData(
          tramite: tramite,
          documentacion:
              tramite.documentaciones?.map((e) => e.copyWith()).toList() ?? [],
        ),
      );
  Future<void> selectFile(Documentacion documentacion) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true, // 🔹 importante para usar result.files.single.bytes
    );
    String extensionFile = result?.files.single.extension ?? '';
    if (result != null) {
      Uint8List? image;
      if (extensionFile == 'pdf') {
        final document = await PdfDocument.openData(result.files.single.bytes!);
        final page = await document.getPage(1);
        final pageImage = await page.render(
          width: page.width,
          height: page.height,
          format: PdfPageImageFormat.png, // Puedes usar también jpeg
        );
        image = pageImage?.bytes ?? Uint8List(0);
        await document.close();
      } else if (extensionFile.toLowerCase() == 'jpg' ||
          extensionFile.toLowerCase() == 'jpeg' ||
          extensionFile.toLowerCase() == 'png') {
        image = result.files.single.bytes!;
      }

      documentacion.file = await Utilities().uint8ListToFile(
        image!,
        "${documentacion.id}.${documentacion.nombre}_${DateTime.now()}.$extensionFile",
      );

      documentacion.formato = extensionFile;

      emit(
        TramiteDetalleData(
          documentacion: state.documentacion,
          tramite: state.tramite,
        ),
      );
    } else {
      // User canceled the picker
    }
  }

  Future<void> sendDocumentation() async {
    try {
      emit(
        TramiteDetalleLoading(
          documentacion: state.documentacion,
          tramite: state.tramite,
        ),
      );
      await provider.uploadImage(
        documentaciones: state.tramite.documentaciones ?? [],
        documentacionesAMandar: state.documentacion,
      );
      emit(
        TramiteDetalleData(
          documentacion: state.documentacion,
          tramite: state.tramite,
        ),
      );
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(
        TramiteDetalleData(
          documentacion: state.documentacion,
          tramite: state.tramite,
        ),
      );
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(
        TramiteDetalleData(
          documentacion: state.documentacion,
          tramite: state.tramite,
        ),
      );
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(
        TramiteDetalleData(
          documentacion: state.documentacion,
          tramite: state.tramite,
        ),
      );
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(
        TramiteDetalleData(
          documentacion: state.documentacion,
          tramite: state.tramite,
        ),
      );
      return;
    }
  }
}
