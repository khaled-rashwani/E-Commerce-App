import 'dart:io';

import 'package:EZ_Shop/shared/helperFunctions.dart';
import 'package:EZ_Shop/ui/User/Auth/login.dart';
import 'package:EZ_Shop/ui/User/Home/home.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/AuthCubit/cubit.dart';
import '../../../cubit/AuthCubit/states.dart';
import '../../../shared/components.dart';
import '../../../shared/themes.dart';

class Register extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var imageController;
  var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            'images/logo_white.png',
                            height: 230,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          const Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              '  Register',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              '  Register now and browse our new products!',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                              onTap: () {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Full name should not be empty';
                                }
                                return null;
                              },
                              myController: nameController,
                              hint: 'Full Name',
                              prefixIcon: Icon(Icons.perm_identity),
                              keyboardType: TextInputType.name),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultTextFormField(
                              onTap: () {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email should not be empty';
                                }
                                return null;
                              },
                              myController: emailController,
                              hint: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              keyboardType: TextInputType.emailAddress),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultTextFormField(
                              onTap: () {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Address should not be empty';
                                }
                                return null;
                              },
                              myController: addressController,
                              hint: 'Address',
                              prefixIcon: Icon(Icons.location_on_outlined),
                              keyboardType: TextInputType.emailAddress),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultTextFormField(
                            keyboardType: TextInputType.phone,
                            onTap: () {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number should not be empty';
                              }
                              print(phoneController);
                              return null;
                            },
                            myController: phoneController,
                            hint: 'Phone number',
                            prefixIcon: const Icon(Icons.phone),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultTextFormField(
                              onTap: () {},
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password should not be empty';
                                }
                                return null;
                              },
                              myController: passwordController,
                              hint: 'Password',
                              isPassword: AuthCubit.get(context).isPassword,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () => AuthCubit.get(context)
                                    .changePasswordVisibility(),
                                icon: AuthCubit.get(context).suffix,
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(180)),
                                      color: const Color.fromRGBO(
                                          217, 217, 217, 0.2),
                                      border: Border.all(
                                          color: Colors.grey.shade500,
                                          width: 1.5)),
                                  child: ConditionalBuilder(
                                    condition: imageController != null ,
                                    builder: (context) => Image.file(
                                      AuthCubit.get(context).image,
                                      fit: BoxFit.cover,
                                    ),
                                    fallback: (context) => Icon(
                                      Icons.person,
                                      size: 70,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    imageController= AuthCubit.get(context).pickImage();
                                    // imageController = AuthCubit.get(context).image;
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultButton(
                              text: 'Register',
                              width: double.infinity,
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  print(emailController.text);
                                  print(passwordController.text);
                                  AuthCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    image: AuthCubit.get(context).image,
                                    phone: phoneController.text,
                                    name: nameController.text,
                                    address: addressController.text,
                                    context: context,
                                  );
                                  // NavigateTo(context, Home());
                                }
                              },
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(child: Text('or')),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: myDarkGreen,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/google.png',
                                  height: 30,
                                ),
                                Text(
                                  'Register with your Google Account    ',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' You already have an account?',
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  NavigateTo(context, Login());
                                },
                                child: Text('Login Now',
                                    style: TextStyle(
                                        color: myDarkGreen,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
