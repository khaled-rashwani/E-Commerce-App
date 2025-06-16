import 'package:EZ_Shop/cubit/StoresCubit/cubit.dart';
import 'package:EZ_Shop/cubit/StoresCubit/states.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:EZ_Shop/ui/User/Home/Products.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/StoresCategoriesModel.dart';
import '../../../shared/components.dart';
import '../../../shared/helperFunctions.dart';
import '../../../shared/themes.dart';
import '../Search.dart';

class StoresCategories extends StatelessWidget {
  late var id;

  StoresCategories(id) {
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()..getStoreCategories(id),
      child: BlocConsumer<StoreCubit, StoreStates>(
        builder: (context, state) {
          print('state is: ');
          print(state);
          if (state is GetCategorySuccessState) {
            StoreCategoriesModel _Categories =
                StoreCubit.get(context).storeCategoriesModel;
            if (_Categories.data!.length != 0)
              return Scaffold(
                  appBar: AppBar(),
                  body: _buildCate(_Categories.data, context, state));
            else
              Container();
          }
          if (state is GetCategoryLoadingState)
            return Scaffold(body: buildLoadingWidget());
          if (state is GetCategoryErrorState) {
            // CategoryCubit.get(context).getCategories();
            return Scaffold(body: buildErrorWidget());
          }
          if (state is GetCategoryEmptyState) {
            // CategoryCubit.get(context).getCategories();
            return Scaffold(
                body: Center(
                    child: Text(
              'Sorry! This store does not have products until now!',
              style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
            )));
          } else
            return Scaffold(body: buildErrorWidget());
        },
        listener: (context, state) {},
      ),
    );
  }
}

Widget _buildCate(categories, context, state) {
  if (state is GetCategorySuccessState)
    return categories.length != 0
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                children: List.generate(categories.length, (index) {

                  return _buildCategoryItem(categories[index], context, state);
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

Widget _buildCategoryItem(Category, context, state) {
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
              image: Category.image != null
                  ? baseUrl + Category.image.toString()
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
            Category!.name.toString(),
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ),
    onTap: () {
      NavigateTo(context, StoresSubCategories(Category.children, state));
    },
  );
}
class StoresSubCategories extends StatelessWidget {
  dynamic _SubCategories;
  var state;

  StoresSubCategories(List<Children>? _SubCategories, state) {
    this._SubCategories = _SubCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _SubCategories != null
          ? _buildSubCate(_SubCategories, context)
          : Center(
              child: Text(
              'Sorry! There is no subcategories until now here.',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
            )),
    );
  }
}
Widget _buildSubCate(subcategories, context) {
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
}
Widget _buildSubCategoryItem(SubCategory, context) {
  if(SubCategory.products.length!=0)
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
    onTap: (){
      NavigateTo(context, ProductsList(SubCategory));
    },
  );
  else return SizedBox();
}
