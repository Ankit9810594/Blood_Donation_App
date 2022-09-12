import 'package:blood_donation/network_services/api_provider.dart';
import 'package:blood_donation/response/blood_donor_response.dart';
import 'package:blood_donation/widgets/default_card.dart';
import 'package:flutter/material.dart';

class ONegative extends StatefulWidget {
  const ONegative({Key? key}) : super(key: key);

  @override
  State<ONegative> createState() => _ONegativeState();
}

class _ONegativeState extends State<ONegative> {
  final APIProvider _apiProvider = APIProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _apiProvider.getONegativeDonors(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                final DonorResponse donors = snapshot.data as DonorResponse;
                return donors.data.isEmpty
                    ? const Center(
                        child: Text("Empty"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: donors.data.length,
                        itemBuilder: (context, index) {
                          return DefaultCard(
                            donors: donors.data[index],
                          );
                        });
              }
          }
        });
  }
}
