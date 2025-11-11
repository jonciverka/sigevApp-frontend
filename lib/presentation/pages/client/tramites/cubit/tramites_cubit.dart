// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/presentation/pages/client/tramites/cubit/tramites_state.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class TramitesCubit extends Cubit<TramitesState> {
  final provider = CotizacionTramiteProvider();
  final BuildContext _context;
  TramitesCubit({required BuildContext context})
    : _context = context,
      super(TramitesInitial()) {
    getTramiteCliente();
  }
  Future<void> getTramiteCliente() async {
    try {
      emit(TramitesLoading());
      final List<Tramite> tramites = await provider.apiGetTramitesCliente();
      emit(TramitesData(tramites: tramites, tramitesBuscados: tramites));
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramitesLoading());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(TramitesLoading());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(TramitesLoading());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(TramitesLoading());
      return;
    }
  }

  void getTramitesBuscados({required List<Tramite> busqueda}) {
    emit(
      TramitesData(tramites: state.tramites, tramitesBuscados: state.tramites),
    );
  }
}
