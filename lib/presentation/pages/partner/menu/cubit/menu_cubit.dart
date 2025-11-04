// ignore_for_file: use_buildcontext_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/catalogo.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/domain/providers/cotizacion_tramite_provider.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_state.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class MenuCubit extends Cubit<MenuState> {
  final BuildContext context;
  final provider = CotizacionTramiteProvider();
  List<Catalogo> catalogos = [];
  MenuCubit({required this.context})
    : super(
        MenuData(
          index: MenuState.homePageIndex,
          catalogoPrecios: [],
          catalogoEstatusTramite: [],
        ),
      ) {
    obtenerCatalogos();
  }

  Future<void> obtenerCatalogos() async {
    try {
      emit(MenuLoading());
      catalogos = await provider.apiGetCatalogo();
      final List<Status> estatusMenu = await provider
          .apiGetCatalogoEstatusTramite();
      emit(
        MenuData(
          catalogoPrecios: catalogos,
          index: state.index,
          catalogoEstatusTramite: estatusMenu,
        ),
      );
    } on ServerErrorException {
      if (context.mounted) {
        showToastNotification(
          context: context,
          message: AppLocale.error.getString(context),
          type: ToastType.error,
        );
      }
      emit(MenuLoading());
      return;
    } on NetworkException {
      if (context.mounted) {
        showToastNotification(
          context: context,
          message: AppLocale.avisoSinInternet.getString(context),
          type: ToastType.error,
        );
      }
      emit(MenuLoading());
      return;
    } on ApiClientException catch (e) {
      if (context.mounted) {
        showToastNotification(
          context: context,
          message: e.message,
          type: ToastType.error,
        );
      }
      emit(MenuLoading());
      return;
    } catch (e) {
      if (context.mounted) {
        showToastNotification(
          context: context,
          message: AppLocale.error.getString(context),
          type: ToastType.error,
        );
      }
      emit(MenuLoading());
      return;
    }
  }

  void changeIndex({required int index}) {
    emit(
      MenuData(
        index: index,
        catalogoPrecios: state.catalogoPrecios,
        catalogoEstatusTramite: state.catalogoEstatusTramite,
      ),
    );
  }

  void searchCatalogoPrecio({required List<Catalogo> busqueda}) {
    emit(
      MenuData(
        index: state.index,
        catalogoPrecios: busqueda,
        catalogoEstatusTramite: state.catalogoEstatusTramite,
      ),
    );
  }
}
