import 'dart:convert';

class ApiResponse {
  ApiResponse({
    required this.status,
    this.message,
    required this.body,
  });

  int status;
  String? message;
  String body;

  Map<String, dynamic> get json => jsonDecode(body);
}
