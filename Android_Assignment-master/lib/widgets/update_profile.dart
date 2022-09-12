import 'package:blood_donation/constant/constant.dart';
import 'package:blood_donation/network_services/api_provider.dart';
import 'package:blood_donation/pages/bnb_pages/profilepage.dart';
import 'package:blood_donation/pages/my_post.dart';
import 'package:blood_donation/utils/user_pref.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final APIProvider _apiProvider = APIProvider();
  late TextEditingController _fullName;
  late TextEditingController _address;
  late TextEditingController _phone;
  @override
  void initState() {
    _fullName = TextEditingController(text: UserPreferences.getName());
    _address = TextEditingController(text: UserPreferences.getAddress());
    _phone = TextEditingController(text: UserPreferences.getPhone());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _fullName,
              keyboardType: TextInputType.text,
              validator: Validator.validNumber,
              decoration: Constant.textFormFieldDecoration(
                  "FullName", "fullname", Icons.person),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _address,
              keyboardType: TextInputType.text,
              validator: Validator.validNumber,
              decoration: Constant.textFormFieldDecoration(
                  "Address", "address", Icons.location_on),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.number,
              validator: Validator.validNumber,
              decoration: Constant.textFormFieldDecoration(
                  "Phone", "Phone", Icons.phone_android),
            ),
            const SizedBox(
              height: 10,
            ),
            Constant.authButton("Update", () async {
              final response = await _apiProvider.updateUser({
                "fullName": _fullName.text,
                "address": _address.text,
                "phone": _phone.text,
              });
              if (response.success == true) {
                await UserPreferences.setName(response.user.fullName);
                await UserPreferences.setAddress(response.user.address);
                await UserPreferences.setPhone(response.user.phone);
                setState(() {});
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Success")));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Failed")));
              }
            }),
          ],
        ),
      ),
    );
  }
}
