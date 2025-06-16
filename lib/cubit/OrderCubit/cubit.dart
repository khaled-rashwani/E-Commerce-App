import 'package:EZ_Shop/cubit/CartCubit/states.dart';
import 'package:EZ_Shop/cubit/OrderCubit/states.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../models/CartModel.dart';
import '../../models/OrderModel.dart';
import '../../models/OrdersModel.dart';
import '../../shared/helperFunctions.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialState());

  static OrderCubit get(context) => BlocProvider.of(context);


  OrdersModel ordersModel = OrdersModel();
  void getOrders() {
    try {
      emit(GetOrdersLoadingState());
      dioHelper
          .getData(
        url: 'api/user/get_user_orders',
      )
          .then((value) {
        if (value != null) {
         ordersModel = OrdersModel.fromJson(value);
          Logger().d(value);
          emit(GetOrdersSuccessState());
        } else {
          emit(GetOrdersErrorState());
        }
      }).catchError((error) {
        emit(GetOrdersErrorState());
        Logger().e(error);
      });
    } catch (e) {}
  }
  CheckedItems checkedItems = CheckedItems();
  void check() {
    try {
      emit(CheckLoadingState());
      dioHelper
          .getData(
        url: 'api/user/check_items',
      )
          .then((value) {
        if (value != null) {
          checkedItems = CheckedItems.fromJson(value);
          if (value['status'] == 1) {
            emit(CheckSuccessState());
          } else {
            emit(CheckNotAvailableState());
          }
          Logger().d(value);
        } else {
          emit(CheckErrorState());
        }
      }).catchError((error) {
        emit(CheckErrorState());

        Logger().e(error);
      });
    } catch (e) {}
  }
  void completeOrder()  {
    print('ccc');
    try {
      emit(ConfirmOrderLoadingState());
      dioHelper
          .getData(
        url: 'api/user/confirm_order',
      )
          .then((value) {
        if (value != null) {
          toast(value['message']);
          emit(ConfirmOrderSuccessState());
          Logger().d(value);
        } else {
          emit(ConfirmOrderErrorState());
        }
      }).catchError((error) {
         emit(ConfirmOrderErrorState());
        Logger().e(error);
      });
    } catch (e) {}
  }
}
