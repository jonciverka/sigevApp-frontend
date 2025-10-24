// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_state.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class NuevoTramiteCubit extends Cubit<NuevoTramiteState> {
  final provider = CotizacionTramiteProvider();
  final BuildContext _context;
  NuevoTramiteCubit({required BuildContext context})
    : _context = context,
      super(NuevoTramiteInitial()) {
    obtenerCatalogos();
  }
  Future<void> obtenerCatalogos() async {
    try {
      emit(NuevoTramiteLoading());
      CatalogoCotizacion barraFija = await provider.getCatalogos();
      emit(NuevoTramiteData(barraFija: barraFija));
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(NuevoTramiteLoading());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(NuevoTramiteLoading());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(NuevoTramiteLoading());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(NuevoTramiteLoading());
      return;
    }
  }
}
