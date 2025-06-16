import 'dart:convert';

import 'package:EZ_Shop/cubit/ProductCubit/states.dart';
import 'package:EZ_Shop/models/ColorsModel.dart';
import 'package:EZ_Shop/models/SizesModel.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../models/CommentModel.dart';
import '../../models/Product.dart';
import '../../shared/helperFunctions.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);

  ProductModel productModel = ProductModel();
  CommentsModel commentsModel = CommentsModel();
  var rating = 0;
  // void getProduct(id) {
  //   bool getRate=false, getComments=false, getProfile=false;
  //   try {
  //     dioHelper
  //         .getData(
  //       url: 'api/user/show_rate/$id',
  //     )
  //         .then((value) {
  //       if (value != null) {
  //         rating = value['rate'];
  //         print(rating);
  //         getRate = true;
  //         print('*********************************');
  //         print(getRate);
  //       }
  //       Logger().d(value);
  //     }).catchError((error) {
  //       Logger().e(error);
  //     });
  //   } catch (e) {}
  //   try {
  //     dioHelper
  //         .getData(
  //       url: 'api/user/get_product_comments/$id',
  //     )
  //         .then((value) {
  //       if (value != null) {
  //         //  productModel = ProductModel.fromJson(value);
  //         //convertVariantToMap();
  //         commentModel = CommentModel.fromJson(value);
  //         getComments = true;
  //       }
  //       Logger().d(value);
  //     }).catchError((error) {
  //       Logger().e(error);
  //     });
  //   } catch (e) {}
  //   try {
  //     emit(GetProductLoadingState());
  //     dioHelper
  //         .getData(
  //       url: 'api/product/product_profile/$id',
  //     )
  //         .then((value) {
  //       if (value != null) {
  //         productModel = ProductModel.fromJson(value);
  //         convertVariantToMap();
  //         getProfile = true;
  //       }
  //       Logger().d(value);
  //       // emit(GetProductSuccessState());
  //     }).catchError((error) {
  //       emit(GetProductErrorState());
  //       Logger().e(error);
  //     });
  //   } catch (e) {}
  //   print(getComments);
  //   print(getProfile);
  //   print(getRate);
  //   if (getProfile && getComments && getRate) emit(GetProductSuccessState());
  // }
  void getProduct(id) {
    bool getRate = false, getComments = false, getProfile = false;
    try {
      emit(GetProductLoadingState());
      final rateDataFuture = dioHelper.getData(
        url: 'api/user/show_rate/$id',
      );
      final commentsDataFuture = dioHelper.getData(
        url: 'api/user/get_product_comments/$id',
      );
      final productDataFuture = dioHelper.getData(
        url: 'api/product/product_profile/$id',
      );
      Future.wait([
        rateDataFuture,
        commentsDataFuture,
        productDataFuture,
      ]).then((responses) {
        final rateData = responses[0];
        final commentsData = responses[1];
        final productData = responses[2];
        if (rateData != null) {
          rating = rateData['rate'];
          getRate = true;
        }
        if (commentsData != null) {
          print(commentsData);
          commentsModel = CommentsModel.fromJson(commentsData);
          getComments = true;
        }
        if (productData != null) {
          productModel = ProductModel.fromJson(productData);
          convertVariantToMap();
          getProfile = true;
        }

        if (getRate && getComments && getProfile) {
          emit(GetProductSuccessState());
        } else {
          emit(GetProductErrorState());
        }
      }).catchError((error) {
        emit(GetProductErrorState());
        Logger().e(error);
      });
    } catch (e) {
      emit(GetProductErrorState());
      Logger().e(e);
    }
  }

  ColorsModel colorsModel = ColorsModel();

  void getColors() async {
    try {
      emit(GetColorsLoadingState());
      dioHelper
          .getData(
        url: 'api/product/get_colors',
      )
          .then((value) {
        if (value != null) {
          colorsModel = ColorsModel.fromJson(value);
        }
        Logger().d(value);
        //  emit(GetColorsSuccessState());
      }).catchError((error) {
        emit(GetColorsErrorState());
        Logger().e(error);
      });
    } catch (e) {}
  }

  SizesModel sizesModel = SizesModel();

  void getSizes() async {
    try {
      emit(GetSizesLoadingState());
      dioHelper
          .getData(
        url: 'api/product/get_type_sizes/1',
      )
          .then((value) {
        if (value != null) {
          sizesModel = SizesModel.fromJson(value);
        }
        Logger().d(value);
        //  emit(GetSizesSuccessState());
      }).catchError((error) {
        emit(GetSizesErrorState());
        Logger().e(error);
      });
    } catch (e) {}
  }

  Map<int, Map<int, Map>> colorSizeMap = {};

  convertVariantToMap() {
    if (productModel.product?.productVariants != null) {
      for (var variant in productModel.product!.productVariants!) {
        final colorId = variant.colorId ?? -1;
        final sizeId = variant.sizeId ?? -1;
        if (!colorSizeMap.containsKey(colorId)) {
          colorSizeMap[colorId] = {};
        }
        // if (!colorSizeMap[colorId]!.containsKey(sizeId)) {
        //   colorSizeMap[colorId]![sizeId] = [];
        // }
        if (!colorSizeMap[colorId]!.containsKey(sizeId)) {
          colorSizeMap[colorId]![sizeId] = {
            'VariantId': variant.id,
            'ColorName': variant.color!.color,
            'hex': variant.color!.hex,
            'SizeName': variant.size!.size,
            'Quantity': variant.variantQuantity,
          };
        }
        // if (variant.variantQuantity! > 0) {
        //   colorSizeMap[colorId]![sizeId]!.add(variant.id!);
        // }
        // if (variant.variantQuantity! > 0) {
        //   colorSizeMap[colorId]![sizeId]!.add({
        //     'id': variant.id,
        //     'color': {'id': variant.colorId, 'name': variant.color!.color},
        //     'size': {'id': variant.sizeId , 'name': variant.size!.size},
        //     'variantQuantity': variant.variantQuantity,
        //   });
        // }
      }
    }
// Iterate over the map and print each color, size, and variant ID
//     colorSizeMap.forEach((colorId, sizeMap) {
//       print('Color ID: $colorId');
//       print('{');
//       sizeMap.forEach((sizeId, variantList) {
//         print('     {');
//         print('  Size ID: $sizeId');
//         print('  Variants: $variantList');
//         print('      },');
//       });
//       print('},');
//     });

    colorSizeMap.forEach((colorId, sizeMap) {
      print('Color: $colorId');

      sizeMap.forEach((sizeId, variant) {
        print('  Size: $sizeId');
        print('    Details: ${variant}');
      });
    });
  }

  // void convertVariantToMap2() {
  //   for (var variant in productModel.product!.productVariants!) {
  //     final colorId = variant['color_id'] ?? -1;
  //     final sizeId = variant['size_id'] ?? -1;
  //     final colorName = variant['color']['color'] ?? "Unknown Color";
  //     final sizeName = variant['size']['size'] ?? "Unknown Size";
  //
  //     if (!colorSizeMap.containsKey(colorId)) {
  //       colorSizeMap[colorId] = {};
  //     }
  //     if (!colorSizeMap[colorId]!.containsKey(sizeId)) {
  //       colorSizeMap[colorId]![sizeId] = [];
  //     }
  //     if (variant['variant_quantity'] > 0) {
  //       colorSizeMap[colorId]![sizeId]!.add({
  //         'id': variant['id'],
  //         'color': {'id': colorId, 'name': colorName},
  //         'size': {'id': sizeId, 'name': sizeName},
  //         'variant': variant['variant_quantity'],
  //       });
  //     }
  //   }
  //
  //   colorSizeMap.forEach((colorId, sizeMap) {
  //     sizeMap.forEach((sizeId, variantList) {
  //       print('Color: $colorId Size: $sizeId {');
  //       variantList.forEach((variant) {
  //         print(' ${variant.toString()},');
  //       });
  //       print('}');
  //     });
  //   });
  // }

  Map<int, Map<int, List<Map>>> convertToMapWithColorSize(
      Map<int, Map<int, List<int>>> colorSizeMap,
      Map<int, Color> colors,
      Map<int, Size> sizes) {
    Map<int, Map<int, List<Map>>> result = {};

    colorSizeMap.forEach((colorId, sizeMap) {
      result[colorId] = {};
      sizeMap.forEach((sizeId, variantIds) {
        List<Map> variants = [];

        for (var variantId in variantIds) {
          variants.add({
            "id": variantId,
            "color": colors[colorId]!,
            "size": sizes[sizeId]!
          });
        }

        result[colorId]![sizeId] = variants;
      });
    });

    return result;
  }

  addToCart(variantId, quantity) {
    dioHelper.postData(
      url: 'api/user/add_to_cart/$variantId',
      data: {
        'quantity': quantity,
      },
    ).then((value) {
      // print(value.data.toString());
      if (value.statusCode == 200) {
        if (value.data["status"] == 1) {
          toast(value.data["message"]);
        } else {
          toast(value.data["message"]);
        }
      }
    }).catchError((error) {
      print(error.toString());
      toast('Something went wrong!Please try again later');
    });
  }

  addComment(productId, comment) {
    dioHelper.postData(
      url: 'api/user/add_comment/$productId',
      data: {
        'comment': comment,
      },
    ).then((value) {
      // print(value.data.toString());
      if (value.statusCode == 200) {
        if (value.data["status"] == 1) {
          toast(value.data["message"]);
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
