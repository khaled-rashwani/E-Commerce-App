import 'package:EZ_Shop/cubit/CategoryCubit/states.dart';
import 'package:EZ_Shop/models/CategoriesModel.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:EZ_Shop/ui/User/Home/Products.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../shared/components.dart';
import '../../../shared/helperFunctions.dart';
import '../../../shared/themes.dart';
import '../Search.dart';

class Subcategories extends StatelessWidget {
  dynamic subcategories;
  dynamic state;

  Subcategories(List<Children>? subcategories, state) {
    this.subcategories = subcategories;
    this.state = state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildSubCate(subcategories, context, state),
    );
  }
}

Widget _buildSubCate(subcategories, context, state) {
  if (state is GetCategorySuccessState)
    return subcategories.length != 0
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                children: List.generate(subcategories.length, (index) {
                  return _buildSubCategoryItem(subcategories[index], context);
                })),
          )
        : Center(
            child: Text(
            'Sorry! There is no subcategories until now here.',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
          ));
  else
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Image.asset(
        'images/load.gif',
        width: 70,
      )),
    );
}

Widget _buildSubCategoryItem(SubCategory, context) {
  return InkWell(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 145,
            width: 145,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(90))),
            child:
                // Image.network(
                //   baseUrl + SubCategory!.image.toString(),
                //   fit: BoxFit.cover,
                // ),
                FadeInImage.assetNetwork(
              placeholder: '',
              image: SubCategory.image != null
                  ? baseUrl + SubCategory.image.toString()
                  : '',
              fit: BoxFit.cover,
              placeholderErrorBuilder:
                  (BuildContext, Object exception, StackTrace? stackTrace) {
                return Container(
                  color: Colors.grey.shade100,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            SubCategory!.name.toString(),
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ),
    onTap: () {
      NavigateTo(context, ProductsList(SubCategory));
    },
  );
}
