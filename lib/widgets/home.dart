import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var nameEditingController = TextEditingController();
  var emailEditingController = TextEditingController();
  var phoneEditingController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? response = prefs.getString("emergency");
    if (response != null){
      nameEditingController.text = jsonDecode(response!)["name"];
      emailEditingController.text = jsonDecode(response!)["email"];
      phoneEditingController.text = jsonDecode(response!)["phone"];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emergency Contact"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset("images/fone.png", width: 100,),
              TextField(decoration:
              InputDecoration(hintText: "Enter name"),
              controller: nameEditingController,
              ),
              SizedBox(height: 10,),
              TextField(decoration: InputDecoration(hintText: "Enter email"),
              controller: emailEditingController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10,),
              TextField(decoration: InputDecoration(hintText: "Enter phone number"),
              controller: phoneEditingController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10,),
              TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {

                    print(nameEditingController.text);
                    print(emailEditingController.text);
                    print(phoneEditingController.text);
                    var emergencyContact = {
                      "name":nameEditingController.text,
                      "email":emailEditingController.text,
                      "phone":phoneEditingController.text
                    };
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('emergency', jsonEncode(emergencyContact));
                    Fluttertoast.showToast(
                        msg: "Item succesfully saved",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,

                    );


              }, child: Text("Save")),
              SizedBox(height: 10,),
              TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: (){

              }, child: Text("Delete"))
            ],
          ),
        ),
      ),
    );
  }
}
