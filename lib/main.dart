import 'package:EZ_Shop/shared/blocObserver.dart';
import 'package:EZ_Shop/shared/logging_service.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:EZ_Shop/shared/sharedPreferences.dart';
import 'package:EZ_Shop/shared/themes.dart';
import 'package:EZ_Shop/ui/User/Auth/login.dart';
import 'package:EZ_Shop/ui/User/Auth/register.dart';
import 'package:EZ_Shop/ui/User/Home/home.dart';
import 'package:EZ_Shop/ui/User/Home/subcategories.dart';
import 'package:EZ_Shop/ui/User/ProductDetails.dart';
import 'package:EZ_Shop/ui/onBoarding.dart';
import 'package:EZ_Shop/ui/rating.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/AppCubit/cubit.dart';
import 'cubit/AppCubit/states.dart';
import 'cubit/AuthCubit/cubit.dart';
import 'cubit/homeCubit/cubit.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await dioHelper.init();
  Widget start = OnBoardingScreen();
 // CacheHelper.saveData(key: 'token', value: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDMxZjRhM2FmZTk4ODViNWJhZGJkMjI0MjQ4MjBiYjg2MTNkMDI0MzVkODgyM2JhMjQ4NWQ0YjU5ODkxOTcwYzFkMDEzNTFlMTE0ZDJlNDciLCJpYXQiOjE2OTIwODg3NjUuMzY3Nzc3LCJuYmYiOjE2OTIwODg3NjUuMzY3NzgxLCJleHAiOjE3MjM3MTExNjUuMjM3NzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbInVzZXIiXX0.QblsM2PEU8eP4pzhpCnZEsmOWs4QbF4hxGbO6F2ZnYq3KxmgJqomL5cUzXqcgYPsV-uaOxWcb6qEcmHSSZ8SAO7w8BdymSu15dE4EDJATmgqnNSGtN2OpGIHcD6kF83-3O8qGB1MTGE3zhYRN4rg99cdlXZzgKmG8eZX1wUrzCMwX0lyEaa5qyFBYKgQacQEkFp-VHfzPz0j-oB2AEc9XHZpM6H4YhuNqh-4Jrbou1DlTtYcExe7dx49OQDZvgDo__5PrH-9zcIw14hdbjlJ9OATVkBfLo-XVVRrwr6azPI1_o-u7DB11Ef5XjdsnwHxEr7E5Rr2WxmNOvcmCuFHPd958TkgMHDY1uWJEOMWJMk-yukO_N9-nxWpPIyRTfXkCD9xH38Ir_V3fyKBtKZV51CJUDueF5UAv767SMFI5VirZzIgI6kjPl7OktnwfzQwNvdIxzJL73nniNQMEzWIAmN7anM3K65pj67qooZcWc99n0jGrUNJI94RCLN3ZS6AXGRq3eUrJ00zysmpX8wMuGiiD7O4ZDQtwHOzBbyCVRqoJPltVpRM6-0WkbbQFf5UfY7b831So46T6Em6aex8P6EO0v7DNE3FhmP42XYtjkelDI4rJxV93pjnTfLiIEjIfTif-6JwoCO-KqC_7cG-BKfWnbbKWg_h3IJDzUBFqBQ');
  TOKEN = await CacheHelper.getToken();
   var IsOnBoardingShowed = CacheHelper.getIntData(key: 'isOnBoardingShowed')??0;
  print('this is on boarding $IsOnBoardingShowed');
  print('this is token in main: -$TOKEN-');
 print(CacheHelper.getData(key: 'isOnBoardingShowed'));
  if (IsOnBoardingShowed==1) {
    if (TOKEN.length>2) {
      start = Home();
    } else {
      start = Login();
    }
  } else {
    start = OnBoardingScreen();
  }
  if (TOKEN.length>2) {
    start = Home();
  }
  runApp(MyApp(start));
}

class MyApp extends StatelessWidget {
  Widget start;

  MyApp(this.start);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(create: (context) => HomeCubit()),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'EZ Shop',
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            theme: lightMode,
            darkTheme: darkMode,
            home: start,
          ),
        ));
  }
}
