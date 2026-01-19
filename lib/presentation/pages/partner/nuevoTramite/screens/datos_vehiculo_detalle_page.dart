import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/domain/models/catalogo_cotizacion.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_footer.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/widgets/app_row_opcions_radio_button.dart';
import 'package:sigev/presentation/widgets/app_dropdown.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class DatosVehiculoDetallePage extends StatelessWidget {
  const DatosVehiculoDetallePage({
    super.key,
    this.onButtonNextPressed,
    this.onButtonBackPressed,
    this.onButtonCatalogPressed,
    this.onButtonGenerateCodePressed,
  });
  final void Function()? onButtonNextPressed;
  final void Function()? onButtonBackPressed;
  final void Function()? onButtonCatalogPressed;
  final void Function()? onButtonGenerateCodePressed;

  Widget _columnDetalleVehiculo({
    required Widget spacer,
    required BuildContext context,
    required NuevoTramiteCubit nuevoTramiteCubit,
    required CatalogoCotizacion catalogos,
  }) {
    return Column(
      children: [
        AppTextFormField(
          keyboardType: TextInputType.text,
          maxLengthFormatter: 40,
          controller: nuevoTramiteCubit.noSerieController,
          labelText: AppLocale.lavelNoSerieNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        spacer,
        AppTextFormField(
          keyboardType: TextInputType.text,
          maxLengthFormatter: 40,
          controller: nuevoTramiteCubit.noMotorController,
          labelText: AppLocale.lavelNoMotorNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        spacer,
        Row(
          children: [
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.combustible?.nombre,
                hint: AppLocale.lavelCombustibleNuevoTramite.getString(context),
                items:
                    catalogos.combustible
                        ?.map((e) => e.nombre ?? '')
                        .toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.combustible = catalogos.combustible
                      ?.firstWhere((e) => e.nombre == value);
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.puerta?.nombre,
                hint: AppLocale.lavelPuertasNuevoTramite.getString(context),
                items:
                    catalogos.puertas?.map((e) => e.nombre ?? '').toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.puerta = catalogos.puertas?.firstWhere(
                    (e) => e.nombre == value,
                  );
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        spacer,
        Row(
          children: [
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.pasajeros?.nombre,
                hint: AppLocale.lavelPasajerosNuevoTramite.getString(context),
                items:
                    catalogos.pasajeros?.map((e) => e.nombre ?? '').toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.pasajeros = catalogos.pasajeros?.firstWhere(
                    (e) => e.nombre == value,
                  );
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.clase?.nombre,
                hint: AppLocale.lavelClaseNuevoTramite.getString(context),
                items:
                    catalogos.clase?.map((e) => e.nombre ?? '').toList() ?? [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.clase = catalogos.clase?.firstWhere(
                    (e) => e.nombre == value,
                  );
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        spacer,
        Row(
          children: [
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.cilindros?.nombre,
                hint: AppLocale.lavelCilindrosNuevoTramite.getString(context),
                items:
                    catalogos.cilindros?.map((e) => e.nombre ?? '').toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.cilindros = catalogos.cilindros?.firstWhere(
                    (e) => e.nombre == value,
                  );
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.transmision?.nombre,
                hint: AppLocale.lavelTransmicionNuevoTramite.getString(context),
                items:
                    catalogos.transmision
                        ?.map((e) => e.nombre ?? '')
                        .toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.transmision = catalogos.transmision
                      ?.firstWhere((e) => e.nombre == value);
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _columnDetalleVehiculoCarga({
    required Widget spacer,
    required BuildContext context,
    required NuevoTramiteCubit nuevoTramiteCubit,
    required CatalogoCotizacion catalogos,
  }) {
    return Column(
      children: [
        AppTextFormField(
          keyboardType: TextInputType.text,
          maxLengthFormatter: 40,
          controller: nuevoTramiteCubit.noSerieController,
          labelText: AppLocale.lavelNoSerieNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        spacer,
        AppTextFormField(
          keyboardType: TextInputType.text,
          maxLengthFormatter: 40,
          controller: nuevoTramiteCubit.noMotorController,
          labelText: AppLocale.lavelNoMotorNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        spacer,
        Row(
          children: [
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.pasajeros?.nombre,
                hint: AppLocale.lavelPasajerosNuevoTramite.getString(context),
                items:
                    catalogos.pasajeros?.map((e) => e.nombre ?? '').toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.pasajeros = catalogos.pasajeros?.firstWhere(
                    (e) => e.nombre == value,
                  );
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.combustible?.nombre,
                hint: AppLocale.lavelCombustibleNuevoTramite.getString(context),
                items:
                    catalogos.combustible
                        ?.map((e) => e.nombre ?? '')
                        .toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.combustible = catalogos.combustible
                      ?.firstWhere((e) => e.nombre == value);
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        spacer,
        Row(
          children: [
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.cilindros?.nombre,
                hint: AppLocale.lavelCilindrosNuevoTramite.getString(context),
                items:
                    catalogos.cilindros?.map((e) => e.nombre ?? '').toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.cilindros = catalogos.cilindros?.firstWhere(
                    (e) => e.nombre == value,
                  );
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),

            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.puerta?.nombre,
                hint: AppLocale.lavelPuertasNuevoTramite.getString(context),
                items:
                    catalogos.puertas?.map((e) => e.nombre ?? '').toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.puerta = catalogos.puertas?.firstWhere(
                    (e) => e.nombre == value,
                  );
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        spacer,
        Row(
          children: [
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.claseCarga?.nombre,
                hint: AppLocale.lavelClaseNuevoTramite.getString(context),
                items:
                    catalogos.claseCarga?.map((e) => e.nombre ?? '').toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.claseCarga = catalogos.claseCarga
                      ?.firstWhere((e) => e.nombre == value);
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.transporta?.nombre,
                hint: AppLocale.lavelTransportaNuevoTramite.getString(context),
                items:
                    catalogos.transporta?.map((e) => e.nombre ?? '').toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.transporta = catalogos.transporta
                      ?.firstWhere((e) => e.nombre == value);
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),

        spacer,
        AppTextFormField(
          keyboardType: TextInputType.number,
          maxLengthFormatter: 5,

          controller: nuevoTramiteCubit.capacidadCarga,
          labelText: AppLocale.lavelCapacidadCargaNuevoTramite.getString(
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
        spacer,

        spacer,
      ],
    );
  }

  Widget _columnDetalleVehiculoRemol({
    required Widget spacer,
    required BuildContext context,
    required NuevoTramiteCubit nuevoTramiteCubit,
    required CatalogoCotizacion catalogos,
  }) {
    return Column(
      children: [
        AppTextFormField(
          keyboardType: TextInputType.text,
          maxLengthFormatter: 40,
          controller: nuevoTramiteCubit.noSerieController,
          labelText: AppLocale.lavelNoSerieNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        spacer,
        AppTextFormField(
          keyboardType: TextInputType.text,
          maxLengthFormatter: 40,
          controller: nuevoTramiteCubit.noMotorController,
          labelText: AppLocale.lavelNoMotorNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        spacer,
        AppTextFormField(
          keyboardType: TextInputType.number,
          maxLengthFormatter: 5,
          controller: nuevoTramiteCubit.capacidadCarga,
          labelText: AppLocale.lavelCapacidadCargaNuevoTramite.getString(
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
        spacer,
        AppDropDown<String>(
          initialValue: nuevoTramiteCubit.pasajeros?.nombre,
          hint: AppLocale.lavelPasajerosNuevoTramite.getString(context),
          items: catalogos.pasajeros?.map((e) => e.nombre ?? '').toList() ?? [],
          onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
            nuevoTramiteCubit.pasajeros = catalogos.pasajeros?.firstWhere(
              (e) => e.nombre == value,
            );
          }),
          labelBuilder: (item) {
            return item;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
        ),

        spacer,
        Row(
          children: [
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.claseRemol?.nombre,
                hint: AppLocale.lavelClaseNuevoTramite.getString(context),
                items:
                    catalogos.claseRemolque
                        ?.map((e) => e.nombre ?? '')
                        .toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.claseRemol = catalogos.claseRemolque
                      ?.firstWhere((e) => e.nombre == value);
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
            spacer,
            Expanded(
              child: AppDropDown<String>(
                initialValue: nuevoTramiteCubit.transporta?.nombre,
                hint: AppLocale.lavelTransportaNuevoTramite.getString(context),
                items:
                    catalogos.transporta?.map((e) => e.nombre ?? '').toList() ??
                    [],
                onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
                  nuevoTramiteCubit.transporta = catalogos.transporta
                      ?.firstWhere((e) => e.nombre == value);
                }),
                labelBuilder: (item) {
                  return item;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocale.campoObligatorio.getString(context);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        spacer,
      ],
    );
  }

  Widget _columnDetalleVehiculoMoto({
    required Widget spacer,
    required BuildContext context,
    required NuevoTramiteCubit nuevoTramiteCubit,
    required CatalogoCotizacion catalogos,
  }) {
    return Column(
      children: [
        AppTextFormField(
          keyboardType: TextInputType.text,
          maxLengthFormatter: 40,
          controller: nuevoTramiteCubit.noSerieController,
          labelText: AppLocale.lavelNoSerieNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        spacer,
        AppTextFormField(
          keyboardType: TextInputType.text,
          maxLengthFormatter: 40,
          controller: nuevoTramiteCubit.noMotorController,
          labelText: AppLocale.lavelNoMotorNuevoTramite.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        spacer,
        AppDropDown<String>(
          initialValue: nuevoTramiteCubit.claseMoto?.nombre,
          hint: AppLocale.lavelClaseNuevoTramite.getString(context),
          items: catalogos.claseMoto?.map((e) => e.nombre ?? '').toList() ?? [],
          onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
            nuevoTramiteCubit.claseMoto = catalogos.claseMoto?.firstWhere(
              (e) => e.nombre == value,
            );
          }),
          labelBuilder: (item) {
            return item;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
        ),
        spacer,

        AppTextFormField(
          keyboardType: TextInputType.number,
          maxLengthFormatter: 5,
          controller: nuevoTramiteCubit.centimetrosCubicos,
          labelText: AppLocale.lavelCentimetrosCuadrados.getString(context),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
          onChanged: (_) {},
        ),
        spacer,
        AppDropDown<String>(
          initialValue: nuevoTramiteCubit.combustible?.nombre,
          hint: AppLocale.lavelCombustibleNuevoTramite.getString(context),
          items:
              catalogos.combustible?.map((e) => e.nombre ?? '').toList() ?? [],
          onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
            nuevoTramiteCubit.combustible = catalogos.combustible?.firstWhere(
              (e) => e.nombre == value,
            );
          }),
          labelBuilder: (item) {
            return item;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
        ),
        spacer,
        AppDropDown<String>(
          initialValue: nuevoTramiteCubit.cilindros?.nombre,
          hint: AppLocale.lavelCilindrosNuevoTramite.getString(context),
          items: catalogos.cilindros?.map((e) => e.nombre ?? '').toList() ?? [],
          onSelectItem: (value) => nuevoTramiteCubit.onSelectItem(() {
            nuevoTramiteCubit.cilindros = catalogos.cilindros?.firstWhere(
              (e) => e.nombre == value,
            );
          }),
          labelBuilder: (item) {
            return item;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.campoObligatorio.getString(context);
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var nuevoTramiteCubit = context.read<NuevoTramiteCubit>();
    var catalogos = nuevoTramiteCubit.state.catalogos;
    var spacer = SizedBox(height: context.spacing16);
    return Form(
      key: nuevoTramiteCubit.formularioStateVehiculoDetalle,
      child: Column(
        children: [
          Text(
            AppLocale.subtituloDatosDelVehiculoNuevoTramite.getString(context),
            style: context.headingMediumTextStyle,
          ),
          spacer,
          Expanded(
            child: SingleChildScrollView(
              child: switch (nuevoTramiteCubit.tipoVehiculo?.id ?? 0) {
                3 => _columnDetalleVehiculoCarga(
                  spacer: spacer,
                  context: context,
                  nuevoTramiteCubit: nuevoTramiteCubit,
                  catalogos: catalogos,
                ),
                5 => _columnDetalleVehiculoRemol(
                  spacer: spacer,
                  context: context,
                  nuevoTramiteCubit: nuevoTramiteCubit,
                  catalogos: catalogos,
                ),
                2 => _columnDetalleVehiculoMoto(
                  spacer: spacer,
                  context: context,
                  nuevoTramiteCubit: nuevoTramiteCubit,
                  catalogos: catalogos,
                ),
                _ => _columnDetalleVehiculo(
                  spacer: spacer,
                  context: context,
                  nuevoTramiteCubit: nuevoTramiteCubit,
                  catalogos: catalogos,
                ),
              },
            ),
          ),

          AppFooter(
            onButtonBackPressed: onButtonBackPressed,
            onButtonCatalogPressed: onButtonCatalogPressed,
            onButtonGenerateCodePressed: onButtonGenerateCodePressed,
            onButtonNextPressed: onButtonNextPressed,
          ),
        ],
      ),
    );
  }
}
