import 'dart:convert';

import 'package:sigev/domain/models/area.dart';
import 'package:sigev/domain/models/color.dart';
import 'package:sigev/domain/models/entidad.dart';
import 'package:sigev/domain/models/extra.dart';
import 'package:sigev/domain/models/socio.dart';
import 'package:sigev/domain/models/sucursal.dart';
import 'package:sigev/domain/models/tipo_modelo.dart';
import 'package:sigev/domain/models/tipo_servicio.dart';
import 'package:sigev/domain/models/tipo_tramite.dart';
import 'package:sigev/domain/models/tipo_vehiculos.dart';
import 'package:sigev/domain/models/vehiculo.dart';

CatalogoCotizacion catalogoCotizacionFromJson(String str) =>
    CatalogoCotizacion.fromJson(json.decode(str)["data"]);

class CatalogoCotizacion {
  CatalogoCotizacion({
    this.tiposTramite,
    this.vehiculos,
    this.entidad,
    this.sucursal,
    this.tipoModelo,
    this.socios,
    this.extras,
    this.tipoServicio,
    this.tipoVehiculo,
    this.colores,
    this.areas,
  });

  List<TipoTramite>? tiposTramite;
  List<Vehiculo>? vehiculos;
  List<Entidad>? entidad;
  List<Sucursal>? sucursal;
  List<TipoModelo>? tipoModelo;
  List<Socio>? socios;
  List<Extra>? extras;
  List<TipoServicio>? tipoServicio;
  List<TipoVehiculo>? tipoVehiculo;
  List<ColorVehiculo>? colores;
  List<Area>? areas;

  factory CatalogoCotizacion.fromJson(Map<String, dynamic> json) {
    return CatalogoCotizacion(
      tiposTramite: tipoTramitesFromJsonList(json["catTramite"]),
      vehiculos: vehiculosFromJsonList(json["catVehiculo"]),
      entidad: entidadsFromJsonList(json["catEntidad"]),
      sucursal: sucursalsFromJsonList(json["catSucursal"]),
      tipoModelo: tipoModelosFromJsonList(json["catModelo"]),
      socios: sociosFromJsonList(json["catSocio"]),
      extras: extrasFromJsonList(json["catExtra"]),
      tipoServicio: tipoServiciosFromJsonList(json["catTiposervicio"]),
      tipoVehiculo: tipoVehiculosFromJsonList(json["catTipovehiculo"]),
      colores: colorsFromJsonList(json["catColor"]),
      areas: areasFromJsonList(json["catArea"]),
    );
  }
}
