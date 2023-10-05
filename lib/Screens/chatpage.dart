import 'package:firbasechat/models/messageModel.dart';
import 'package:firbasechat/widgets/constes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Messages> listMessage = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            listMessage.add(Messages.fromjson(snapshot.data!.docs[i]));
          }
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
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: listMessage.length,
                      itemBuilder: (context, index) { 
                        return listMessage[index].id == email ?  ChatBuble(
                          message: listMessage[index],
                        ) : ChatBubleForFriend(message: listMessage[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        'message': data,
                        'createdAt': DateTime.now(),
                        'id': email,
                      });
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
        } else {
          return Text('loading.....');
        }
      },
    );
  }
}
