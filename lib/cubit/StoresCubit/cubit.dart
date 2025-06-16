import 'package:EZ_Shop/cubit/StoresCubit/states.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../models/CategoriesModel.dart';
import '../../models/StoresCategoriesModel.dart';
import '../../models/StoresModel.dart';


class StoreCubit extends Cubit<StoreStates> {
  StoreCubit() : super(StoreInitialState());

  static StoreCubit get(context) => BlocProvider.of(context);

  StoresModel storesModel = StoresModel();

  void getStores() {
  try {
    emit(GetStoreLoadingState());
    dioHelper
        .getData(
      url: 'api/admin/get',
    )
        .then((value) {
      if (value != null) {
        storesModel = StoresModel.fromJson(value);
      }
      Logger().d(value);
      emit(GetStoreSuccessState());
    }).catchError((error) {
      emit(GetStoreErrorState());
      Logger().e(error);
    });
  } catch (e){

  }

  }

  StoreCategoriesModel storeCategoriesModel = StoreCategoriesModel();
  void getStoreCategories(id) {
    try {
      emit(GetCategoryLoadingState());
      dioHelper
          .getData(
        url: 'api/admin/get_category_productForAdmin/$id',
      )
          .then((value) {
        if (value != null && value['status']==1) {
          storeCategoriesModel = StoreCategoriesModel.fromJson(value);
          emit(GetCategorySuccessState());
          Logger().d(value);
        }else
        emit(GetCategoryEmptyState());
      }).catchError((error) {
        emit(GetCategoryErrorState());
        Logger().e(error);
      });
    } catch (e){
    }
  }

}
