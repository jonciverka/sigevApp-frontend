import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_cubit.dart';
import 'package:sigev/presentation/pages/partner/nuevoTramite/cubit/nuevo_tramite_state.dart';
import 'package:sigev/presentation/widgets/app_loader.dart';

class NuevoTramite extends StatelessWidget {
  const NuevoTramite({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.neutralColorWhite,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => NuevoTramiteCubit(context: context),
            child: BlocBuilder<NuevoTramiteCubit, NuevoTramiteState>(
              builder: (context, state) {
                switch (state) {
                  case NuevoTramiteError():
                    return Container();
                  case NuevoTramiteLoading():
                    return const AppLoader();
                  case NuevoTramiteData():
                    return NuevoTramiteBody();
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

class NuevoTramiteBody extends StatelessWidget {
  const NuevoTramiteBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing16,
        vertical: context.spacing12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
