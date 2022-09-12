import 'package:blood_donation/app_data/app_data.dart';
import 'package:blood_donation/constant/colors.dart';
import 'package:blood_donation/constant/constant.dart';
import 'package:blood_donation/pages/my_post.dart';
import 'package:blood_donation/utils/user_pref.dart';
import 'package:blood_donation/widgets/update_profile.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    print("hello");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          profileCard(context),
          const SizedBox(
            height: 10,
          ),
          customListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const UpdateProfile())).then((value) {
                  setState(() {});
                });
                // Constant.moveToNext(context, const UpdateProfile());
              },
              title: "Update Profile",
              icon: Icons.person),
          customListTile(
              onTap: () {
                Constant.moveToNext(context, const MyPost());
              },
              title: "My Post",
              icon: Icons.list_alt),
          customListTile(onTap: () {}, title: "Share App", icon: Icons.share),
          customListTile(
              onTap: () {
                UserPreferences.logoutUser();
                Constant.moveToNextUntil(context, const LoginScreen());
              },
              title: "Logout",
              icon: Icons.logout)
        ],
      ),
    );
  }

  Widget customListTile(
      {void Function()? onTap, String? title, IconData? icon}) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ListTile(
          onTap: onTap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          horizontalTitleGap: 12.0,
          tileColor: MyColor.backgroundColor,
          leading: CircleAvatar(
              backgroundColor: const Color(0xffd7d7d7),
              radius: 25,
              child: Icon(
                icon!,
                color: Colors.white,
              )),
          title: Text(title!),
        ),
      ),
    );
  }

  Widget profileCard(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        color: MyColor.backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(10.0),
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(
                            "assets/icons/logo.png",
                          ),
                          fit: BoxFit.fill)),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customRow("Name: ", UserPreferences.getName().toString()),
                      const SizedBox(
                        height: 5,
                      ),
                      customRow(
                          "Address: ", UserPreferences.getAddress().toString()),
                      const SizedBox(
                        height: 5,
                      ),
                      customRow(
                          "Phone: ", UserPreferences.getPhone().toString()),
                      const SizedBox(
                        height: 5,
                      ),
                      customRow("Blood Group: ",
                          UserPreferences.getBloodGroup().toString()),
                      const SizedBox(
                        height: 5,
                      ),
                      customRow(
                          "Email: ", UserPreferences.getEmail().toString()),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  customRow(String title, String subtitle) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
