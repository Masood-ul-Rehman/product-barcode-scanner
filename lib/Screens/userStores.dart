import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopify/Provider/dataProvider.dart';
import 'package:shopify/Resources/Components/messages.dart';

class UserStores extends StatefulWidget {
  const UserStores({super.key});

  @override
  State<UserStores> createState() => _UserStoresScreenState();
}

class UserStoreItem {
  final String name;

  UserStoreItem({required this.name});
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
          return UserStoreItem(name: json['name']);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('User stores'),
      ),
      body: ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stores[index].name),
            // Display other store information as needed
          );
        },
      ),
    );
  }
}
