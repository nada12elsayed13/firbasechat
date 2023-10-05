// ignore_for_file: public_member_api_docs, sort_constructors_first
class Messages {
  final String message;
  final String id;

  Messages(
    this.message,
      this.id,
  );
  factory Messages.fromjson(jsonData) {
    return Messages(jsonData['message'],jsonData['id']);
  }
}
