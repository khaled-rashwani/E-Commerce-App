import 'package:EZ_Shop/cubit/FavoriteCubit/states.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../models/FavoriteModel.dart';
import '../../shared/helperFunctions.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  FavoriteModel favoriteModel = FavoriteModel();

  void getFavorite() {
    try {
      emit(GetFavoriteLoadingState());
      dioHelper
          .getData(
        url: 'api/user/get_all_favorites',
      )
          .then((value) {
        if (value != null) {
          favoriteModel = FavoriteModel.fromJson(value);
          Logger().d(value);
          emit(GetFavoriteSuccessState());
        }else{
          emit(GetFavoriteErrorState());

        }

      }).catchError((error) {
        emit(GetFavoriteErrorState());
        Logger().e(error);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  removeFromFavorite(Id) {
    emit(GetIsProductFavoriteState());
    dioHelper
        .deleteData(
      url: 'api/user/remove_from_favorites/$Id',
    )
        .then((value) {
      // print(value.data.toString());
      if (value.statusCode == 200) {
        if (value.data["status"] == 1) {
          toast(value.data["message"]);
          getFavorite();
        } else {
          toast(value.data["message"]);
        }
      }
    }).catchError((error) {
      print(error.toString());
      toast('Something went wrong!Please try again later');
    });
  }

  addToFavorite(id) {
    dioHelper
        .postData(
      url: 'api/user/add_to_favorites/$id',
    )
        .then((value) {
      // print(value.data.toString());
      if (value.statusCode == 200) {
        if (value.data["status"] == 1) {
          //toast(value.data["message"]);
          toast('The Product Added Successfully!');
        } else {
          toast(value.data["message"]);
        }
      }
    }).catchError((error) {
      print(error.toString());
      toast('Something went wrong!Please try again later');
    });
  }

  bool isProductFavorite(id) {
    bool _isTheSame = false;
    favoriteModel.data?.forEach((wishListItems) {
      if (wishListItems.id == id) {
        _isTheSame = true;
      }
    });
    emit(GetIsProductFavoriteState());
    return _isTheSame;
  }
}
