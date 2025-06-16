import 'package:EZ_Shop/ui/User/Home/Products.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/SearchCubit/cubit.dart';
import '../../cubit/SearchCubit/states.dart';
import '../../shared/components.dart';
import '../ProductCard.dart';
import 'Search.dart';

class Search extends StatelessWidget {
  TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: defaultTextFormField(
                            onChanged: (value) {
                              SearchCubit.get(context)
                                  .getSearch(SearchController.text);
                              print(value);
                            },
                            onTap: () {},
                            validator: (value) {},
                            myController: SearchController,
                            hint: 'Search',
                            prefixIcon: Icon(Icons.search)),
                      ),

                      if (state is SearchInitialState || SearchController.text=='')
                        Column(
                          children: [
                            SizedBox(height: 140,),
                            Center(
                                child: Image.asset(
                              'images/search.png',
                              height: 300,
                            )),
                          ],
                        ),
                      if (state is GetSearchSuccessState && SearchCubit.get(context).searchModel.data!.length!=0)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                          childAspectRatio: 0.78,
                          crossAxisCount: 2,
                          children: List.generate(
                              SearchCubit.get(context)
                                  .searchModel
                                  .data!
                                  .length, (index) {
                            dynamic product = SearchCubit.get(context)
                                .searchModel
                                .data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ProductItem( product, false),
                            );
                          })),
                        ),
                      if (state is GetSearchSuccessState && SearchCubit.get(context).searchModel.data!.length==0 && SearchController.text!='')
                        Column(
                          children: [
                            SizedBox(height: 30,),
                            Center(
                                child: Image.asset(
                                  'images/not_found.png',
                                  height: 250,
                                )),
                            Text(
                              'Not Found!',
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      if(state is GetSearchLoadingState)
                        buildLoadingWidget(),
                      if(state is GetSearchErrorState)
                        buildErrorWidget()
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
