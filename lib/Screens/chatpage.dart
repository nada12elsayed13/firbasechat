import 'package:firbasechat/cubit/Chat_cubit/chat_cubit.dart';
import 'package:firbasechat/models/messageModel.dart';
import 'package:firbasechat/widgets/constes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = 'Chat Page';
  final _controller = ScrollController();

  ChatPage({super.key});

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMesaage);

  TextEditingController controller = TextEditingController();
  List<Messages> listMessage = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            Text('Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var listMessage =
                    BlocProvider.of<ChatCubit>(context).listMessage;
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: listMessage.length,
                    itemBuilder: (context, index) {
                      return listMessage[index].id == email
                          ? ChatBuble(
                              message: listMessage[index],
                            )
                          : ChatBubleForFriend(message: listMessage[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
                controller.clear();
                _controller.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                  hintText: 'Send Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  suffixIcon: Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
