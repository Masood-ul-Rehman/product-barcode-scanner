import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/Provider/dataProvider.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  dynamic storeTitle;
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    storeTitle = Provider.of<DataProvider>(context, listen: false).storeName;
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 190, 170, 255);
    var storeName = Provider.of<DataProvider>(context, listen: false).storeName;
    print(storeTitle);
    return Scaffold(
      appBar: AppBar(
        title: Text(storeTitle ?? 'Store'),
        backgroundColor: primaryColor,
      ),
      body: Column(children: [Text(storeName ?? 'Title')]),
    );
  }
}
