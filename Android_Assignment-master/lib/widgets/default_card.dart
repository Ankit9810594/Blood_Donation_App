import 'package:blood_donation/constant/constant.dart';
import 'package:blood_donation/response/blood_donor_response.dart';
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  final Donors donors;
  const DefaultCard({Key? key, required this.donors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Card(
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                        height: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage("assets/icons/logo.png"),
                            image: NetworkImage(
                              Constant.imageUrl + donors.image.toString(),
                            ),
                          ),
                        ))),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          customRow("Donor Name: ", donors.fullName),
                          const SizedBox(
                            height: 5,
                          ),
                          customRow("Address: ", donors.address),
                          const SizedBox(
                            height: 5,
                          ),
                          customRow("Gender: ", donors.gender),
                          const SizedBox(
                            height: 5,
                          ),
                          customRow("DOB: ", donors.dob),
                          const SizedBox(
                            height: 5,
                          ),
                          customRow("Phone No:", donors.phone)
                        ],
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  Widget customRow(String title, String subtitle) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
