// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopify/Network/ApiService.dart';
import 'package:shopify/Provider/dataProvider.dart';
import 'package:shopify/Resources/Components/messages.dart';
import 'package:shopify/Resources/Components/textfield.dart';
import 'package:provider/provider.dart';
import 'package:shopify/Screens/userStores.dart';

import '../Resources/Components/button.dart';
//mport 'package:shopify/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final emailfocusnode = FocusNode();
  final passwordcontroller = TextEditingController();
  final passwordfocusnode = FocusNode();

  final GlobalKey<FormState> _formKeySignUp = GlobalKey<FormState>();
  void login(String email, String password) async {
    try {
      Response response = await post(Uri.parse(Appurl.loginapis), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print(data);

        Provider.of<DataProvider>(context, listen: false).setData(data);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserStores()));
      } else {
        utils().toastmessage('Login Failed');
      }
    } catch (e) {
      utils().toastmessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Screen',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKeySignUp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .10),
              child: InputTextFormField(
                myController: emailcontroller,
                focusNode: emailfocusnode,
                onfieldSubmittedvalue: (value) {},
                onValidator: (value) {
                  return value.isEmpty ? 'Enter Email' : null;
                },
                keyboardtype: TextInputType.emailAddress,
                hint: 'Email',
                obsecuretext: false,
                enable: false,
                prefixicon: Icon(
                  Icons.email,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .040,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .10),
              child: InputTextFormField(
                myController: passwordcontroller,
                focusNode: passwordfocusnode,
                onfieldSubmittedvalue: (value) {},
                onValidator: (value) {
                  return value.isEmpty ? 'Enter password' : null;
                },
                keyboardtype: TextInputType.visiblePassword,
                hint: 'password',
                obsecuretext: true,
                prefixicon: Icon(
                  Icons.lock,
                  color: Colors.grey.shade500,
                ),
                //enable: false,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .040,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .10),
              child: MyButton(
                onpress: () {
                  if (_formKeySignUp.currentState!.validate()) {
                    login(emailcontroller.text.toString(),
                        passwordcontroller.text.toString());
                  } else {
                    utils().toastmessage('Login Failed');
                  }
                },
                title: 'Login',
              ),
            )
          ],
        ),
      ),
    );
  }
}
