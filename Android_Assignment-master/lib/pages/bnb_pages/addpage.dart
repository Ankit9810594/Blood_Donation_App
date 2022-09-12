import 'dart:io';

import 'package:blood_donation/constant/colors.dart';
import 'package:blood_donation/constant/constant.dart';
import 'package:blood_donation/network_services/api_provider.dart';
import 'package:blood_donation/response/blood_donor_response.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final APIProvider _apiProvider = APIProvider();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  String? _bloodGroup;
  String? _gender;
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _telNo = TextEditingController();
  File? _image;
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
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
                    keyboardType: TextInputType.datetime,
                    controller: _dob,
                    validator: Validator.isRequired,
                    decoration: Constant.textFormFieldDecoration(
                        "DOB", "dob", Icons.person)),
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
                  validator: Validator.isRequired,
                  decoration: Constant.textFormFieldDecoration(
                      "Phone", "Phone", Icons.phone_android),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _telNo,
                  decoration: Constant.textFormFieldDecoration(
                      "Tel No", "Telno", Icons.phone),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: MyColor.backgroundColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _image != null
                            ? Image.file(_image!, fit: BoxFit.cover)
                            : const Text('Please select an image'),
                        Container(
                          height: 55,
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: TextButton(
                              onPressed: _openImagePicker,
                              child: const Text(
                                "Choose Image",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Constant.authButton("Donate", () async {
                  if (_formKey.currentState!.validate()) {
                    final response = await _apiProvider.donateBlood(
                        fullName: _fullName.text,
                        address: _address.text,
                        bloodGroup: _bloodGroup!,
                        gender: _gender!,
                        dob: _dob.text,
                        phone: _phone.text,
                        telNo: _telNo.text,
                        image: _image!.path);
                    if (response.success == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Success")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Failed")));
                    }
                  }
                }),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
