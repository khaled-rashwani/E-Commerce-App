import 'package:EZ_Shop/cubit/CartCubit/states.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../Shared/SharedPreferences.dart';
import '../../models/CartModel.dart';
import '../../shared/helperFunctions.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);

   CartModel cartModel = CartModel();

  void getCart() {
    try {
      emit(GetCartLoadingState());
      dioHelper
          .getData(
        url: 'api/user/get_cart_items',
      )
          .then((value) {
        if (value != null) {
            cartModel = CartModel.fromJson(value);
            Logger().d(value);
            emit(GetCartSuccessState());
        }else{
          print('***********');
          print(TOKEN);
          emit(GetCartErrorState());
        }

      }).catchError((error) {
        emit(GetCartErrorState());
        Logger().e(error);
      });
    } catch (e) {}
  }


  removeFromCart(variantId) {
    dioHelper.deleteData(
      url: 'api/user/remove_from_cart/$variantId',
    ).then((value) {
      // print(value.data.toString());
      if (value.statusCode == 200) {
        if (value.data["status"] == 1) {
          toast(value.data["message"]);
          getCart();
        } else {
          toast(value.data["message"]);
        }
      }
    }).catchError((error) {
      print(error.toString());
      toast('Something went wrong!Please try again later');
    });
  }

  increaseQuantity(variantId) {
    dioHelper.postData(
      url: 'api/user/increase_quantity/$variantId',
    ).then((value) {
      // print(value.data.toString());
      if (value.statusCode == 200) {
        if (value.data["status"] == 1) {
          toast(value.data["message"]);
          getCart();
        } else {
          toast(value.data["message"]);
        }
      }
    }).catchError((error) {
      print(error.toString());
      toast('Something went wrong!Please try again later');
    });
  }
  decreaseQuantity(variantId) {
    dioHelper.postData(
      url: 'api/user/decrease_quantity/$variantId',
    ).then((value) {
      // print(value.data.toString());
      if (value.statusCode == 200) {
        if (value.data["status"] == 1) {
          toast(value.data["message"]);
          getCart();
        } else {
          toast(value.data["message"]);
        }
      }
    }).catchError((error) {
      print(error.toString());
      toast('Something went wrong!Please try again later');
    });
  }

}
