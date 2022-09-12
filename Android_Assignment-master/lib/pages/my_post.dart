import 'package:blood_donation/constant/constant.dart';
import 'package:blood_donation/network_services/api_provider.dart';
import 'package:blood_donation/response/blood_donor_response.dart';
import 'package:blood_donation/widgets/default_card.dart';
import 'package:blood_donation/widgets/edit_page.dart';
import 'package:flutter/material.dart';

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  final APIProvider _apiProvider = APIProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Post"),
      ),
      body: FutureBuilder(
          future: _apiProvider.getUserPost(),
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
                      ? const Center(child: Text("Empty"))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: donors.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Stack(
                                children: [
                                  DefaultCard(
                                    donors: donors.data[index],
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 18.0, top: 10.0),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            EditPage(
                                                              donors: donors
                                                                  .data[index],
                                                            ))).then((value) {
                                                  setState(() {});
                                                });
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 60,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          "Are you sure you want to delete? ",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "Cancel")),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                final response =
                                                                    await _apiProvider.deleteUserPost(
                                                                        id: donors
                                                                            .data[index]
                                                                            .id);
                                                                if (response
                                                                        .success ==
                                                                    true) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text("Success")));
                                                                  setState(
                                                                      () {});
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text("Failed")));
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              },
                                                              child: const Text(
                                                                  "Ok")),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 36, 83, 170),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            );
                          });
                }
            }
          }),
    );
  }
}
