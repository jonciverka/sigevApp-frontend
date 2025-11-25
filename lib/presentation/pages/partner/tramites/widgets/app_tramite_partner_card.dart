import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/domain/models/tramite.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/pages/partner/tramites/screens/tramite_detalle_page.dart';

class AppTramitePartnerCard extends StatelessWidget {
  const AppTramitePartnerCard({super.key, required this.tramite});
  final Tramite tramite;

  Future<T?> showTramiteModalDialog<T extends Object?>({
    required BuildContext context,
    required MenuCubit menuCubit,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: false,
        useRootNavigator: true,
        builder: (context) {
          return BlocProvider.value(
            value: menuCubit,
            child: FractionallySizedBox(
              heightFactor: 1,
              child: TramiteDetallePage(tramite: tramite),
            ),
          );
        },
      ).then((value) async {
        return null;
      });

  @override
  Widget build(BuildContext context) {
    final menuCubit = context.read<MenuCubit>();
    return GestureDetector(
      onTap: () =>
          showTramiteModalDialog(context: context, menuCubit: menuCubit),
      child: Container(
        margin: EdgeInsets.only(bottom: context.spacing12),
        width: double.infinity,
        padding: EdgeInsets.only(
          top: context.spacing12,
          bottom: context.spacing12,
          left: context.spacing16,
          right: context.spacing2,
        ),
        decoration: BoxDecoration(
          boxShadow: AppTheme.smallElevationShadow,
          color: AppTheme.neutralColorWhite,
          borderRadius: BorderRadius.circular(context.spacing12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tramite.clave ?? '', style: context.bodyBoldTextStyle),
                  SizedBox(height: context.spacing12),
                  Text(
                    tramite.fechaCreacion ?? '',
                    style: context.bodyRegularTextStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tramite.nombre ?? '', style: context.bodyBoldTextStyle),
                  SizedBox(height: context.spacing12),
                  Text(
                    tramite.tituloCarta,
                    style: context.bodyRegularTextStyle,
                  ),
                ],
              ),
            ),
            Icon(AppIcons.arrowForward),
          ],
        ),
      ),
    );
  }
}
