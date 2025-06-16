import 'package:EZ_Shop/cubit/SearchCubit/states.dart';
import 'package:EZ_Shop/models/SearchModel.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';


class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel = SearchModel();
  void getSearch(text) {
    try {
      emit(GetSearchLoadingState());
      dioHelper
          .postData(
        url: 'api/product/search_all_products',
        data: {
          'serched_product': text,
        },
      )
          .then((value) {
        if (value != null) {
          searchModel = SearchModel.fromJson(value.data);
          emit(GetSearchSuccessState());
        }
        Logger().d(value.data);
      }).catchError((error) {
        emit(GetSearchErrorState());
        Logger().e(error);
      });
    } catch (e) {}
  }






}
