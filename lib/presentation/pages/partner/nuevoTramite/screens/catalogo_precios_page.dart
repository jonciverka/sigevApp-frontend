import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/assets_constants.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/catalogo.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_search_bar.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_cubit.dart';
import 'package:sigev/presentation/widgets/app_card.dart';

class CatalogoPreciosPage extends StatelessWidget {
  const CatalogoPreciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    var menuCubit = context.watch<MenuCubit>();
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: context.spacing8),
          AppSearchBar(
            items: menuCubit.catalogos,
            onSearch: (value) =>
                menuCubit.searchCatalogoPrecio(busqueda: value),
            searchPredicate: (item, query) {
              return (item.entidad ?? '').toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  (item.tramiteAlias ?? '').toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  (item.tipoVehiculo ?? '').toLowerCase().contains(
                    query.toLowerCase(),
                  );
            },
          ),
          SizedBox(height: context.spacing24),
          Expanded(
            child: Stack(
              children: [
                Image.asset(AssetsConstants.flechaLoco),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.spacing2),
                    child: Column(
                      children: menuCubit.state.catalogoPrecios
                          .map((e) => AppCardCatalogo(catalogo: e))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppCardCatalogo extends StatelessWidget {
  const AppCardCatalogo({super.key, required this.catalogo});
  final Catalogo catalogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spacing16),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${AppLocale.textoUltimaActualizacion.getString(context)} : ${catalogo.actualizacion ?? ''}",
              style: context.bodyBoldTextStyle,
            ),
            SizedBox(height: context.spacing8),
            RowCatalogo(
              title: AppLocale.textValorEntidadCatalogoPrecios.getString(
                context,
              ),
              valor: catalogo.entidad ?? '',
              isFirst: true,
            ),
            RowCatalogo(
              title: AppLocale.textValorTramitePrecios.getString(context),
              valor: catalogo.tramiteAlias ?? '',
            ),
            RowCatalogo(
              title: AppLocale.textValorVehiculoPrecios.getString(context),
              valor: catalogo.tipoVehiculo ?? '',
            ),
            RowCatalogo(
              title: AppLocale.textValorEntregaPrecios.getString(context),
              valor: catalogo.tiempoEntrega ?? '',
            ),
            RowCatalogo(
              title: AppLocale.textValorNotasPrecios.getString(context),
              valor: catalogo.notas ?? '',
              isLast: true,
            ),
            SizedBox(height: context.spacing8),
            RowCatalogoTipos(
              cl: catalogo.cl ?? '',
              vip: catalogo.vip ?? '',
              xp: catalogo.xp ?? '',
            ),
          ],
        ),
      ),
    );
  }
}

class RowCatalogo extends StatelessWidget {
  const RowCatalogo({
    super.key,
    required this.title,
    required this.valor,
    this.isFirst = false,
    this.isLast = false,
  });
  final String title;
  final String valor;
  final bool isFirst;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.spacing120,
          padding: EdgeInsets.all(context.spacing8),
          decoration: BoxDecoration(
            borderRadius: isFirst
                ? BorderRadius.only(topLeft: Radius.circular(context.spacing8))
                : isLast
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(context.spacing8),
                  )
                : null,
            border: Border.all(color: AppTheme.neutralColorLightGrey, width: 1),
          ),
          child: Text(title, style: context.bodyRegularTextStyle),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(context.spacing8),
            decoration: BoxDecoration(
              borderRadius: isFirst
                  ? BorderRadius.only(
                      topRight: Radius.circular(context.spacing8),
                    )
                  : isLast
                  ? BorderRadius.only(
                      bottomRight: Radius.circular(context.spacing8),
                    )
                  : null,
              border: Border.all(
                color: AppTheme.neutralColorLightGrey,
                width: 1,
              ),
            ),
            child: Text(valor, style: context.bodyBoldTextStyle),
          ),
        ),
      ],
    );
  }
}

class RowCatalogoTipos extends StatelessWidget {
  const RowCatalogoTipos({
    super.key,
    required this.cl,
    required this.vip,
    required this.xp,
  });
  final String cl;
  final String vip;
  final String xp;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(context.spacing8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.spacing8),
                  ),
                  border: Border.all(
                    color: AppTheme.neutralColorLightGrey,
                    width: 1,
                  ),
                ),
                child: Text(
                  AppLocale.textValorCLPrecios.getString(context),
                  style: context.bodyBoldTextStyle,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(context.spacing8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.neutralColorLightGrey,
                    width: 1,
                  ),
                ),
                child: Text(
                  AppLocale.textValorVIPPrecios.getString(context),
                  style: context.bodyBoldTextStyle,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(context.spacing8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(context.spacing8),
                  ),
                  border: Border.all(
                    color: AppTheme.neutralColorLightGrey,
                    width: 1,
                  ),
                ),
                child: Text(
                  AppLocale.textValorXPPrecios.getString(context),
                  style: context.bodyBoldTextStyle,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(context.spacing8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(context.spacing8),
                  ),
                  border: Border.all(
                    color: AppTheme.neutralColorLightGrey,
                    width: 1,
                  ),
                ),
                child: Text(cl, style: context.bodyBoldTextStyle),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(context.spacing8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.neutralColorLightGrey,
                    width: 1,
                  ),
                ),
                child: Text(vip, style: context.bodyBoldTextStyle),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(context.spacing8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(context.spacing8),
                  ),
                  border: Border.all(
                    color: AppTheme.neutralColorLightGrey,
                    width: 1,
                  ),
                ),
                child: Text(xp, style: context.bodyBoldTextStyle),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
