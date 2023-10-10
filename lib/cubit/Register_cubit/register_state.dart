// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFaliure extends RegisterState {
  String errorMessage;
  RegisterFaliure({
    required this.errorMessage,
  });
}
