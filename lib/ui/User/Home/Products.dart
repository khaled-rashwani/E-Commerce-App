import 'dart:async';

import 'package:EZ_Shop/cubit/FavoriteCubit/cubit.dart';
import 'package:EZ_Shop/cubit/FavoriteCubit/states.dart';
import 'package:EZ_Shop/models/CategoriesModel.dart';
import 'package:EZ_Shop/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/helperFunctions.dart';
import '../../../shared/network/dio.dart';
import '../../../shared/themes.dart';
import '../../ProductCard.dart';
import '../ProductDetails.dart';

class ProductsList extends StatelessWidget {
//  Children subcategory = Children();
  dynamic subcategory;

  ProductsList(subcategory) {
    this.subcategory = subcategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),

        child: subcategory.products!.length!=0?Container(
          height: 1000,
          child: GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 15,
              mainAxisSpacing: 0,
              children: List.generate(subcategory.products!.length, (index) {
                return ProductItem(subcategory.products![index], false);
                print(index);
              })),
        ):Center(
            child: Text(
              'Sorry! There is no products until now here.',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
            ))
      ),
    );
  }
}


