import 'package:EZ_Shop/cubit/BannerCubit/cubit.dart';
import 'package:EZ_Shop/cubit/homeCubit/states.dart';
import 'package:EZ_Shop/models/BannersModel.dart';
import 'package:EZ_Shop/models/CategoriesModel.dart';
import 'package:EZ_Shop/models/SearchModel.dart';
import 'package:EZ_Shop/shared/sharedPreferences.dart';
import 'package:EZ_Shop/ui/User/Home/subcategories.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/BannerCubit/states.dart';
import '../../../cubit/CategoryCubit/cubit.dart';
import '../../../cubit/CategoryCubit/states.dart';
import '../../../cubit/TagCubit/cubit.dart';
import '../../../cubit/TagCubit/states.dart';
import '../../../cubit/homeCubit/cubit.dart';
import '../../../models/TagsModel.dart';
import '../../../shared/components.dart';
import '../../../shared/helperFunctions.dart';
import '../../../shared/network/dio.dart';
import '../../../shared/themes.dart';
import '../../ProductCard.dart';
import '../Search.dart';
import '../tagProducts.dart';
import 'Products.dart';
import 'StoresCategories.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: primaryColor,
                ),
                height: 290,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedTextKit(
                          isRepeatingAnimation: true,
                          pause: Duration(seconds: 5),
                          repeatForever: true,
                          animatedTexts: [
                            TyperAnimatedText(
                                'Welcome ' + CacheHelper.getStringData(
                                    key: 'user_name') ?? '',
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black)),
                          ],
                        ),
                        Icon(
                          Icons.notifications,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      ' Find cool products fit \n your style!',
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: Material(
                        elevation: 2,
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.search_rounded, color: primaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Search',
                                style: TextStyle(color: primaryColor),
                              ),
                            ],
                          ),
                          height: 55,
                          width: double.infinity,
                        ),
                      ),
                      onTap: () {
                        NavigateTo(context, Search());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //category
                _buildCategories(),
                SizedBox(
                  height: 10,
                ),
                //banners
                _buildBanners(),
                SizedBox(
                  height: 20,
                ),
                // tags
                _buildTags(),
                //best sales section
                _buildBestSales(),

                //new products section
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   clipBehavior: Clip.none,
                //   height: 237,
                //   child: ListView.separated(
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, index) {
                //         return buildProductInUserHome(context);
                //       },
                //       separatorBuilder: (context, index) {
                //         return const SizedBox(
                //           width: 10,
                //         );
                //       },
                //       itemCount: 5),
                // ),
                  _buildNewProduct(),
              ],
            ),
          ),
          SizedBox(
            height: 500,
          )
        ],
      ),
    );
  }
}

Widget _buildBanners() {
  return BlocProvider(
    create: (context) =>
    BannerCubit()
      ..getBanners(),
    child: BlocConsumer<BannerCubit, BannerStates>(
      builder: (context, state) {
        print('state is: ');
        print(state);
        if (state is GetBannersSuccessState) {
          if (BannerCubit
              .get(context)
              .bannersModel
              .data!
              .length != 0) {
            return CarouselSlider.builder(
              options: CarouselOptions(
                clipBehavior: Clip.hardEdge,
                autoPlayCurve: Curves.elasticIn,
                aspectRatio: 2 / 1,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
              itemCount: BannerCubit
                  .get(context)
                  .bannersModel
                  .data!
                  .length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                BannerCubit.get(context).getImage(BannerCubit
                    .get(context)
                    .bannersModel
                    .data![index].image.toString());
                return InkWell(
                  // child: FadeInImage.assetNetwork(
                  //   placeholder: 'images/slider.jpg',
                  //   image: BannerCubit
                  //       .get(context)
                  //       .bannersModel
                  //       .data![index]
                  //       .image !=
                  //       null
                  //       ? baseUrl +
                  //       BannerCubit
                  //           .get(context)
                  //           .bannersModel
                  //           .data![index]
                  //           .image
                  //           .toString()
                  //       : '',
                  //   fit: BoxFit.cover,
                  //   placeholderErrorBuilder: (BuildContext, Object exception,
                  //       StackTrace? stackTrace) {
                  //     return Container(
                  //       height: double.infinity,
                  //       width: double.infinity,
                  //       color: Colors.grey.shade100,
                  //       child: Icon(
                  //         Icons.image_not_supported_outlined,
                  //         size: 40,
                  //         color: Colors.white,
                  //       ),
                  //     );
                  //   },
                  // ),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    child: FadeInImage.assetNetwork(
                      placeholder: '',
                      image: BannerCubit
                          .get(context)
                          .bannersModel
                          .data![index]
                          .image !=
                          null
                          ? baseUrl +
                          BannerCubit
                              .get(context)
                              .bannersModel
                              .data![index]
                              .image
                              .toString()
                          : '',
                      fit: BoxFit.cover,
                      width: double.infinity,

                      placeholderErrorBuilder: (BuildContext, Object exception,
                          StackTrace? stackTrace) {
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.grey.shade100,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),clipBehavior: Clip.hardEdge,
                  ),
                  onTap: () {
                    NavigateTo(
                        context,
                        StoresCategories(BannerCubit
                            .get(context)
                            .bannersModel
                            .data![index]
                            .adminId));
                  },
                );
              },
            );
          } else
            return Container();
        }
        if (state is GetBannersLoadingState) return buildLoadingWidget();
        if (state is GetBannersErrorState) {
          // BannerCubit.get(context).getBanners();
          return buildErrorWidget();
        } else
          return Container();
      },
      listener: (context, state) {},
    ),
  );
}

Widget _buildTags() {
  return BlocProvider(
    create: (context) =>
    TagCubit()
      ..getTags(),
    child: BlocConsumer<TagCubit, TagStates>(
      builder: (context, state) {
        print('state is: ');
        print(state);
        if (state is GetTagsSuccessState) {
          if (TagCubit
              .get(context)
              .tagsModel
              .tags!
              .length != 0) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [ Text(
                'Browse Popular Tags:',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,
              ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 30,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: myDarkGreenLight,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              margin:
                              EdgeInsetsDirectional.only(start: 5, end: 5),
                              child: Center(
                                child: Text('#' +
                                    TagCubit
                                        .get(context)
                                        .tagsModel
                                        .tags![index].tag.toString(),
                                  style: TextStyle(
                                      color: myDarkGreen,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            print(TagCubit
                                .get(context)
                                .tagsModel
                                .tags![index].id);
                            NavigateTo(context, TagProductsList(TagCubit
                                .get(context)
                                .tagsModel
                                .tags![index].id));
                            // TagCubit.get(context).getTagProducts(TagCubit
                            //     .get(context)
                            //     .tagsModel
                            //     .tags![index].id);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 15,
                        );
                      },
                      itemCount: TagCubit
                          .get(context)
                          .tagsModel
                          .tags!
                          .length),
                ),
                SizedBox(
                  height: 20,
                ),
              ],);
          } else
            return Container();
        }
        if (state is GetTagsLoadingState) return buildLoadingWidget();
        if (state is GetTagsErrorState) {
          // TagCubit.get(context).getTags();
          return buildErrorWidget();
        } else
          return Container();
      },
      listener: (context, state) {},
    ),
  );
}

Widget _buildCategories() {
  return BlocProvider(
    create: (context) =>
    CategoryCubit()
      ..getCategories(),
    child: BlocConsumer<CategoryCubit, CategoryStates>(
      builder: (context, state) {
        print('state is: ');
        print(state);
        if (state is GetCategorySuccessState) {
          CategoriesModel _Categories =
              CategoryCubit
                  .get(context)
                  .categoriesModel;
          if (_Categories.data!.length != 0)
            return GridView.count(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 4,
                childAspectRatio: 0.82,
                mainAxisSpacing: 20,
                children: List.generate(_Categories.data!.length, (index) {
                  return _buildCategoryItem(
                      _Categories.data![index], context, state);
                }));
        }
        if (state is GetCategoryLoadingState) return buildLoadingWidget();
        if (state is GetCategoryErrorState) {
          // CategoryCubit.get(context).getCategories();
          return buildErrorWidget();
        } else
          return Container();
      },
      listener: (context, state) {},
    ),
  );
}

Widget _buildCategoryItem(Category, context, state) {
  return InkWell(
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              //color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(90))),
            child: FadeInImage.assetNetwork(
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
            height: 5,
          ),
          Flexible(
            flex: 2,
            child: Text(
              Category.name.toString(),
              overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      NavigateTo(context, Subcategories(Category.children, state));
    },
  );
}

Widget _buildBestSales() {
  return BlocProvider(
    create: (context) =>
    HomeCubit()
      ..getSearch('l'),
    child: BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        print('state is: ');
        print(state);
        if (state is GetBestSuccessState) {
          SearchModel _products = HomeCubit
              .get(context)
              .searchModel;
          if (_products.data!.length != 0)
            // return Container(
            //   height: 280,
            //   child: ListView.separated(
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,physics: NeverScrollableScrollPhysics(),
            //       itemBuilder: (context, index) {
            //         return buildProduct(context,_products.data![index]);
            //       },
            //       separatorBuilder: (context, index) {
            //         return const SizedBox(
            //           width: 10,
            //         );
            //       },
            //       itemCount: _products.data!.length),
            // );
            return Stack(

              children: [
                Text(
                  'Best sales:',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                ),
                GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 0,
                    children: List.generate(_products.data!.length, (index) {
                      return ProductItem(_products.data![index], false);
                      print(index);
                    })),
              ],
            );
        }
        if (state is GetBestLoadingState) return buildLoadingWidget();
        if (state is GetBestErrorState) {
          return buildErrorWidget();
        } else
          return Container();
      },
      listener: (context, state) {},
    ),
  );
}

Widget _buildNewProduct() {
  return BlocProvider(
    create: (context) =>
    HomeCubit()
      ..getNew(),
    child: BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        print('state is: ');
        print(state);
        if (state is GetNewSuccessState) {
          SearchModel _products = HomeCubit
              .get(context)
              .searchModel2;
          if (_products.data!.length != 0)
            return Stack(
              children: [
                Text(
                  'New Products:',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                ),
                GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 0,
                    children: List.generate(_products.data!.length, (index) {
                      return ProductItem(_products.data![index], false);
                      print(index);
                    })),
              ],
            );
        }
        if (state is GetNewLoadingState) return buildLoadingWidget();
        if (state is GetNewErrorState) {
          return buildErrorWidget();
        } else
          return Container();
      },
      listener: (context, state) {},
    ),
  );
}


