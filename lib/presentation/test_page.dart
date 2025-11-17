import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/screen_paths.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_check_box.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';
import 'package:sigev/presentation/widgets/app_radio_button.dart';
import 'package:sigev/presentation/widgets/app_tab_view.dart';
import 'package:sigev/presentation/widgets/app_toast_notification.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});
  final usuarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget spacer = SizedBox(height: context.spacing12);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppPrimaryButton(
                  label: "Ir al Log in",
                  onPressed: () {
                    context.go(ScreenPaths.loginRoute);
                  },
                ),
                const Icon(AppIcons.add),
                spacer,
                AppPrimaryButton(label: "Button", onPressed: () {}),
                spacer,
                const AppPrimaryButton(label: "Button"),
                spacer,
                AppSecondaryButton(label: "Button", onPressed: () {}),
                spacer,
                const AppSecondaryButton(label: "Button"),
                spacer,
                AppTertiaryButton(label: "Button", onPressed: () {}),
                spacer,
                const AppTertiaryButton(label: "Button"),
                spacer,
                AppIconButton(icon: AppIcons.add, onPressed: () => {}),
                spacer,
                AppIconButton(
                  icon: AppIcons.add,
                  onPressed: () => {},
                  badgeCount: 1,
                ),
                spacer,
                const AppIconButton(icon: AppIcons.add),
                spacer,
                AppSecondaryIconButton(icon: AppIcons.add, onPressed: () => {}),
                spacer,
                AppSecondaryIconButton(
                  icon: AppIcons.add,
                  onPressed: () => {},
                  badgeCount: 3,
                ),
                spacer,
                const AppSecondaryIconButton(icon: AppIcons.add),

                spacer,
                AppCheckBox(label: "Text", value: false, onChanged: (_) {}),
                AppCheckBox(label: "Text", value: true, onChanged: (_) {}),
                const AppCheckBox(label: "Text", value: false, onChanged: null),
                const AppCheckBox(label: "Text", value: true, onChanged: null),
                spacer,
                AppCheckBox(label: "Text", value: true, onChanged: (_) {}),
                spacer,
                AppCheckBox(label: "Text", value: null, onChanged: (_) {}),
                spacer,
                const AppCheckBox(label: "Text", value: false),
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (_) {},
                  labelText: "Label",
                  controller: usuarioController,
                ),
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (_) {},
                  labelText: "Label",
                  controller: usuarioController,
                ),
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (p0) {},
                  enabled: false,
                  labelText: "Label",
                  controller: usuarioController,
                ),
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (p0) {},
                  enabled: true,
                  labelText: "Label",
                  controller: usuarioController,
                ),
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (p0) {},
                  enabled: true,
                  labelText: "Label",
                  controller: usuarioController,
                ),
                spacer,
                spacer,
                spacer,
                spacer,
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (_) {},
                  labelText: "Label",
                  controller: usuarioController,
                  prefixIcon: AppIcons.add,
                ),
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (_) {},
                  labelText: "Label",
                  controller: usuarioController,
                  prefixIcon: AppIcons.add,
                ),
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (p0) {},
                  enabled: false,
                  labelText: "Label",
                  controller: usuarioController,
                  prefixIcon: AppIcons.add,
                ),
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (p0) {},
                  enabled: true,
                  labelText: "Label",
                  controller: usuarioController,
                  prefixIcon: AppIcons.add,
                ),
                spacer,
                AppTextFormField(
                  validator: (value) => null,
                  onChanged: (p0) {},
                  enabled: true,
                  labelText: "Label",
                  controller: usuarioController,
                  prefixIcon: AppIcons.add,
                ),
                spacer,
                const AppLoader(),
                AppRadioButton<String>(
                  label: "Text",
                  value: "Text",
                  groupValue: "",
                  onChanged: (_) {},
                ),
                AppRadioButton<String>(
                  label: "Text",
                  value: "Text",
                  groupValue: "Text",
                  onChanged: (_) {},
                ),
                const AppRadioButton<String>(
                  label: "Text",
                  value: "Text",
                  groupValue: "",
                  onChanged: null,
                ),
                const AppRadioButton<String>(
                  label: "Text",
                  value: "Text",
                  groupValue: "Text",
                  onChanged: null,
                ),
                spacer,
                AppRadioButton<String>(
                  label: "Text",
                  value: "Text",
                  groupValue: "Text",
                  onChanged: (_) {},
                ),
                spacer,
                const AppRadioButton<String>(
                  label: "Text",
                  value: "Text",
                  groupValue: "",
                ),
                spacer,
                const AppRadioButton<String>(
                  label: "Text",
                  value: "Text",
                  groupValue: "Text",
                ),
                spacer,
                Container(
                  height: 400,
                  color: AppTheme.neutralColorBg,
                  width: double.infinity,
                  child: AppTabView(
                    tabsNames: const ["verde", "rojo", "azul"],
                    children: [
                      Container(color: Colors.green, height: 50, width: 50),
                      Container(color: Colors.red, height: 50, width: 50),
                      Container(color: Colors.blue, height: 50, width: 50),
                    ],
                    onChangeTab: (index) {},
                  ),
                ),
                spacer,
                const AppToastNotification(
                  type: ToastType.success,
                  message: "Text",
                ),
                spacer,
                const AppToastNotification(
                  type: ToastType.error,
                  message: "Text",
                ),
                spacer,
                const AppToastNotification(
                  type: ToastType.warning,
                  message: "Text",
                ),
                spacer,
                const AppToastNotification(
                  type: ToastType.info,
                  message: "Text",
                ),
                spacer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
