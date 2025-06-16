import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/homeCubit/cubit.dart';
import '../../../cubit/homeCubit/states.dart';

import '../../../shared/helperFunctions.dart';
import '../cart.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: (HomeCubit.get(context).CurrentIndex!=0)? AppBar(
            title: Text(
              HomeCubit.get(context)
                  .Titles[HomeCubit.get(context).CurrentIndex],
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),

          ):null,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: FloatingActionButton(
              child: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                NavigateTo(context, Cart());
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              HomeCubit.get(context)
                  .Screens[HomeCubit.get(context).CurrentIndex],
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: BottomNavigationBar(
                      items:  [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: 'Home'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.storefront), label: 'Stores'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.favorite_border_outlined),
                            label: 'Favorites'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person), label: 'Profile'),
                      ],
                      onTap: (index) {
                        HomeCubit.get(context).ChangeIndex(index);
                      },
                      type: BottomNavigationBarType.fixed,
                      landscapeLayout:
                          BottomNavigationBarLandscapeLayout.linear,
                      currentIndex: HomeCubit.get(context).CurrentIndex,
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
