import 'dart:convert';

import 'package:sigev/domain/models/anticipo.dart';
import 'package:sigev/domain/models/area.dart';
import 'package:sigev/domain/models/cilindros.dart';
import 'package:sigev/domain/models/clase.dart';
import 'package:sigev/domain/models/color.dart';
import 'package:sigev/domain/models/combustible.dart';
import 'package:sigev/domain/models/documentacion.dart';
import 'package:sigev/domain/models/entidad.dart';
import 'package:sigev/domain/models/extra.dart';
import 'package:sigev/domain/models/pasajeros.dart';
import 'package:sigev/domain/models/puerta.dart';
import 'package:sigev/domain/models/socio.dart';
import 'package:sigev/domain/models/sucursal.dart';
import 'package:sigev/domain/models/terminacion_placa.dart';
import 'package:sigev/domain/models/tipo_desecho.dart';
import 'package:sigev/domain/models/tipo_modelo.dart';
import 'package:sigev/domain/models/tipo_servicio.dart';
import 'package:sigev/domain/models/tipo_tramite.dart';
import 'package:sigev/domain/models/tipo_vehiculos.dart';
import 'package:sigev/domain/models/transmision.dart';
import 'package:sigev/domain/models/transporta.dart';
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
    this.tipoDesecho,
    this.terminacionPlaca,
    this.anticipos,
    this.documentaciones,
    this.combustible,
    this.puertas,
    this.pasajeros,
    this.clase,
    this.cilindros,
    this.transmision,
    this.claseCarga,
    this.transporta,
    this.claseMoto,
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
  List<TipoDesecho>? tipoDesecho;
  List<TerminacionPlaca>? terminacionPlaca;
  List<Anticipo>? anticipos;
  List<Documentacion>? documentaciones;
  List<Combustible>? combustible;
  List<Puerta>? puertas;
  List<Pasajeros>? pasajeros;
  List<Clase>? clase;
  List<Cilindros>? cilindros;
  List<Transmision>? transmision;
  List<Clase>? claseCarga;
  List<Transporta>? transporta;
  List<Clase>? claseMoto;

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
      tipoDesecho: tipoDesechosFromJsonList(json["catTipodesecho"]),
      terminacionPlaca: terminacionPlacasFromJsonList(
        json["catTerminacionPlaca"],
      ),
      anticipos: anticiposFromJsonList(json["anticipos"]),
      documentaciones: documentacionsFromJsonList(json["catDocumentos"]),
      combustible: combustiblesFromJsonList(json["catCombustible"]),
      puertas: puertasFromJsonList(json["catPuertas"]),
      pasajeros: pasajerosFromJsonList(json["catPasajeros"]),
      clase: clasesFromJsonList(json["catClase"]),
      cilindros: cilindrossFromJsonList(json["catCilindros"]),
      transmision: transmisionsFromJsonList(json["catTransmision"]),
      claseCarga: clasesFromJsonList(json["catClaseCarga"]),
      transporta: transportasFromJsonList(json["catTransporta"]),
      claseMoto: clasesFromJsonList(json["catClaseMoto"]),
    );
  }
  int? valorSiNombreCoincide(String nombreBuscado) {
    return anticipos?.firstWhere((e) => e.nombre == nombreBuscado).valor;
  }
}
