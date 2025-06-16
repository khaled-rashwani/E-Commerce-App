import 'package:EZ_Shop/cubit/homeCubit/states.dart';
import 'package:EZ_Shop/models/BannersModel.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../models/SearchModel.dart';
import '../../shared/helperFunctions.dart';
import '../../ui/User/Home/Favorite.dart';
import '../../ui/User/Home/HomeBody.dart';
import '../../ui/User/Home/Profile.dart';
import '../../ui/User/Home/Stores.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  //to navigate between BottomNavigationBar items
  int CurrentIndex = 0;
  List<Widget> Screens = [HomeBody(), Stores(), Favorite(), Profile()];
  List<String> Titles = ['Home ', 'Stores', 'Favorite', 'Profile'];

  void ChangeIndex(int index) {
    CurrentIndex = index;
    emit(HomeChangeBottomNavBarState());
  }

  // bool isDark = false;
  // Icon darkLightIcon = Icon(Icons.visibility_off_outlined);
  //
  // ChangeMode() {
  //   darkLightIcon = isDark ?Icon(Icons.visibility_off_outlined)
  //       : Icon(Icons.visibility);
  //   isDark = !isDark;
  //   print('mode is changing!');
  //   emit(HomeChangeModeState());
  // }

  dynamic addToFavorite(id) {
    emit(HomeAddToFavoriteLoadingsState());
    //  api/add_to_favorites
    dioHelper.postData(url: 'api/add_to_favorites/$id', data: {}).then((value) {
      print(value.data.toString());
      if (value.data['status'] == 1) toast('Added Successfully');
      if (value.data['status'] == 0) toast('You Already Have it before');
      emit(HomeAddToFavoriteSuccessState());
      print(
          'heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeey from add to favorite');
      // print(searchModel.data!.experts!.length.toString());
    }).catchError((error) {
      emit(HomeAddToFavoriteErrorState());
      print(error.toString());
    });
  }

  dynamic rate(id,num) {
    dioHelper.postData(url: 'api/user/add_rate/$id', data: {
      'rate' : num
    }).then((value) {
      if (value.data['status']==1)
        toast('The Product Rated Successfully!');
      print(value.data.toString());
    }).catchError((error) {
      print(error.toString());
    });
  }

  SearchModel searchModel = SearchModel();

  void getSearch(text) {
    try {
      emit(GetBestLoadingState());
      dioHelper
          .getData(
        url: 'api/product/get_highest_sellcount',
      )
          .then((value) {
        if (value != null) {
          if(value['data']!=[]){
            searchModel = SearchModel.fromJson(value);
            Logger().d(value);
            emit(GetBestSuccessState());}
        } else
          emit(GetBestErrorState());
      }).catchError((error) {
        emit(GetBestErrorState());
        Logger().e(error);
      });
    } catch (e) {}
  }


  SearchModel searchModel2 = SearchModel();

  void getNew() {
    try {
      emit(GetNewLoadingState());
      dioHelper
          .getData(
        url: 'api/product/get_latest_products',
      )
          .then((value) {
        if (value != null) {
          if(value['data']!=[]){
          searchModel2 = SearchModel.fromJson(value);
          Logger().d(value);
          emit(GetNewSuccessState());}
        } else
          emit(GetNewErrorState());
      }).catchError((error) {
        emit(GetNewErrorState());
        Logger().e(error);
      });
    } catch (e) {}
  }

}
