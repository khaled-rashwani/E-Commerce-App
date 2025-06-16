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
import '../../cubit/TagCubit/cubit.dart';
import '../../cubit/TagCubit/states.dart';
import '../ProductCard.dart';

class TagProductsList extends StatelessWidget {
  int id = 1;

  TagProductsList(id) {
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TagCubit()..getTagProducts(id),
      child: BlocConsumer<TagCubit, TagStates>(
        builder: (context, state) {
          print('state is: ');
          print(state);
          if (state is GetTagsProductSuccessState) {
            if (TagCubit.get(context).tagsProductModel.tagProducts!.length !=
                0) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Products'),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Container(
                    height: 1000,
                    child: GridView.count(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 0,
                        children: List.generate(
                            TagCubit.get(context)
                                .tagsProductModel
                                .tagProducts!
                                .length, (index) {
                          return ProductItem(
                              TagCubit.get(context)
                                  .tagsProductModel
                                  .tagProducts![index],
                              false);
                          print(index);
                        })),
                  ),
                ),
              );
              ;
            } else
              return Container();
          }
          if (state is GetTagsProductLoadingState)
            return Scaffold(body: buildLoadingWidget());
          if (state is GetTagsProductErrorState || state is GetTagsProductEmptyState) {
            // TagCubit.get(context).getTags();
            return Scaffold(body: buildErrorWidget());
          } else
            return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
