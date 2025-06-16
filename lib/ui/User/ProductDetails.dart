import 'package:EZ_Shop/cubit/ProductCubit/cubit.dart';
import 'package:EZ_Shop/cubit/ProductCubit/states.dart';
import 'package:EZ_Shop/models/SizesModel.dart';
import 'package:EZ_Shop/shared/helperFunctions.dart';
import 'package:EZ_Shop/shared/themes.dart';
import 'package:EZ_Shop/ui/User/tagProducts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/Product.dart';
import '../../shared/components.dart';
import '../../shared/network/dio.dart';

class ProductDetails extends StatefulWidget {
  var id = 1;

  ProductDetails(id) {
    this.id = id;
  }

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool havesize = false;
  TextEditingController commentController = TextEditingController();

  // Map<int, List>? currentSizes;
  Map<int, Map>? currentSizes;

  var selectedColor = -1;
  var selectedSize = -1;
  var _count = 1;
  bool getProduct = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProductCubit()
          ..getColors()
          ..getSizes()
          ..getProduct(widget.id);
      },
      child: BlocConsumer<ProductCubit, ProductStates>(
        builder: (context, state) {
          print(state);
          // ProductCubit.get(context).getProduct(widget.id);
          if (state is GetProductSuccessState) {
            return Scaffold(
                body: ProductCubit.get(context).productModel.product != null
                    ? SafeArea(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SingleChildScrollView(
                              child: Expanded(
                                child: Column(
                                  children: [
                                    CarouselSlider.builder(
                                      itemCount: ProductCubit.get(context)
                                          .productModel
                                          .product!
                                          .productImages!
                                          .length,
                                      itemBuilder: (context, int itemIndex,
                                          int pageViewIndex) {
                                        return Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: '',
                                            image: ProductCubit.get(context)
                                                        .productModel
                                                        .product!
                                                        .productImages !=
                                                    null
                                                ? baseUrl.toString() +
                                                    ProductCubit.get(context)
                                                        .productModel
                                                        .product!
                                                        .productImages![
                                                            itemIndex]
                                                        .productImage
                                                        .toString()
                                                : '',
                                            fit: BoxFit.cover,
                                            placeholderErrorBuilder:
                                                (BuildContext, Object exception,
                                                    StackTrace? stackTrace) {
                                              return Container(
                                                width: double.infinity,
                                                color: Colors.grey.shade100,
                                                child: Icon(
                                                  Icons
                                                      .image_not_supported_outlined,
                                                  size: 40,
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        aspectRatio: 1,
                                        viewportFraction: 1,
                                        enlargeCenterPage: true,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                ProductCubit.get(context)
                                                    .productModel
                                                    .product!
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 20),
                                              ),
                                              Spacer(),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  color: Colors.amber
                                                      .withOpacity(0.1),
                                                ),
                                                clipBehavior: Clip.hardEdge,
                                                child: Container(
                                                  margin:
                                                      const EdgeInsetsDirectional
                                                              .only(
                                                          start: 10, end: 8),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        ProductCubit.get(
                                                                context)
                                                            .rating
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 18),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: primaryColor,
                                                        size: 18,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Description:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            ProductCubit.get(context)
                                                .productModel
                                                .product!
                                                .description
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 30,
                                            child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: myDarkGreenLight,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                      ),
                                                      clipBehavior: Clip.hardEdge,
                                                      child: Container(
                                                        margin:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                                    start: 5,
                                                                    end: 5),
                                                        child: Center(
                                                          child: Text('#'+
                                                            ProductCubit.get(
                                                                    context)
                                                                .productModel
                                                                .product!
                                                                .productTags![
                                                                    index]
                                                                .tag!
                                                                .tag
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    myDarkGreen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: (){
                                                      NavigateTo(context, TagProductsList(  ProductCubit.get(
                                                          context)
                                                          .productModel
                                                          .product!
                                                          .productTags![
                                                      index].tag!.id));
                                                    },
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    width: 10,
                                                  );
                                                },
                                                itemCount:
                                                    ProductCubit.get(context)
                                                        .productModel
                                                        .product!
                                                        .productTags!
                                                        .length),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Colors:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              height: 30,
                                              child: ProductCubit.get(context)
                                                          .colorsModel
                                                          .colors !=
                                                      null
                                                  ? ListView.separated(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        int colorId =
                                                            ProductCubit.get(
                                                                    context)
                                                                .colorSizeMap
                                                                .keys
                                                                .elementAt(
                                                                    index);
                                                        var colorHex =
                                                            ProductCubit.get(
                                                                    context)
                                                                .colorsModel
                                                                .colors![
                                                                    colorId - 1]
                                                                .hex;
                                                        print(colorId);
                                                        print(colorHex);
                                                      //  if(colorId!=1)
                                                        return InkWell(
                                                          child: Material(
                                                            elevation: 1,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            child: colorId!=1?Container(
                                                              width: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                                color: HexColor(
                                                                    colorHex
                                                                        .toString()),
                                                              ),
                                                              child: selectedColor ==
                                                                      colorId
                                                                  ? Icon(Icons
                                                                      .check)
                                                                  : null,
                                                            ): Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                child: Text(
                                                                  'photo color',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                           FontWeight.w200,
                                                                      color:
                                                                           Colors.black
                                                                         ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              currentSizes =
                                                                  ProductCubit.get(
                                                                              context)
                                                                          .colorSizeMap[
                                                                      colorId];
                                                              print(currentSizes!
                                                                  .length
                                                                  .toString());
                                                              selectedColor =
                                                                  colorId;
                                                            });
                                                          },
                                                        );

                                                      },
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                          width: 10,
                                                        );
                                                      },
                                                      itemCount:
                                                          ProductCubit.get(
                                                                  context)
                                                              .colorSizeMap
                                                              .keys
                                                              .toList()
                                                              .length)
                                                  : Container()),
                                          if (currentSizes != null)
                                            SizedBox(
                                              height: 10,
                                            ),
                                          if (currentSizes != null)
                                            Text(
                                              'Sizes:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 16),
                                            ),
                                          if (currentSizes != null)
                                            SizedBox(
                                              height: 10,
                                            ),
                                          if (currentSizes != null)
                                            buildSizes(currentSizes),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (selectedSize != -1)
                                            Text(
                                              'Quantity:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 16),
                                            ),
                                          if (selectedSize != -1)
                                            SizedBox(
                                              height: 10,
                                            ),
                                          if (selectedSize != -1)
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.remove),
                                                  onPressed: _decrementCount,
                                                ),
                                                Text('$_count'),
                                                IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: _incrementCount,
                                                ),
                                              ],
                                            ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Price:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                ProductCubit.get(context)
                                                        .productModel
                                                        .product!
                                                        .discountPrice
                                                        .toString() +
                                                    '\$',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              if (ProductCubit.get(context)
                                                      .productModel
                                                      .product!
                                                      .discountPercentage !=
                                                  0)
                                                Text(
                                                  ProductCubit.get(context)
                                                          .productModel
                                                          .product!
                                                          .price
                                                          .toString() +
                                                      '\$',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      fontSize: 16,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.grey),
                                                ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Comments:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          buildComments(
                                              ProductCubit.get(context)
                                                  .commentsModel),
                                          if (ProductCubit.get(context)
                                                  .commentsModel
                                                  .data!
                                                  .length ==
                                              0)
                                            Center(
                                              child: Text(
                                                'No Comments yet!',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          defaultTextFormField(
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.check, color: commentController.text!=''? primaryColor : Colors.grey, ),
                                                onPressed: () {
                                                  setState(() {
                                                    ProductCubit.get(
                                                            context)
                                                        .addComment(
                                                            ProductCubit.get(
                                                                    context)
                                                                .productModel
                                                                .product!
                                                                .id,
                                                            commentController
                                                                .text);
                                                    ProductCubit.get(context).getProduct(widget.id);
                                                    commentController= TextEditingController();
                                                  });
                                                },
                                              ),
                                              validator: (val) {},
                                              myController:
                                                  commentController,
                                              hint:
                                                  'Write you comment here!',
                                              prefixIcon:
                                                  Icon(Icons.comment),
                                              onTap: () {}),
                                          SizedBox(
                                            height: 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //add to cart button
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: defaultButton(
                                  onPressed: () {
                                    var variantIds = ProductCubit.get(context)
                                                .colorSizeMap[selectedColor]
                                            ?[selectedSize]!['VariantId'] ??
                                        -1;
                                    print(variantIds);
                                    print(_count);
                                    if (variantIds != -1 && _count != -1) {
                                      ProductCubit.get(context)
                                          .addToCart(variantIds, _count);
                                    } else
                                      toast('Choose color and size before!');
                                  },
                                  text: 'Add to cart'),
                            )
                          ],
                        ),
                      )
                    : buildLoadingWidget());
          }
          if (state is GetProductErrorState) {
            return Scaffold(body: buildErrorWidget());
          }
          if (state is GetProductLoadingState) {
            return Scaffold(body: buildLoadingWidget());
          }
          return Scaffold(body: buildLoadingWidget());
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget buildSizes(currentSizes) {
    print('this is currentSizes:');
    print(currentSizes);
    return Container(
      height: 30,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var sizeId = currentSizes!.keys.elementAt(index);
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedSize = sizeId;
                    });
                  },
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(

                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            currentSizes[sizeId]['SizeName'].toString(),
                            style: TextStyle(
                                fontWeight: sizeId == selectedSize
                                    ? FontWeight.w400
                                    : FontWeight.w200,
                                color: sizeId == selectedSize
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 5,
            );
          },
          itemCount: currentSizes!.length),
    );
  }

  Widget buildComments(comments) {
    return Container(
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: FadeInImage.assetNetwork(
                    height: 40,
                    width: 40,
                    placeholder: '',
                    image: comments.data![index].user!.profileImgUrl != null
                        ? baseUrl.toString() +
                            comments.data![index].user!.profileImgUrl!
                                .toString()
                        : '',
                    fit: BoxFit.cover,
                    placeholderErrorBuilder: (BuildContext, Object exception,
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
                  width: 10,
                ),
                Expanded(
                  child: Material(
                    clipBehavior: Clip.hardEdge,
                    elevation: 1,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comments.data![index].user!.userName.toString(),
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              Text(
                                comments.data![index].comment.toString(),
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: comments.data!.length),
    );
  }

  void _decrementCount() {
    setState(() {
      if (_count > 1) {
        _count--;
      }
    });
  }

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }
}
