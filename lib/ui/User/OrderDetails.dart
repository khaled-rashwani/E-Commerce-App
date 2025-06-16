import 'package:EZ_Shop/cubit/CategoryCubit/states.dart';
import 'package:EZ_Shop/models/CategoriesModel.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:EZ_Shop/ui/User/Home/Products.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/components.dart';
import '../../../shared/helperFunctions.dart';
import '../../../shared/themes.dart';
import '../../models/OrdersModel.dart';
import '../rating.dart';

class OrderDetails extends StatelessWidget {
  List<OrderItems>? Items;

  OrderDetails(Items) {
    this.Items = Items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Items'),),
      body: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _buildOrderdProductItem(Items![index], context);
          },
          itemCount: Items!.length),
    );
  }
}

Widget _buildOrderdProductItem(OrderItems item, context) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                clipBehavior: Clip.hardEdge,
                width: 100,
                child: FadeInImage.assetNetwork(
                  placeholder: '',
                  image: item.variant!.product!.productImages![0]
                              .productImage !=
                          null
                      ? baseUrl.toString() +
                          item.variant!.product!.productImages![0].productImage
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
              SizedBox(
                width: 25,
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
                      item.variant!.product!.name!.toString(),
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
                        item.variant!.color!.color!.toString(),
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
                          color: HexColor(item.variant!.color!.hex!.toString()),
                        ),
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
                    item.variant!.size!.size!.toString(),
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Flexible(flex: 1,
                    child: Text(
                        'Price: ' + item.price.toString() + '\$',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Quantity: ' + item.quantity.toString(),
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                  Spacer(),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color:primaryColorLight,borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text('Rate',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.amber),),
                            Icon(Icons.star_rate_rounded,color: Colors.amber,),
                          ],
                        ),
                      ),
                    ),
                    onTap: (){
                      NavigateTo(context, Rate(item.variant!.productId));
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
