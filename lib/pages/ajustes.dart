import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AjustePages extends StatefulWidget {
  const AjustePages({Key? key}) : super(key: key);

  @override
  _AjustePagesState createState() => _AjustePagesState();
}

class _AjustePagesState extends State<AjustePages> {
  final pin = TextEditingController();
  String pinguardado = "";
  @override
  void initState() {
    super.initState();
    cargarpin();
  }

  void cargarpin() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      pin.text = pref.getString("pin") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Pin: " + pin.text,style: TextStyle(fontSize: 25),),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(hintText: "Ingrese su Pin."),
              controller: pin,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          final pref = await SharedPreferences.getInstance();
          setState(() {
            pref.setString("pin", pin.text);
          });
          final snackBar = SnackBar(content: Text("Pin Guardado"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
