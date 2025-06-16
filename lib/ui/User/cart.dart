import 'package:EZ_Shop/cubit/CartCubit/cubit.dart';
import 'package:EZ_Shop/cubit/CartCubit/states.dart';
import 'package:EZ_Shop/models/CategoriesModel.dart';
import 'package:EZ_Shop/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/helperFunctions.dart';
import '../../../shared/network/dio.dart';
import '../../../shared/themes.dart';
import '../../cubit/OrderCubit/cubit.dart';
import '../../cubit/OrderCubit/states.dart';
import '../../models/CartModel.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Children subcategory = Children();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: BlocConsumer<CartCubit, CartStates>(
        builder: (context, state) {
          print('state is: ');
          print(state);
          if (state is GetCartSuccessState) {
            CartModel _cart = CartCubit.get(context).cartModel;
            if (_cart.cartItems!.length != 0) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('My Cart'),
                ),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          // shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == _cart.cartItems!.length)
                              return SizedBox(
                                height: 100,
                              );
                            return _buildCartItem(
                                _cart.cartItems![index], context);
                          },
                          itemCount: _cart.cartItems!.length + 1),
                    ),
                    _buildCheckoutCard()
                  ],
                ),
              );
            }
            if (_cart.cartItems!.length == 0)
              return Scaffold(appBar: AppBar(), body: _buildEmptyCart());
          }
          if (state is GetCartLoadingState)
            return Scaffold(body: buildLoadingWidget());
          if (state is GetCartErrorState) {
            return Scaffold(body: buildErrorWidget());
          }
          if (state == CartInitialState) {
            // Handle the case when the state is null
            return CircularProgressIndicator(); // Or any other loading indicator or placeholder widget
          } else
            return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}

Widget _buildCartItem(CartItems item, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                clipBehavior: Clip.hardEdge,
                width: 100,
                child: FadeInImage.assetNetwork(
                  placeholder: '',
                  image: item.product!.productImages![0].productImage != null
                      ? baseUrl.toString() +
                          item.product!.productImages![0].productImage
                              .toString()
                      : '',
                  fit: BoxFit.cover,
                  placeholderErrorBuilder:
                      (BuildContext, Object exception, StackTrace? stackTrace) {
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
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 80,
                    child: Text(
                      item.product!.name.toString(),
                      maxLines: 1,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Color:',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        item.color!.color.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 14),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: HexColor(item.color!.hex.toString())),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Size:',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                  Text(
                    item.size!.size.toString(),
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      (item.product!.discountPrice * item.quantity!)
                              .toStringAsFixed(2) +
                          '\$',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Quantity:',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.remove,
                          size: 16,
                        ),
                        onPressed: () {
                          CartCubit.get(context)
                              .decreaseQuantity(item.variantId);
                        },
                      ),
                      Text(
                        item.quantity.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.add,
                          size: 16,
                        ),
                        onPressed: () {
                          CartCubit.get(context)
                              .increaseQuantity(item.variantId);
                        },
                      ),
                    ],
                  ),
                  _buildRemoveItemButton(context, item.variantId)
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildRemoveItemButton(context, variantId) {
  return InkWell(
    child: Row(
      children: [
        Text(
          'Remove ',
          style: TextStyle(
              fontWeight: FontWeight.w200, fontSize: 14, color: Colors.red),
        ),
        Icon(
          Icons.remove_circle_outline_sharp,
          size: 18,
          color: Colors.red,
        )
      ],
    ),
    onTap: () {
      CartCubit.get(context).removeFromCart(variantId);
    },
  );
}

Widget _buildEmptyCart() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('images/onBoarding1.png'),
      Text(
        'Your cart is empty!\nBrowse Our Products and Start Shopping Now!',
        style: TextStyle(fontWeight: FontWeight.w200),
        textAlign: TextAlign.center,
      )
    ],
  );
}

Widget _buildCheckoutCard() {
  return BlocProvider(
    create: (context) => OrderCubit()..check(),
    child: BlocConsumer<OrderCubit, OrderStates>(
      builder: (context, state) {
        print('state is: ');
        print(state);
        if (state is CheckSuccessState)
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  // border: Border.all(width: 1,color: primaryColor)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Total Price:',
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                OrderCubit.get(context)
                                        .checkedItems
                                        .price
                                        .toString() +
                                    '\$',
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Icon(Icons.check_circle_outline,color: Colors.green,),
                            SizedBox(width: 5,),
                            Text('Cash On Delivery',style: TextStyle(fontWeight: FontWeight.w200),),
                          ],)
                          // Row(
                          //   children: [
                          //     Text(
                          //       '+Delivery:',
                          //       style: TextStyle(fontWeight: FontWeight.w200),
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Text(
                          //       '10\$:',
                          //       style: TextStyle(fontWeight: FontWeight.w200),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // Container(
                          //   width: 140,
                          //   height: 0.1,
                          //   color: Colors.black,
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Total Price:',
                          //       style: TextStyle(fontWeight: FontWeight.w300),
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Text(
                          //       OrderCubit.get(context)
                          //           .checkedItems
                          //           .totalPrice
                          //           .toString() +
                          //           '\$',
                          //       style: TextStyle(fontWeight: FontWeight.w300),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              'Checkout ',
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        onTap: (){
                          print('**');
                          OrderCubit.get(context).completeOrder();
                          CartCubit.get(context).getCart();
                          print('**');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        if (state is CheckNotAvailableState){
          toast('Sorry! Some Products Are Out Of Stock Now');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  // border: Border.all(width: 1,color: primaryColor)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child: Text(
                            OrderCubit.get(context)
                                .checkedItems
                                .message
                                .toString(),
                            style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),
                            overflow: TextOverflow.ellipsis,maxLines: 5,
                          )),
                      Spacer(),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Center(
                          child: Text(
                            'Checkout ',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

        }
        if (state is CheckErrorState) return buildErrorWidget();
        if (state is CheckLoadingState) {
          return Container();
        } else
          return Container();
      },
      listener: (context, state) {},
    ),
  );
}
