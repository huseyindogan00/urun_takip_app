// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResultMessageModel {
  bool isSuccessful;
  String? message;
  Exception? error;
  ResultMessageModel({
    required this.isSuccessful,
    this.message,
    this.error,
  });
}
