import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:test3/databases/database_helper.dart';
import 'dart:convert';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _Forgot();
}

class _Forgot extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _uidcontroller = TextEditingController();

  Future<List<Map<String, dynamic>>> getItem(String a) async {
    final value = await DatabaseHelper.getItem(a);
    debugPrint(jsonEncode(value));
    return value;
  }

  @override
  Widget build(BuildContext context) {
    _launchURL(String toMailId, String subject, String body) async {
    var url = Uri.parse('mailto:$toMailId?subject=$subject&body=$body');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password Page'),
        backgroundColor: Colors.deepOrange.shade300,),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _uidcontroller,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Input your username?',
                    labelText: 'Username*',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border:
                      OutlineInputBorder(),
                  ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  if (value.length != 10) {
                    return 'Your username must be 10 digits';
                  }
                  return null;
                  }
                ),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (jsonEncode(await(getItem(_uidcontroller.text))) != '[]') {
                        var element =(await(getItem(_uidcontroller.text)))[0];
                        var uid = element['username'];
                        var ema = element['email'];
                        var psw = element['password'];

                        debugPrint(uid);
                        debugPrint(ema);
                        debugPrint(psw);
                        await _launchURL(ema, 'Your password is', psw);
                        debugPrint('launch e-mail success');
                      }
                    }
                  },
                  label: const Text('Send e-mail'),
                  icon: const Icon(Icons.mail),
                ),
              ]
            )
          ),
        )
      )
    );
  }
}