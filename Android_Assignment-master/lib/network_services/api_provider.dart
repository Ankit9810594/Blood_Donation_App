import 'dart:io';
import 'package:blood_donation/response/auth_response.dart';
import 'package:blood_donation/response/blood_donor_response.dart';
import 'package:blood_donation/response/success_response.dart';
import 'package:blood_donation/utils/user_pref.dart';
import 'package:http/http.dart' as http;

class APIProvider {
  String baseUrl = "http://10.0.2.2:3000/api/v1";

  Future<DonorResponse> getAPositiveDonors() async {
    var headers = {"Content-Type": 'application/json'};
    var url = Uri.parse(baseUrl + "/donor/aPositive");
    try {
      http.Response response = await http.get(url, headers: headers);
      return DonorResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<DonorResponse> getOPositiveDonors() async {
    var headers = {"Content-Type": 'application/json'};
    var url = Uri.parse(baseUrl + "/donor/oPositive");
    try {
      http.Response response = await http.get(url, headers: headers);
      return DonorResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<DonorResponse> getBPositiveDonors() async {
    var headers = {"Content-Type": 'application/json'};
    var url = Uri.parse(baseUrl + "/donor/bPositive");
    try {
      http.Response response = await http.get(url, headers: headers);
      return DonorResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<DonorResponse> getABPositiveDonors() async {
    var headers = {"Content-Type": 'application/json'};
    var url = Uri.parse(baseUrl + "/donor/abPositive");
    try {
      http.Response response = await http.get(url, headers: headers);
      return DonorResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<DonorResponse> getANegativeDonors() async {
    var headers = {"Content-Type": 'application/json'};
    var url = Uri.parse(baseUrl + "/donor/aNegative");
    try {
      http.Response response = await http.get(url, headers: headers);
      return DonorResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<DonorResponse> getONegativeDonors() async {
    var headers = {"Content-Type": 'application/json'};
    var url = Uri.parse(baseUrl + "/donor/oNegative");
    try {
      http.Response response = await http.get(url, headers: headers);
      return DonorResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<DonorResponse> getBNegativeDonors() async {
    var headers = {"Content-Type": 'application/json'};
    var url = Uri.parse(baseUrl + "/donor/bNegative");
    try {
      http.Response response = await http.get(url, headers: headers);
      return DonorResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<DonorResponse> getABNegativeDonors() async {
    var headers = {"Content-Type": 'application/json'};
    var url = Uri.parse(baseUrl + "/donor/abNegative");
    try {
      http.Response response = await http.get(url, headers: headers);
      return DonorResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<Donors> donateBlood(
      {String? fullName,
      String? address,
      String? gender,
      String? bloodGroup,
      String? dob,
      String? phone,
      String? telNo,
      image}) async {
    var url = Uri.parse(baseUrl + "/donor/post");
    var headers = {
      "authorization": "Bearer ${UserPreferences.getToken().toString()}"
    };
    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['fullName'] = fullName!;
      request.fields['address'] = address!;
      request.fields['bloodGroup'] = bloodGroup!;
      request.fields['gender'] = gender!;
      request.fields['dob'] = dob!;
      request.fields['phone'] = phone!;
      request.fields['telNo'] = telNo!;
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath("image", image));
      var response = await request.send();
      var jsonResponse = await http.Response.fromStream(response);

      return Donors.fromJson(jsonResponse.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<AuthResponse> performLogin(jsonBody) async {
    var url = Uri.parse(baseUrl + "/user/login");
    try {
      http.Response response = await http.post(url, body: jsonBody);
      return AuthResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<AuthResponse> performRegister(jsonBody) async {
    var url = Uri.parse(baseUrl + "/user/register");
    try {
      http.Response response = await http.post(url, body: jsonBody);
      return AuthResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<DonorResponse> getUserPost() async {
    var url = Uri.parse(baseUrl + "/donor/user/post");
    var headers = {"authorization": "Bearer ${UserPreferences.getToken()}"};

    try {
      http.Response response = await http.get(url, headers: headers);
      return DonorResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<SuccessResponse> updateUserPost(jsonBody, {String? id}) async {
    var url = Uri.parse(baseUrl + "/donor/update/$id");

    try {
      http.Response response = await http.put(url, body: jsonBody);
      return SuccessResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<AuthResponse> updateUser(
    jsonBody,
  ) async {
    var url = Uri.parse(baseUrl + "/user/update");
    var headers = {"authorization": "Bearer ${UserPreferences.getToken()}"};
    try {
      http.Response response =
          await http.put(url, headers: headers, body: jsonBody);
      return AuthResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }

  Future<SuccessResponse> deleteUserPost({String? id}) async {
    var url = Uri.parse(baseUrl + "/donor/delete/$id");

    try {
      http.Response response = await http.delete(
        url,
      );

      return SuccessResponse.fromJson(response.body);
    } on SocketException catch (_) {
      throw const SocketException("No internet connection");
    } on FormatException catch (_) {
      throw const FormatException("Invalid Data");
    }
  }
}
