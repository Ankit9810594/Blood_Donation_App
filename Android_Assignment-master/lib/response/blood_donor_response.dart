import 'dart:convert';

class DonorResponse {
  final bool success;
  final List<Donors> data;
  DonorResponse({
    required this.success,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory DonorResponse.fromMap(Map<String, dynamic> map) {
    return DonorResponse(
      success: map['success'] ?? false,
      data: List<Donors>.from(map['data']?.map((x) => Donors.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DonorResponse.fromJson(String source) =>
      DonorResponse.fromMap(json.decode(source));

  @override
  String toString() => 'DonorResponse(success: $success, donors: $data)';
}

class Donors {
  final bool? success;
  final String? id;
  final String fullName;
  final String address;
  final String bloodGroup;
  final String gender;
  final String dob;
  final String? image;
  final String phone;
  final String telNo;
  Donors({
    this.id,
    this.success,
    this.image,
    required this.fullName,
    required this.address,
    required this.bloodGroup,
    required this.gender,
    required this.dob,
    required this.phone,
    required this.telNo,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'address': address,
      'bloodGroup': bloodGroup,
      'gender': gender,
      'dob': dob,
      'phone': phone,
      'telNo': telNo,
    };
  }

  factory Donors.fromMap(Map<String, dynamic> map) {
    return Donors(
      id: map['_id'] ?? '',
      success: map['success'] ?? false,
      fullName: map['fullName'] ?? '',
      address: map['address'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      gender: map['gender'] ?? '',
      dob: map['dob'] ?? '',
      image: map['image'] ?? '',
      phone: map['phone'] ?? '',
      telNo: map['telNo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Donors.fromJson(String source) => Donors.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Donors(id:$id,fullName: $fullName, address: $address, bloodGroup: $bloodGroup, gender: $gender, dob: $dob, phone: $phone, telNo: $telNo)';
  }
}
