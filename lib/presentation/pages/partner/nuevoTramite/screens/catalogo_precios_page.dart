import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/catalogo.dart';

class CatalogoPreciosPage extends StatelessWidget {
  const CatalogoPreciosPage({super.key, required this.catalogoPrecios});
  final List<Catalogo> catalogoPrecios;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: catalogoPrecios
          .map((e) => AppCardCatalogo(catalogo: e))
          .toList()
          .sublist(4),
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
      child: Column(
        children: [
          Text(
            "${AppLocale.textoUltimaActualizacion.getString(context)} ${catalogo.actualizacion ?? ''}",
            style: context.bodyBoldTextStyle,
          ),
          RowCatalogo(
            title: AppLocale.textValorEntidadCatalogoPrecios.getString(context),
            valor: catalogo.entidad ?? '',
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
          ),
          SizedBox(height: context.spacing8),
          RowCatalogoTipos(
            cl: catalogo.cl ?? '',
            vip: catalogo.vip ?? '',
            xp: catalogo.xp ?? '',
          ),
        ],
      ),
    );
  }
}

class RowCatalogo extends StatelessWidget {
  const RowCatalogo({super.key, required this.title, required this.valor});
  final String title;
  final String valor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.spacing120,
          padding: EdgeInsets.all(context.spacing8),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.neutralColorGrey400, width: 1),
          ),
          child: Text(title, style: context.bodyRegularTextStyle),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(context.spacing8),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.neutralColorGrey400, width: 1),
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
                  border: Border.all(
                    color: AppTheme.neutralColorGrey400,
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
                    color: AppTheme.neutralColorGrey400,
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
                  border: Border.all(
                    color: AppTheme.neutralColorGrey400,
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
                  border: Border.all(
                    color: AppTheme.neutralColorGrey400,
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
                    color: AppTheme.neutralColorGrey400,
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
                  border: Border.all(
                    color: AppTheme.neutralColorGrey400,
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
