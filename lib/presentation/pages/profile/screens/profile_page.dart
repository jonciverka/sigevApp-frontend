import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:sigev/presentation/pages/profile/cubit/profile_state.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet_pregunta.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_fondo_curvo.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: BlocProvider(
          create: (context) => ProfileCubit(context: context),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              switch (state) {
                case ProfileError():
                  return cuerpoWgt(context);
                case ProfileLoading():
                  return const AppLoader();
                case ProfileData():
                  return cuerpoWgt(context);
                default:
                  return const AppLoader();
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget cuerpoWgt(BuildContext context) {
  final profileCubit = context.read<ProfileCubit>();
  return AppFondoCurvo(
    paddingBottom: 0,
    paddingTop: context.spacing16,
    child: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.neutralColorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.spacing24),
            topRight: Radius.circular(context.spacing24),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing8,
          vertical: context.spacing24,
        ),
        child: Form(
          key: profileCubit.fomularioState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocale.textTituloPerfil.getString(context),
                  style: context.headingLargeTextStyle,
                ),
              ),
              SizedBox(height: context.spacing8),
              Center(
                child: Text(
                  profileCubit.nombreController.text,
                  style: context.bodyRegularTextStyle,
                ),
              ),
              Spacer(),
              AppTextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: profileCubit.nombreController,
                labelText: AppLocale.inputNombreCompletoPerfil.getString(
                  context,
                ),
                enabled: false,
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
                keyboardType: TextInputType.emailAddress,
                controller: profileCubit.correoElectronicoController,
                enabled: false,
                labelText: AppLocale.inputCorreoElectronicoPerfil.getString(
                  context,
                ),
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
                keyboardType: TextInputType.emailAddress,
                controller: profileCubit.numeroDeTelefonoCelularController,
                enabled: false,
                labelText: AppLocale.inputTelefonoCelularPerfil.getString(
                  context,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
              SizedBox(height: context.spacing16),
              AppTertiaryButton(
                width: double.nan,
                label: AppLocale.textAvisoPrivacidadPerfil.getString(context),
                onPressed: () => showAppBottomSheet(
                  heightFactor: 0,
                  useRootNavigator: true,
                  context: context,
                  title: AppLocale.inputSearch.getString(context),
                  child: ClausulasPage(),
                ),
                suffixIcon: AppIcons.openInNew,
              ),
              SizedBox(height: context.spacing16),
              AppTertiaryButton(
                width: double.nan,
                label: AppLocale.textButtonEliminarCuentaPerfil.getString(
                  context,
                ),
                onPressed: () => showAppBottomSheetPregunta(
                  context: context,
                  title: AppLocale.textTituloEliminarCuenta.getString(context),
                  question: AppLocale.textPreguntaEliminarCuenta.getString(
                    context,
                  ),
                  yes: AppLocale.textoRespuestaSiEliminarCuenta.getString(
                    context,
                  ),
                  onYes: () => profileCubit.deleteUser(),
                ),
                suffixIcon: AppIcons.delete,
              ),
              SizedBox(height: context.spacing16),
              AppTertiaryButton(
                width: double.nan,
                label: AppLocale.textButtonCerrarSesionPerfil.getString(
                  context,
                ),
                onPressed: () => showAppBottomSheetPregunta(
                  context: context,
                  title: AppLocale.textTituloCerrarSesion.getString(context),
                  question: AppLocale.textPreguntaCerrarSesion.getString(
                    context,
                  ),
                  yes: AppLocale.textoRespuestaSiCerrarSesion.getString(
                    context,
                  ),
                  onYes: () => profileCubit.logout(),
                ),
                suffixIcon: AppIcons.logout,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    ),
  );
}

class ClausulasPage extends StatefulWidget {
  const ClausulasPage({super.key});

  @override
  ClausulasPageState createState() => ClausulasPageState();
}

class ClausulasPageState extends State<ClausulasPage> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://grupogevhe.com/clausulas/"));

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: 100,
        width: double.infinity,
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
