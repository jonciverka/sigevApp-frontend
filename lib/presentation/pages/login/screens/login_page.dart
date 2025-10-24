import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/assets_constants.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/login/cubit/login_cubit.dart';
import 'package:sigev/presentation/pages/login/cubit/login_state.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => LoginCubit(context: context),
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                switch (state) {
                  case LoginError():
                    return cuerpoWgt(context);
                  case LoginLoading():
                    return const AppLoader();
                  case LoginData():
                    return cuerpoWgt(context);
                  default:
                    return const AppLoader();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget cuerpoWgt(BuildContext context) {
  final loginCubit = context.read<LoginCubit>();
  return Form(
    key: loginCubit.fomularioState,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetsConstants.sigevLogo, height: 150),
          SizedBox(height: context.spacing16),
          AppTextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: loginCubit.usuarioController,
            hintText: AppLocale.inputLoginUsuarioLogin.getString(context),
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocale.campoObligatorio.getString(context);
              }
              return null;
            },
            onChanged: (_) {},
          ),
          SizedBox(height: context.spacing16),
          AppTextFormField(
            controller: loginCubit.passcontroller,
            hintText: AppLocale.inputLoginPasswordLogin.getString(context),
            suffixIcon: context.watch<LoginCubit>().passwordVisible
                ? AppIcons.visibility
                : AppIcons.visibilityOff,
            onIconButtonPressed: () => loginCubit.changePasswordVisibility(),
            obscureText: context.watch<LoginCubit>().passwordVisible,
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocale.campoObligatorio.getString(context);
              }
              return null;
            },
            onSubmitted: (_) => loginCubit.iniciarSesion(),
            onChanged: (_) {},
          ),
          SizedBox(height: context.spacing8),
          Text(
            AppLocale.textoInstruccionLogin.getString(context),
            style: context.bodyRegularTextStyle,
          ),
          SizedBox(height: context.spacing24),
          AppPrimaryButton(
            onPressed: () => loginCubit.iniciarSesion(),
            label: AppLocale.botonIniciarSesionLogin.getString(context),
          ),
          SizedBox(height: context.spacing12),
        ],
      ),
    ),
  );
}
