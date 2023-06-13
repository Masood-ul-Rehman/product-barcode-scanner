import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopify/Provider/dataProvider.dart';
import 'package:shopify/Resources/Components/button.dart';
import 'package:shopify/Resources/Components/messages.dart';
import 'package:shopify/Screens/storePage.dart';

class UserStores extends StatefulWidget {
  const UserStores({super.key});

  @override
  State<UserStores> createState() => _UserStoresScreenState();
}

class UserStoreItem {
  final String storeName;
  String imagePath;
  VoidCallback? onPressed;

  final String themeName;

  UserStoreItem({
    required this.storeName,
    required this.imagePath,
    required this.themeName,
    this.onPressed,
  });
}

class _UserStoresScreenState extends State<UserStores> {
  List<UserStoreItem> stores = [];

  @override
  void initState() {
    super.initState();
    getStores();
  }

  void getStores() async {
    try {
      var data = Provider.of<DataProvider>(context, listen: false).data;
      var userId = data['_id'];
      var token = data['token'];

      final url = Uri.parse(
          "https://backend-production-0593.up.railway.app/api/stores/getStores/$userId");
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<UserStoreItem> fetchedStores = responseData.map((json) {
          String themeName = json['theme'].toString();
          String imagePath = '';
          if (themeName == 'minimalistic') {
            imagePath = 'assets/minimal.png';
          } else {
            imagePath = 'assets/flon.png';
          }

          return UserStoreItem(
            storeName: json['name'],
            themeName: themeName,
            imagePath: imagePath,
            onPressed: () {
              Provider.of<DataProvider>(context, listen: false)
                  .setStore(json['store_id'.toString()]);
              Provider.of<DataProvider>(context, listen: false)
                  .setStoreName(json['store_id'.toString()]);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const StorePage()));
            },
          );
        }).toList();

        setState(() {
          stores = fetchedStores;
        });
      } else {
        utils().toastmessage('Failed to get stores');
      }
    } catch (e) {
      utils().toastmessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 190, 170, 255);

    return Scaffold(
        appBar: AppBar(
          title: const Text('User stores'),
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
        ),
        body: ListView.builder(
          itemCount: stores.length,
          itemBuilder: (BuildContext context, int index) {
            UserStoreItem storeItem = stores[index];
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 15, 20),
                  child: Column(
                    children: [
                      Image.asset(storeItem.imagePath),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            "Store Name: ${storeItem.storeName}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            "Theme: ${storeItem.themeName}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: MyButton(
                            title: "EnterStore",
                            onpress: () {
                              storeItem.onPressed?.call();
                            }),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}
