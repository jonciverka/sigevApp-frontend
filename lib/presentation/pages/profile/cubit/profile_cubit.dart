// ignore_for_file: use_buildcontext_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:sigev/config/errors/exceptions.dart';
import 'package:sigev/core/constant/screen_paths.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/core/utilities/utilities.dart';
import 'package:sigev/domain/providers/user_provider.dart';
import 'package:sigev/presentation/pages/profile/cubit/profile_state.dart';
import 'package:sigev/config/globals.dart' as globals;
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final nombreController = TextEditingController();
  final correoElectronicoController = TextEditingController();
  final numeroDeTelefonoCelularController = TextEditingController();
  GlobalKey<FormState> fomularioState = GlobalKey<FormState>();
  final userProvider = UserProvider();
  final BuildContext context;

  ProfileCubit({required this.context}) : super(ProfileData()) {
    nombreController.text = globals.user?.name ?? 'N/A';
    correoElectronicoController.text = globals.user?.email ?? 'N/A';
    numeroDeTelefonoCelularController.text = globals.user?.phone ?? 'N/A';
  }

  Future<void> logout() async {
    emit(ProfileLoading());
    await Utilities().clearCache();
    if (!context.mounted) return;
    context.go(ScreenPaths.loginRoute);
  }

  Future<void> deleteUser() async {
    try {
      emit(ProfileLoading());
      await userProvider.apiDeleteUser();
      await Utilities().clearCache();
      if (!context.mounted) return;
      context.go(ScreenPaths.loginRoute);
    } on ServerErrorException {
      if (!context.mounted) return;
      showToastNotification(
        context: context,
        message: AppLocale.error.getString(context),
        type: ToastType.error,
      );
      emit(ProfileData());
      return;
    } on NetworkException {
      if (!context.mounted) return;
      showToastNotification(
        context: context,
        message: AppLocale.avisoSinInternet.getString(context),
        type: ToastType.error,
      );
      emit(ProfileData());
      return;
    } on ApiClientException catch (e) {
      if (!context.mounted) return;
      showToastNotification(
        context: context,
        message: e.message,
        type: ToastType.error,
      );
      emit(ProfileData());
      return;
    } catch (e) {
      if (!context.mounted) return;
      showToastNotification(
        context: context,
        message: AppLocale.error.getString(context),
        type: ToastType.error,
      );
      emit(ProfileData());
      return;
    }
  }
}
