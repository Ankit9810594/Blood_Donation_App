import 'dart:convert';

class AuthResponse {
  final bool success;
  final User user;
  final String token;
  AuthResponse({
    required this.success,
    required this.user,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'user': user.toMap(),
      'token': token,
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      success: map['success'] ?? false,
      user: map["user"] == null ? User() : User.fromMap(map['user']),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));
}

class User {
  String? id;
  String? fullName;
  String? email;
  String? password;
  String? bloodGroup;
  String? address;
  String? gender;
  String? phone;
  User({
    this.id,
    this.password,
    this.fullName,
    this.email,
    this.bloodGroup,
    this.address,
    this.gender,
    this.phone,
  });

  Map<String, dynamic> toLoginMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'fullName': fullName,
      'email': email,
      'bloodGroup': bloodGroup,
      'address': address,
      'gender': gender,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      address: map['address'] ?? '',
      gender: map['gender'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
