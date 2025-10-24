// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/presentation/pages/client/menu/cubit/menu_state.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class MenuCubit extends Cubit<MenuState> {
  final BuildContext _context;
  final provider = CotizacionTramiteProvider();
  MenuCubit({required BuildContext context})
    : _context = context,
      super(
        MenuData(index: MenuState.homePageIndex, catalogoEstatusTramite: []),
      ) {
    apiGetMenuCliente();
  }
  Future<void> apiGetMenuCliente() async {
    try {
      emit(MenuLoading());
      final List<Status> estatusMenu = await provider
          .apiGetCatalogoEstatusTramite();
      emit(MenuData(index: state.index, catalogoEstatusTramite: estatusMenu));
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(MenuLoading());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(MenuLoading());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(MenuLoading());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(MenuLoading());
      return;
    }
  }

  void changeIndex({required int index}) {
    emit(
      MenuData(
        index: index,
        catalogoEstatusTramite: state.catalogoEstatusTramite,
      ),
    );
  }
}
