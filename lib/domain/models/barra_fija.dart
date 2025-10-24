import 'dart:convert';

BarraFija barraFijaFromJson(String str) =>
    BarraFija.fromJson(json.decode(str)["data"]);

class BarraFija {
  BarraFija({
    this.ingresos,
    this.ingresosSemana,
    this.entregas,
    this.cancelados,
    this.facturaAnual,
    this.facturaMensual,
    this.facturaSemanal,
    this.grafico,
    this.link,
  });

  Ingresos? ingresos;
  Ingresos? ingresosSemana;
  Ingresos? entregas;
  Ingresos? cancelados;
  int? facturaAnual;
  int? facturaMensual;
  int? facturaSemanal;
  Grafico? grafico;
  String? link;

  factory BarraFija.fromJson(Map<String, dynamic> json) => BarraFija(
    ingresos: Ingresos.fromJson(json["ingresos"]),
    ingresosSemana: Ingresos.fromJson(json["ingresos_semana"]),
    entregas: Ingresos.fromJson(json["entregas"]),
    cancelados: Ingresos.fromJson(json["cancelados"]),
    facturaAnual: json["facturaAnual"],
    facturaMensual: json["facturaMensual"],
    facturaSemanal: json["facturaSemanal"],
    grafico: Grafico.fromJson(
      json["grafico"]["labels"],
      json["grafico"]["values"],
    ),
    link: json["link"],
  );
}

class Ingresos {
  Ingresos({this.dia, this.semanaPasada, this.porcentaje});

  String? dia;
  String? semanaPasada;
  int? porcentaje;

  factory Ingresos.fromJson(Map<String, dynamic> json) => Ingresos(
    dia: json["hoy"] ?? json["actual"],
    semanaPasada: json["hoy_semana_pasada"] ?? json["semana_pasada"],
    porcentaje: json["porcentaje"],
  );
}

class Grafico {
  Grafico({this.labels, this.values});

  List? labels;
  List? values;

  factory Grafico.fromJson(List labels, List values) =>
      Grafico(labels: labels, values: values);
}
