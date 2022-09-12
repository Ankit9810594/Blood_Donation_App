import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future? setName(String? name) async =>
      await _preferences!.setString(KeyName.fullName, name!);
  static String? getName() => _preferences!.getString(KeyName.fullName);

  static Future? setAddress(String? name) async =>
      await _preferences!.setString(KeyName.address, name!);
  static String? getAddress() => _preferences!.getString(KeyName.address);

  static Future? setGender(String? name) async =>
      await _preferences!.setString(KeyName.gender, name!);
  static String? getGender() => _preferences!.getString(KeyName.gender);

  static Future? setBloodGroup(String? name) async =>
      await _preferences!.setString(KeyName.bloodGroup, name!);
  static String? getBloodGroup() => _preferences!.getString(KeyName.bloodGroup);

  static Future? setPhone(String? name) async =>
      await _preferences!.setString(KeyName.phone, name!);
  static String? getPhone() => _preferences!.getString(KeyName.phone);

  static Future? setToken(String? name) async =>
      await _preferences!.setString(KeyName.token, name!);
  static String? getToken() => _preferences!.getString(KeyName.token);

  static Future? setEmail(String? name) async =>
      await _preferences!.setString(KeyName.email, name!);
  static String? getEmail() => _preferences!.getString(KeyName.email);
  static Future? setUserId(String? name) async =>
      await _preferences!.setString(KeyName.userId, name!);
  static String? getUserId() => _preferences!.getString(KeyName.userId);
  static logoutUser() {
    _preferences!.remove(KeyName.userId);
    _preferences!.remove(KeyName.fullName);
    _preferences!.remove(KeyName.token);
    _preferences!.remove(KeyName.gender);
    _preferences!.remove(KeyName.bloodGroup);
    _preferences!.remove(KeyName.phone);
    _preferences!.remove(KeyName.address);
    _preferences!.remove(KeyName.email);
  }
}

class KeyName {
  static String userId = "userId";
  static String token = "token";
  static String fullName = "fullName";
  static String email = "email";
  static String gender = "gender";
  static String bloodGroup = "bloodGroup";
  static String phone = "phone";
  static String address = "address";
}
