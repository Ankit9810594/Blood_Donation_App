import 'dart:convert';

class SuccessResponse {
  final bool? success;
  SuccessResponse({
    this.success,
  });

  factory SuccessResponse.fromMap(Map<String, dynamic> map) {
    return SuccessResponse(
      success: map['success'] ?? false,
    );
  }

  factory SuccessResponse.fromJson(String source) =>
      SuccessResponse.fromMap(json.decode(source));

  @override
  String toString() => 'SuccessResponse(success: $success)';
}
