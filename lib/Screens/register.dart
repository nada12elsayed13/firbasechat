import 'package:firbasechat/Screens/chatpage.dart';
import 'package:firbasechat/cubit/Register_cubit/register_cubit.dart';
import 'package:firbasechat/helper/showsnakbar.dart';
import 'package:firbasechat/widgets/constes.dart';
import 'package:firbasechat/widgets/customButton.dart';
import 'package:firbasechat/widgets/customTextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  String? email;
  String? password;
  static String id = 'RegisterPage';
  GlobalKey<FormState> formKey = GlobalKey();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isloading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id);
          isloading = false;
        } else if (state is RegisterFaliure) {
          showSnakbar(context, state.errorMessage);
          isloading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                          'Register',
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
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context)
                            .registerUser(email: email!, password: password!);
                        }
                        
                      },
                      text: 'Register',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'alreagy have an account!',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            ' Login',
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
        );
      },
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;

    // ignore: unused_local_variable
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
