
import 'package:EZ_Shop/shared/helperFunctions.dart';
import 'package:EZ_Shop/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/homeCubit/cubit.dart';
import '../cubit/homeCubit/states.dart';
import 'User/Home/home.dart';

class Rate extends StatefulWidget {
  late var id;

  Rate(this.id);

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  var isRated=false;

  var Rating=0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) => Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Rate the product from 1 to 5 stars!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: 270,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return IconButton(
                                onPressed: () {
                                  setState(() {
                                  Rating=index+1;
                                  HomeCubit.get(context).rate(widget.id, index + 1);
                                  isRated=true;
                                  print(Rating);
                                  print(index);
                                  NavigateAndFinish(context, Home());
                                });
                                },
                                icon: Icon(
                                  Icons.star,size: 50,
                                  color:Rating<index+1 ? Colors.grey :primaryColor,
                                )
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 7,
                            );
                          },
                          itemCount: 5),
                    )
                  ],
                ),
              ),
            ),
          )),
      listener: (context, state) {},
    );
  }
}
