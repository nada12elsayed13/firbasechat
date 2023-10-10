// ignore_for_file: unused_local_variable

import 'package:firbasechat/Screens/chatpage.dart';
import 'package:firbasechat/Screens/register.dart';
import 'package:firbasechat/cubit/Chat_cubit/chat_cubit.dart';
import 'package:firbasechat/cubit/login_cubit/login_cubit.dart';
import 'package:firbasechat/widgets/constes.dart';
import 'package:firbasechat/widgets/customButton.dart';
import 'package:firbasechat/widgets/customTextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/showsnakbar.dart';

class LoginPage extends StatelessWidget {
  String? email;
  String? password;
  static String id = 'Login Page';
  bool isloading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isloading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id);
          isloading = false;
        } else if (state is LoginFailure) {
          showSnakbar(context, state.errorMessage);
          isloading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'Pacifico'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Row(
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    onchanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    obsure: true,
                    onchanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context)
                            .loginUser(email: email!, password: password!);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          ' Register',
                          style: TextStyle(color: Color(0XFFC7EDE6)),
                        ),
                      )
                    ],
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
