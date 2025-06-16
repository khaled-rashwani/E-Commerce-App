import 'dart:io';

import 'package:EZ_Shop/cubit/AuthCubit/states.dart';
import 'package:EZ_Shop/shared/network/dio.dart';
import 'package:EZ_Shop/shared/sharedPreferences.dart';
import 'package:EZ_Shop/ui/User/Home/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../models/LoginModel.dart';
import '../../shared/helperFunctions.dart';
import '../../ui/User/Auth/login.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModelUser;

  void userLogin({required email, required password, context}) {
    emit(LoginLoadingState());
    dioHelper.postData(
      url: 'api/user/login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // print(value.data.toString());
      if (value.statusCode == 200) {
        if (value.data["status"] == 1) {
          CacheHelper.saveData(key: 'token', value: value.data["token"]);
          TOKEN=value.data["token"];

          CacheHelper.saveData(
              key: 'user_name', value: value.data['data']["user_name"]);
          CacheHelper.saveData(
              key: 'email', value: value.data['data']["email"]);
          CacheHelper.saveData(
              key: 'address', value: value.data['data']["address"]);
          CacheHelper.saveData(
              key: 'phone_number', value: value.data['data']["phone_number"]);
          CacheHelper.saveData(
              key: 'profile_img_url',
              value: baseUrl + value.data['data']["profile_img_url"]);
          loginModelUser = LoginModel.fromJson(value.data);
          emit(LoginSuccessState());
          print('success login');
          print('TOKEN:  ' + CacheHelper.getToken().toString());
          NavigateAndFinish(context, Home());
        } else {
          toast(value.data["message"]);
          emit(LoginErrorState());
        }
      } else if (value.data["status"] == 0) {
        emit(LoginErrorState());
        print(value.data["message"]);
        toast(value.data["message"]);
      } else if (value.statusCode == 422) {
        emit(LoginErrorState());
        toast(value.data["message"]);
      } else if (value.statusCode! >= 500) {
        emit(LoginErrorState());
        toast(value.data["message"]);
      } else {
        emit(LoginErrorState());
      }
    }).catchError((error) {
      emit(LoginErrorState());
      print(error.toString());
      toast('Something went wrong!Please try again later');
    });
  }

  Icon suffix = Icon(Icons.visibility_off_outlined);
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix = isPassword
        ? Icon(Icons.visibility_off_outlined)
        : Icon(Icons.visibility);
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> userRegister(
      {required name,
      required email,
      required password,
      required phone,
      required image,
      required address,
      context}) async {
    var data = FormData.fromMap({
      'user_name': name,
      'email': email,
      'phone_number': phone,
      "address": address,
      'profile_img_url': await MultipartFile.fromFile(
        image.path,
        filename: image.toString(),
      ),
      'password': password,
      'password_confirmation': password,
    });
    emit(RegisterLoadingState());
    dioHelper.postData(url: 'api/user/register', data: data).then((value) {
      if (value.statusCode == 200) {
        CacheHelper.saveData(key: 'token', value: value.data["token"]);
        TOKEN=value.data["token"];
        CacheHelper.saveData(
            key: 'user_name', value: value.data['data']["user_name"]);
        CacheHelper.saveData(key: 'email', value: value.data['data']["email"]);
        CacheHelper.saveData(
            key: 'address', value: value.data['data']["address"]);
        CacheHelper.saveData(
            key: 'phone_number', value: value.data['data']["phone_number"]);
        CacheHelper.saveData(
            key: 'profile_img_url',
            value: baseUrl + value.data['data']["profile_img_url"]);
        NavigateAndFinish(context, Home());
        print('success register');
        print('TOKEN:  ' + CacheHelper.getToken().toString());
        emit(RegisterSuccessState());
      } else if (value.statusCode == 422) {
        toast(value.data.toString());
        emit(RegisterErrorState());
      }
    }).catchError((e) {
      print(e);
      toast('something went wrong!please try again');
      emit(RegisterErrorState());
    });
  }

  var image = File('');

  Future pickImage() async {
    emit(ProfileImageSelectedLoadingState());
    final pickedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      image = File(pickedfile.path);
      print(
          '--------------------------------------------------------------------');
      print(image.path);
      print(
          '--------------------------------------------------------------------');
      emit(ProfileImageSelectedSuccessState());
      toast('image added successfully');
    } else {
      if (image != null) {
        emit(ProfileImageSelectedSuccessState());
      } else {
        emit(ProfileImageSelectedErrorState());
        print('no image selected');
        toast('something went wrong!');
      }
    }
    return image;
  }

   logout(context) {
    emit(LoginLoadingState());
    dioHelper
        .postData(
      url: 'api/user/logout',
    )
        .then((value) {
          CacheHelper.saveData(key: 'token', value: '');
          CacheHelper.saveData(key: 'user_name', value: '');
          CacheHelper.saveData(key: 'phone_number', value: '');
          CacheHelper.saveData(
              key: 'profile_img_url', value: 'images/default_user2.png');
          emit(LogoutSuccessState());
          print('success logout');
          print('TOKEN:  ' + CacheHelper.getToken().toString());
          NavigateAndFinish(context, Login());
    }).catchError((error) {
      emit(LogoutErrorState());
      print(error.toString());
      toast('Something went wrong!Please try again later');
    });
  }
}
