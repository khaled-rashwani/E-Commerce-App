import 'package:EZ_Shop/Shared/SharedPreferences.dart';
import 'package:EZ_Shop/cubit/FavoriteCubit/cubit.dart';
import 'package:EZ_Shop/cubit/FavoriteCubit/states.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/FavoriteModel.dart';
import '../../../models/FavoriteModel.dart';
import '../../../shared/components.dart';
import '../../../shared/helperFunctions.dart';
import '../../../shared/network/dio.dart';
import '../../../shared/themes.dart';
import '../../ProductCard.dart';
import '../ProductDetails.dart';
import '../Search.dart';
import 'Products.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavorite(),
      child: BlocConsumer<FavoriteCubit, FavoriteStates>(
        builder: (context, state) {
          print('state is: ');
          print(state);
          if (state is GetFavoriteSuccessState) {
            FavoriteModel _favorite = FavoriteCubit.get(context).favoriteModel;
            if (_favorite.data!.length != 0) {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 0.78,
                        crossAxisCount: 2,
                        children:
                            List.generate(_favorite.data!.length, (index) {
                          dynamic product = _favorite.data![index].product;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                           // child: buildProduct(context, product,inFave: true),
                            child: ProductItem(product, true),
                          );
                        })),
                    SizedBox(
                      height: 600,
                    ),
                  ],
                ),
              ));
            }
            if (_favorite.data!.length == 0) return _buildEmptyFavorite();
          }
          if (state is GetFavoriteLoadingState) return buildLoadingWidget();
          if (state is GetFavoriteErrorState) {
            return Scaffold(body: buildErrorWidget());
          }
          else
            return Container();
        },
        listener: (context, state) {
          if (state is GetIsProductFavoriteState) {
            FavoriteCubit.get(context)..getFavorite();
          }
          ;
        },
      ),
    );
  }
}

Widget _buildEmptyFavorite() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset('images/fav.png'),
      Text(
        'Looks Like You Haven\'t Added Any Item Until Now!\nDouble Click on The Product to Add it Here! ',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w200),
      ),
      SizedBox(
        height: 50,
      )
    ],
  );
}
