import 'package:firbasechat/Screens/chatpage.dart';
import 'package:firbasechat/Screens/login.dart';
import 'package:firbasechat/Screens/register.dart';
import 'package:firbasechat/cubit/Chat_cubit/chat_cubit.dart';
import 'package:firbasechat/cubit/Register_cubit/register_cubit.dart';
import 'package:firbasechat/cubit/login_cubit/login_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          RegisterPage.id: (context) => RegisterPage(),
          LoginPage.id: (context) => LoginPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
      ),
    );
  }
}
