// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigev/presentation/pages/partner/menu/cubit/menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final BuildContext context;
  MenuCubit({required this.context})
    : super(MenuData(index: MenuState.homePageIndex));

  void changeIndex({required int index}) {
    emit(MenuData(index: index));
  }
}
