import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/themes.dart';
import '../cubit/FavoriteCubit/cubit.dart';
import '../cubit/FavoriteCubit/states.dart';
import '../shared/helperFunctions.dart';
import '../shared/network/dio.dart';
import 'User/ProductDetails.dart';

class ProductItem extends StatefulWidget {
  dynamic product;

  bool inFave = false;

  ProductItem(product, inFave) {
    this.product = product;
    this.inFave = inFave;
  }

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _showFaveIcon = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(),
      child: BlocConsumer<FavoriteCubit, FavoriteStates>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  child: Material(
                    elevation: 1,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Stack(
                      children: [
                        Container(
                          // height: 222,
                          width: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 170,
                                width: double.infinity,
                                child: FadeInImage.assetNetwork(
                                  placeholder: '',
                                  image: widget.product.productImages![0]
                                      .productImage !=
                                      null
                                      ? baseUrl.toString() +
                                      widget.product.productImages![0]
                                          .productImage
                                          .toString()
                                      : '',
                                  fit: BoxFit.cover,
                                  placeholderErrorBuilder: (BuildContext,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Container(
                                      width: double.infinity,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            widget.product.name.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        if (widget.product.discountPercentage !=
                                            0)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.product.discountPrice
                                                      .toString() +
                                                      '\$  ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  widget.product.price
                                                      .toString() +
                                                      '\$  ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w100,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (widget.product.discountPercentage ==
                                            0)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.product.price
                                                      .toString() +
                                                      '\$  ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                      child: widget.product.productQuantity > 0
                                          ? Text(
                                        'In Stock',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                            color: myDarkGreen),
                                      )
                                          : Text(
                                        'Out of Stock',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                            color: Colors.red),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.inFave)
                              IconButton(
                                  icon: Icon(Icons.favorite),
                                  onPressed: () {
                                    setState(() {
                                      if (widget.inFave)
                                        FavoriteCubit.get(context)
                                          ..removeFromFavorite(
                                              widget.product.id);
                                      FavoriteCubit.get(context).getFavorite();
                                    });
                                  }),
                            Spacer(),
                            if (widget.product.discountPercentage != 0)
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                    height: 18,
                                    alignment: AlignmentDirectional.topEnd,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        // borderRadius:
                                        //     BorderRadius.only(topRight: Radius.circular(12)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Text(
                                      ' - ' +
                                          widget.product.discountPercentage
                                              .toString() +
                                          '% ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 14),
                                    )),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    NavigateTo(context, ProductDetails(widget.product.id));
                  },
                  onDoubleTap: () {
                    setState(() {
                      _showFaveIcon = true;
                      FavoriteCubit.get(context)
                        ..addToFavorite(widget.product.id);
                    });

                    Timer(Duration(milliseconds: 1000), () {
                      setState(() {
                        _showFaveIcon = false;
                      });
                    });
                  },
                ),
              ),
              if (_showFaveIcon)
                Center(
                    child: Icon(
                      Icons.favorite_border_rounded,
                      size: 35,
                      color: Colors.white,
                    )),
            ],
          );
          return SizedBox();
        },
        listener: (context, state) {},
      ),
    );
  }
}

Widget buildProduct(context, product, {inFave = false}) {
  return BlocProvider(
    create: (context) => FavoriteCubit(),
    child: BlocConsumer<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            child: Material(
              elevation: 1,
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Stack(
                children: [
                  Container(
                    // height: 222,
                    width: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 170,
                          width: double.infinity,
                          child: FadeInImage.assetNetwork(
                            placeholder: '',
                            image:
                            product.productImages![0].productImage != null
                                ? baseUrl.toString() +
                                product.productImages![0].productImage
                                    .toString()
                                : '',
                            fit: BoxFit.cover,
                            placeholderErrorBuilder: (BuildContext,
                                Object exception, StackTrace? stackTrace) {
                              return Container(
                                width: double.infinity,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      product.name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  if (product.discountPercentage != 0)
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                product.discountPrice.toString() +
                                                    '\$',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),maxLines: 1,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                product.price.toString() + '\$',maxLines: 1,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    decoration:
                                                    TextDecoration.lineThrough,overflow: TextOverflow.ellipsis,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (product.discountPercentage == 0)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.price.toString() + '\$  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              flex: 10,
                            ),
                            Flexible(
                                child: product.productQuantity > 0
                                    ? Text(
                                  'In Stock',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                      color: myDarkGreen),
                                )
                                    : Text(
                                  'Out of Stock',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                      color: Colors.red),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (inFave)
                        IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                              FavoriteCubit.get(context)
                                ..removeFromFavorite(product.id);
                            }),
                      Spacer(),
                      if (product.discountPercentage != 0)
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              height: 18,
                              alignment: AlignmentDirectional.topEnd,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  // borderRadius:
                                  //     BorderRadius.only(topRight: Radius.circular(12)),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                              child: Text(
                                ' - ' +
                                    product.discountPercentage.toString() +
                                    '% ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14),
                              )),
                        ),
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              NavigateTo(context, ProductDetails(product.id));
            },
            onDoubleTap: () {
              FavoriteCubit.get(context)..addToFavorite(product.id);
            },
          ),
        );
        return SizedBox();
      },
      listener: (context, state) {},
    ),
  );
}