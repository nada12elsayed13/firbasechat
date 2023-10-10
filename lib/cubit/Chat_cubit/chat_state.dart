// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSucess extends ChatState {
  List<Messages> listMessag;
  ChatSucess({
    required this.listMessag,
  });
}
