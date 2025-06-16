import 'dart:ui';
import 'package:EZ_Shop/models/CategoriesModel.dart';
import 'package:EZ_Shop/shared/helperFunctions.dart';
import 'package:EZ_Shop/shared/themes.dart';
import 'package:EZ_Shop/ui/User/ProductDetails.dart';
import 'package:flutter/material.dart';

Widget defaultTextFormField(
    {required validator,
    required myController,
    required hint,
    required prefixIcon,
    radius = 15.0,
    filled = true,
    keyboardType,
    isPassword = false,
    suffixOnPressed,
    suffixIcon,
    required onTap,width=double.infinity,
    onChanged}) {
  return Material(
    elevation: 1,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    child: Container(
      // height: 50,
      width: width,
      alignment: Alignment.center,
      child: TextFormField(
        onTap: onTap,
        keyboardType: keyboardType,
        obscureText: isPassword,
        validator: validator,
        controller: myController,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            border: InputBorder.none),
      ),
    ),
  );
}

Widget defaultButton({
  required text,
  required onPressed,
  width = double.infinity,
  height = 40.0,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300),
      ),
    ),
  );
}

Widget buildProductInUserHome(context) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        child: Material(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Stack(
            children: [
              Container(
                height: 222,
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      child: Image.asset(
                        'images/test_img1_bag.jpg',
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              'Little bag with flowers',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 18),
                            ),
                          ),
                          SizedBox.shrink(),
                          Row(
                            children: [
                              Text(
                                '1000\$',
                                style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14),
                              ),
                              Text(
                                '950\$',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.favorite_border_outlined))
            ],
          ),
        ),
        onTap: (){
          NavigateTo(context, ProductDetails(1));
        },
      ),
    ),
  );
}





Widget buildLoadingWidget(){
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Image.asset(
            'images/load.gif',
            width: 70,
          )),
    ),
  );
}
Widget buildErrorWidget(){
  return Center(
    child: Container(
      child: Icon(
        Icons.error_outline,
        size: 40,
        color: Colors.grey,
      ),
    ),
  );
}


