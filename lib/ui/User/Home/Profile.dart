import 'package:EZ_Shop/cubit/AppCubit/states.dart';
import 'package:EZ_Shop/cubit/AuthCubit/cubit.dart';
import 'package:EZ_Shop/cubit/AuthCubit/states.dart';
import 'package:EZ_Shop/shared/helperFunctions.dart';
import 'package:EZ_Shop/shared/sharedPreferences.dart';
import 'package:EZ_Shop/ui/OrderHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/AppCubit/cubit.dart';
import '../../../cubit/homeCubit/cubit.dart';
import '../../../cubit/homeCubit/states.dart';
import '../../../shared/components.dart';
import '../Auth/login.dart';
import '../terms.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        print(CacheHelper.getStringData(key: 'token'));
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(90)),
                          ),
                          clipBehavior: Clip.hardEdge,
                          height: 120,
                          width: 120,
                          child: CacheHelper.getStringData(
                              key: 'profile_img_url') !=
                              'images/default_user2.png'
                              ? FadeInImage
                              .assetNetwork(
                            height: 40,
                            width: 40,
                            placeholder: 'images/default_user2.png',
                            image: CacheHelper.getStringData(
                                key: 'profile_img_url')
                                ,
                            fit: BoxFit.cover,
                            placeholderErrorBuilder:
                                (BuildContext,
                                Object
                                exception,
                                StackTrace?
                                stackTrace) {
                              return Container(
                                width: double
                                    .infinity,
                                color: Colors.grey
                                    .shade100,
                                child: Icon(
                                  Icons
                                      .image_not_supported_outlined,
                                  size: 40,
                                  color: Colors
                                      .white,
                                ),
                              );
                            },
                          ) :
                          Image.asset(
                            CacheHelper.getStringData(key: 'profile_img_url'),
                            fit: BoxFit.cover,
                          )
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        flex: 4,
                        child: Center(
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                CacheHelper.getStringData(key: 'user_name'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 20),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'email: ' +
                                    CacheHelper.getStringData(key: 'email'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 17),
                              ),
                              Text(
                                'phone: +963' + CacheHelper.getStringData(
                                    key: 'phone_number'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 17),
                              ),
                              Text(
                                    CacheHelper.getStringData(key: 'address'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     AppCubit.get(context).ChangeMode();
                  //   },
                  //   child: Material(
                  //     child: Container(
                  //       width: double.infinity,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Dark \\ Light mode",
                  //               style: TextStyle(
                  //                   fontSize: 16, fontWeight: FontWeight.w300),
                  //             ),
                  //             AppCubit
                  //                 .get(context)
                  //                 .darkLightIcon
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     borderRadius: BorderRadius.all(Radius.circular(15)),
                  //     clipBehavior: Clip.hardEdge,
                  //     elevation: 2,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Material(
                  //   child: Container(
                  //     width: double.infinity,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "My wallet",
                  //             style: TextStyle(
                  //                 fontSize: 16, fontWeight: FontWeight.w300),
                  //           ),
                  //           Icon(
                  //             Icons.wallet_outlined,
                  //             size: 16,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  //   borderRadius: BorderRadius.all(Radius.circular(15)),
                  //   clipBehavior: Clip.hardEdge,
                  //   elevation: 2,
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  InkWell(
                    child: Material(
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My orders history",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      clipBehavior: Clip.hardEdge,
                      elevation: 2,
                    ),
                    onTap: (){
                      NavigateTo(context, OrdersHistory());
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: Material(
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Terms and conditions",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      clipBehavior: Clip.hardEdge,
                      elevation: 2,
                    ),onTap: (){
                      NavigateTo(context, Terms());
                  },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildLogutButton(),
                  SizedBox(
                    height: 500,
                  ),
                ],
              ),
            ));
      },
    );
  }
}

Widget _buildLogutButton() {
  return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            child: Material(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                      Icon(
                        Icons.logout_outlined,
                        size: 16,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              clipBehavior: Clip.hardEdge,
              elevation: 2,
            ),
            onTap: () async {
              bool _islogedout = await AuthCubit.get(context).logout(context);
              if (_islogedout)
                NavigateAndFinish(context, Login());
            },
          );
        },

      )
  );
}