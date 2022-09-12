import 'package:blood_donation/constant/constant.dart';
import 'package:blood_donation/network_services/api_provider.dart';
import 'package:blood_donation/pages/my_post.dart';
import 'package:blood_donation/response/blood_donor_response.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final Donors donors;
  const EditPage({Key? key, required this.donors}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final APIProvider _apiProvider = APIProvider();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  String? _bloodGroup;
  String? _gender;
  late TextEditingController _fullName;
  late TextEditingController _address;
  late TextEditingController _dob;
  late TextEditingController _phone;
  late TextEditingController _telNo;
  @override
  void initState() {
    print(widget.donors.id);
    _fullName = TextEditingController(text: widget.donors.fullName);
    _address = TextEditingController(text: widget.donors.address);
    _dob = TextEditingController(text: widget.donors.dob);
    _phone = TextEditingController(text: widget.donors.phone);
    _telNo = TextEditingController(text: widget.donors.telNo);
    _bloodGroup = widget.donors.bloodGroup;
    _gender = widget.donors.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: SingleChildScrollView(
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
                    controller: _phone,
                    validator: Validator.isRequired,
                    decoration: Constant.textFormFieldDecoration(
                        "Phone", "Phone", Icons.phone_android),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _telNo,
                    decoration: Constant.textFormFieldDecoration(
                        "Tel No", "Telno", Icons.phone),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Constant.authButton("Update", () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await _apiProvider.updateUserPost(
                          Donors(
                            fullName: _fullName.text,
                            address: _address.text,
                            bloodGroup: _bloodGroup!,
                            gender: _gender!,
                            dob: _dob.text,
                            phone: _phone.text,
                            telNo: _telNo.text,
                          ).toMap(),
                          id: widget.donors.id);
                      if (response.success == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Success")));
                        Navigator.of(context).pop();
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
      ),
    );
  }
}
