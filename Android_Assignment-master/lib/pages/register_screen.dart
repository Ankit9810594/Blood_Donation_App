import 'package:blood_donation/constant/colors.dart';
import 'package:blood_donation/constant/constant.dart';
import 'package:blood_donation/network_services/api_provider.dart';
import 'package:blood_donation/pages/home_screen.dart';
import 'package:blood_donation/response/auth_response.dart';
import 'package:blood_donation/utils/user_pref.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final APIProvider _apiProvider = APIProvider();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  bool isChecked = false;
  String? _bloodGroup;
  String? _gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/icons/logo.png",
                      height: 170,
                    ),
                  ),
                  TextFormField(
                      controller: _fullName,
                      validator: Validator.isRequired,
                      decoration: Constant.textFormFieldDecoration(
                          "FullName", "FullName", Icons.person)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      validator: Validator.validEmail,
                      decoration: Constant.textFormFieldDecoration(
                          "Email", "Email", Icons.email)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      obscureText: true,
                      controller: _password,
                      validator: Validator.validPassword,
                      decoration: Constant.textFormFieldDecoration(
                          "Password", "Password", Icons.lock)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: _address,
                      validator: Validator.isRequired,
                      decoration: Constant.textFormFieldDecoration(
                          "Address", "Address", Icons.location_on)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: Constant.dropDownDecoration(),
                        hint: const Text(
                          "Blood Group",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: const TextStyle(color: Colors.black),
                        items: <String>[
                          'A+',
                          'O+',
                          'B+',
                          'AB+',
                          'A-',
                          'O-',
                          'B-',
                          'AB-',
                        ].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _bloodGroup = val.toString();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: Constant.dropDownDecoration(),
                        hint: const Text(
                          "Gender",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: const TextStyle(color: Colors.black),
                        items: <String>['Male', 'Female', "Others"].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _gender = val.toString();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phone,
                    validator: Validator.validNumber,
                    decoration: Constant.textFormFieldDecoration(
                        "Phone", "Phone", Icons.phone_android),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          }),
                      const Text(
                        "Accept Terms and Conditions",
                        style: TextStyle(
                            color: Color.fromARGB(255, 36, 83, 170),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Constant.authButton(
                      "Register",
                      !isChecked
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                final response =
                                    await _apiProvider.performRegister(User(
                                            fullName: _fullName.text,
                                            email: _email.text,
                                            password: _password.text,
                                            bloodGroup: _bloodGroup,
                                            address: _address.text,
                                            gender: _gender,
                                            phone: _phone.text)
                                        .toMap());
                                if (response.success == true) {
                                  await UserPreferences.setToken(
                                      response.token);
                                  await UserPreferences.setName(
                                      response.user.fullName);
                                  await UserPreferences.setEmail(
                                      response.user.email);
                                  await UserPreferences.setGender(
                                      response.user.gender);
                                  await UserPreferences.setUserId(
                                      response.user.id);
                                  await UserPreferences.setBloodGroup(
                                      response.user.bloodGroup);
                                  await UserPreferences.setAddress(
                                      response.user.address);
                                  await UserPreferences.setPhone(
                                      response.user.phone);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Success")));
                                  Constant.moveToNextUntil(
                                      context, const HomeScreen());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Failed")));
                                }
                              }
                            }),
                  const SizedBox(
                    height: 10,
                  ),
                  Constant.customRow(() {
                    Constant.moveToNext(context, const LoginScreen());
                  }, "Already have an account? ", "Login"),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
