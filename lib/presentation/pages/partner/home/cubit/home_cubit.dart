// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/barra_fija.dart';
import 'package:sigev/domain/providers/user_provider.dart';
import 'package:sigev/presentation/pages/partner/home/cubit/home_state.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class HomeCubit extends Cubit<HomeState> {
  final provider = UserProvider();
  final BuildContext _context;
  HomeCubit({required BuildContext context})
    : _context = context,
      super(HomeInitial()) {
    obtenerBarraFija();
  }
  Future<void> obtenerBarraFija() async {
    try {
      emit(HomeLoading());
      BarraFija barraFija = await provider.getBarraFija();
      emit(HomeData(barraFija: barraFija));
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(HomeLoading());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(HomeLoading());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(HomeLoading());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(HomeLoading());
      return;
    }
  }
}
