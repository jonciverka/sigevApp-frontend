// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/presentation/pages/login/cubit/seguimiento_state.dart';
import 'package:sigev/presentation/pages/login/screens/tramite_detalle_page.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class SeguimientoCubit extends Cubit<SeguimientoState> {
  final provider = CotizacionTramiteProvider();
  final BuildContext _context;
  final codigoTramiteController = TextEditingController();
  final anioVehiculoController = TextEditingController();
  GlobalKey<FormState> fomularioState = GlobalKey<FormState>();

  SeguimientoCubit({required BuildContext context})
    : _context = context,
      super(SeguimientoInitial());

  Future<void> apiGetSeguimiento() async {
    if (fomularioState.currentState!.validate() == false) return;
    try {
      emit(SeguimientoLoading());
      Tramite tramite = await provider.apiGetSeguimiento(
        anio: anioVehiculoController.text,
        code: codigoTramiteController.text,
      );
      showTramiteModalDialog(context: _context, tramite: tramite);
      emit(SeguimientoData(tramite: tramite));
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(SeguimientoInitial());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(SeguimientoInitial());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(SeguimientoInitial());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.errorRecursoNoEncontrado.getString(_context),
        type: ToastType.error,
      );
      emit(SeguimientoInitial());
      return;
    }
  }

  Future<T?> showTramiteModalDialog<T extends Object?>({
    required BuildContext context,
    required Tramite tramite,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: false,
        useRootNavigator: true,
        builder: (context) {
          return FractionallySizedBox(
            // heightFactor: 1,
            child: TramiteDetallePage(tramite: tramite),
          );
        },
      ).then((value) async {
        if (value == null) return null;
        if (value == false) return null;
        return null;
      });
}
