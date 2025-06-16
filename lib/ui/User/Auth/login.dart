import 'package:EZ_Shop/shared/helperFunctions.dart';
import 'package:EZ_Shop/ui/User/Auth/register.dart';
import 'package:EZ_Shop/ui/User/Home/home.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/AuthCubit/cubit.dart';
import '../../../cubit/AuthCubit/states.dart';
import '../../../shared/components.dart';
import '../../../shared/themes.dart';

class Login extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                              '  Login',
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
                              '  login now and browse our new products!',
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
                          MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot your password?',textAlign:TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.w300,),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultButton(
                              text: 'Login',
                              width: double.infinity,
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  print(emailController.text);
                                  print(passwordController.text);
                                  AuthCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context);
                                  //  NavigateTo(context, Home());
                                }
                              },
                            ),
                            fallback: (context) =>
                                Center(child: buildLoadingWidget()),
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
                                  'Login with your Google Account    ',
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
                                ' Don\'t have an account?',
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  NavigateTo(context, Register());
                                },
                                child: Text('Register Now',
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
