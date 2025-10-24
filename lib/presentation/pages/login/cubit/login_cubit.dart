// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/screen_paths.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/providers/authentication_provider.dart';
import 'package:sigev/domain/providers/user_provider.dart';
import 'package:sigev/presentation/pages/login/cubit/login_state.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';
import 'package:sigev/config/globals.dart' as globals;

class LoginCubit extends Cubit<LoginState> {
  final BuildContext _context;
  final usuarioController = TextEditingController();
  final passcontroller = TextEditingController();
  bool passwordVisible = true;
  GlobalKey<FormState> fomularioState = GlobalKey<FormState>();
  AuthenticationProvider authenticationProvider = AuthenticationProvider();
  UserProvider userProvider = UserProvider();

  LoginCubit({required BuildContext context})
    : _context = context,
      super(LoginData());

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    emit(LoginData());
  }

  Future<void> iniciarSesion() async {
    if (!fomularioState.currentState!.validate()) {
      return;
    }
    emit(LoginLoading());
    try {
      await authenticationProvider.login(
        login: usuarioController.text,
        password: passcontroller.text,
      );
      await userProvider.getUser();
      if (globals.user?.roleId == null) {
        _context.go(ScreenPaths.menuClientRoute);
      } else if (globals.user?.id != null) {}
      emit(LoginData());
      await Future.delayed(const Duration(milliseconds: 10));
    } on ServerErrorException {
      showToastNotification(
        context: _context,
        message: AppLocale.error.getString(_context),
        type: ToastType.error,
      );
      emit(LoginData());
      return;
    } on NetworkException {
      showToastNotification(
        context: _context,
        message: AppLocale.avisoSinInternet.getString(_context),
        type: ToastType.error,
      );
      emit(LoginData());
      return;
    } on ApiClientException catch (e) {
      showToastNotification(
        context: _context,
        message: e.message,
        type: ToastType.error,
      );
      emit(LoginData());
      return;
    } catch (e) {
      showToastNotification(
        context: _context,
        message: AppLocale.errorInicioSesion.getString(_context),
        type: ToastType.error,
      );

      emit(LoginData());
      return;
    }
  }

  // void setPushNotificationToken(String token) async {
  //   try {
  //     await authenticationProvider.sendPushNotificationToken(token: token);
  //   } catch (e) {
  //     emit(LoginError());
  //   }
  // }
}
