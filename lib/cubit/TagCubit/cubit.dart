import 'dart:convert';

import 'package:EZ_Shop/cubit/ProductCubit/states.dart';
import 'package:EZ_Shop/cubit/TagCubit/states.dart';
import 'package:EZ_Shop/models/ColorsModel.dart';
import 'package:EZ_Shop/models/SizesModel.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../models/CommentModel.dart';
import '../../models/Product.dart';
import '../../models/TagsModel.dart';
import '../../shared/helperFunctions.dart';

class TagCubit extends Cubit<TagStates> {
  TagCubit() : super(TagInitialState());

  static TagCubit get(context) => BlocProvider.of(context);

TagsModel tagsModel = TagsModel();
  void getTags() {
    try {
      emit(GetTagsLoadingState());
      dioHelper
          .getData(
        url: 'api/product/get_all_tags',
      )
          .then((value) {
        if (value != null) {
          tagsModel = TagsModel.fromJson(value);
          Logger().d(value);
          emit(GetTagsSuccessState());
        }
    else   emit(GetTagsErrorState());
      }).catchError((error) {
        emit(GetTagsErrorState());
        Logger().e(error);
      });
    } catch (e){

    }

  }

  TagsProductModel tagsProductModel = TagsProductModel();
  void getTagProducts(id) {
    try {
      emit(GetTagsProductLoadingState());
      dioHelper
          .getData(
        url: 'api/product/get_tag_products/$id',
      )
          .then((value) {
        if (value != null) {
          if(value['tag_products']!=[])
         { tagsProductModel = TagsProductModel.fromJson(value);
          emit(GetTagsProductSuccessState());}
          else
          emit(GetTagsProductEmptyState());
          Logger().d(value);
        }else
          emit(GetTagsProductEmptyState());
      }).catchError((error) {
        emit(GetTagsProductErrorState());
        Logger().e(error);
      });
    } catch (e){
    }
  }


}
