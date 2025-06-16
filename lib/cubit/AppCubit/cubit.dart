import 'dart:async';

import 'package:EZ_Shop/cubit/AppCubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/SharedPreferences.dart';
import '../../shared/network/dio.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  Icon darkLightIcon = Icon(Icons.dark_mode_outlined,size: 16,);
  ChangeMode() {
    darkLightIcon = !isDark ?Icon(Icons.wb_sunny_outlined,size: 16,)
        : Icon(Icons.dark_mode_outlined,size: 16,);
    isDark = !isDark;
    print('mode is changing!');
    emit(AppChangeModeState());
  }

getToken(){
  Timer(Duration(milliseconds: 1000),(){});
  TOKEN= CacheHelper.getStringData(key: 'token')??'';
    print(TOKEN);
}

}
