import 'package:EZ_Shop/cubit/CategoryCubit/states.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../models/CategoriesModel.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());

  static CategoryCubit get(context) => BlocProvider.of(context);

  CategoriesModel categoriesModel = CategoriesModel();

  void getCategories() {
  try {
    emit(GetCategoryLoadingState());
    dioHelper
        .getData(
      url: 'api/admin/get_all_categories_with_produts',
    )
        .then((value) {
      if (value != null) {
        categoriesModel = CategoriesModel.fromJson(value);
        Logger().d(value);
        emit(GetCategorySuccessState());
      }else       emit(GetCategoryErrorState());


    }).catchError((error) {
      emit(GetCategoryErrorState());
      Logger().e(error);
    });
  } catch (e){

  }
  }

}
