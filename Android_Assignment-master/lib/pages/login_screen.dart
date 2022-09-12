import 'package:blood_donation/constant/constant.dart';
import 'package:blood_donation/network_services/api_provider.dart';
import 'package:blood_donation/pages/home_screen.dart';
import 'package:blood_donation/pages/register_screen.dart';
import 'package:blood_donation/response/auth_response.dart';
import 'package:blood_donation/utils/user_pref.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final APIProvider _apiProvider = APIProvider();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                  const SizedBox(
                    height: 150,
                    
                  ),
                  Center(child: Image.asset("assets/icons/logo.png")),
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
                        "password", "Password", Icons.lock),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Constant.authButton("Login", () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await _apiProvider.performLogin(
                          User(email: _email.text, password: _password.text)
                              .toLoginMap());
                      if (response.success == true) {
                        await UserPreferences.setToken(response.token);
                        await UserPreferences.setName(response.user.fullName);
                        await UserPreferences.setEmail(response.user.email);
                        await UserPreferences.setUserId(response.user.id);
                        await UserPreferences.setGender(response.user.gender);
                        await UserPreferences.setBloodGroup(
                            response.user.bloodGroup);
                        await UserPreferences.setAddress(response.user.address);
                        await UserPreferences.setPhone(response.user.phone);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Success")));
                        Constant.moveToNextUntil(context, const HomeScreen());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Failed")));
                      }
                    }
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Constant.customRow(() {
                    Constant.moveToNext(context, const RegisterScreen());
                  }, "Don't have an account? ", "Register")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
