import 'dart:convert';
import 'dart:typed_data';

import 'package:EZ_Shop/cubit/BannerCubit/states.dart';
import 'package:EZ_Shop/cubit/homeCubit/states.dart';
import 'package:EZ_Shop/models/BannersModel.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class BannerCubit extends Cubit<BannerStates> {

  BannerCubit() : super(BannerInitialState());

  static BannerCubit get(context) => BlocProvider.of(context);

  BannersModel bannersModel = BannersModel();

  void getBanners() {
    emit(GetBannersLoadingState());
    dioHelper.getData( url: 'api/super_admin/get_ads',)
        .then((value) {
      if (value!= null) {
        bannersModel = BannersModel.fromJson(value);
      }
      Logger().d(value);
      emit(GetBannersSuccessState());
    }).catchError((error) {
      emit(GetBannersErrorState());
      Logger().e(error);
    });
  }


  var image;
 getImage(url) async {
    try {
      final response = await dioHelper.getData( url: url);
    //  final String codeUnits =response.value;
    //  final Uint8List unit8List = Uint8List.fromList(codeUnits.codeUnits);
    //  image= unit8List;
      print('----------------------');
      print(response['image'].toString());
      //return unit8List;
    } catch (error) {
      // Propagate network errors
      print(error.toString());
      throw error;
    }

  }


}
