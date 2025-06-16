import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/StoresCubit/cubit.dart';
import '../../../cubit/StoresCubit/states.dart';
import '../../../models/CategoriesModel.dart';
import '../../../models/StoresModel.dart';
import '../../../shared/components.dart';
import '../../../shared/helperFunctions.dart';
import '../../../shared/network/dio.dart';
import '../../../shared/themes.dart';
import '../Search.dart';
import 'StoresCategories.dart';

class Stores extends StatelessWidget {
  const Stores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()..getStores(),
      child: BlocConsumer<StoreCubit, StoreStates>(
        builder: (context, state) {
          print('state is: ');
          print(state);
          if (state is GetStoreSuccessState) {
            if (StoreCubit.get(context).storesModel.data!.length != 0)
              return buildStores(StoreCubit.get(context).storesModel,context);
            else
              return buildErrorWidget();
          }
          if (state is GetStoreLoadingState) return buildLoadingWidget();
          if (state is GetStoreErrorState) {
           // StoreCubit.get(context).getStores();
            return buildErrorWidget();
          } else
            return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}

buildStores(StoresModel stores,context) {
  return SingleChildScrollView(
 child:
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all( 15),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  children: List.generate(stores.data!.length, (index) {
                    return buildStore(stores.data![index], context);
                  })),
              SizedBox(height: 700,)
            ],
          ),
        ),
      ),


  );
}

Widget buildStore( store,context ) {
  return InkWell(
    child: Material(
        elevation: 1,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage.assetNetwork(
                height: 140,
                width: double.infinity,
                placeholder: '',
                image: store.logo !=
                    null
                    ? baseUrl.toString() +
                    store.logo
                        .toString()
                    : '',
                fit: BoxFit.cover,
                placeholderErrorBuilder:
                    (BuildContext, Object exception,
                    StackTrace? stackTrace) {
                  return Container(
                    height: 135,
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
              SizedBox(height: 8,),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: Text(
                      store.companyName.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    store.description.toString()   ,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                        color: myDarkGreen),
                  ),
                ),
              ),

            ],
          ),
        )),
    onTap: (){
      NavigateTo(context, StoresCategories(store.id));
    },
  );
}
