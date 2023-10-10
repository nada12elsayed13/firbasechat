import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbasechat/models/messageModel.dart';
import 'package:firbasechat/widgets/constes.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMesaage);

  void sendMessage({required String message, required String email}) {
    messages.add({
      'message': message,
      'createdAt': DateTime.now(),
      'id': email,
    });
  }

  void getMessage() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<Messages> listMessage = [];
      for (var doc in event.docs) {
        listMessage.add(Messages.fromjson(doc));
      }
      emit(ChatSucess(listMessag: listMessage));
    });
  }
}
