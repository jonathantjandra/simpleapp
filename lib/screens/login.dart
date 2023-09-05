import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test3/databases/database_helper.dart';
import 'dart:convert';
import './home.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  final TextEditingController _uidcontroller = TextEditingController();
  final TextEditingController _pswdcontroller = TextEditingController();

  Future<List<Map<String, dynamic>>> getItem(String a) async {
    final value = await DatabaseHelper.getItem(a);
    debugPrint(jsonEncode(value));
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Colors.green.shade300,),
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
                const SizedBox(height: 5),
                TextFormField(
                  controller: _pswdcontroller,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password),
                    hintText: 'Input your Password?',
                    labelText: 'Password*',
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon:
                          Icon( _obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Your password cannot be empty';
                    }
                    if (value.length < 8) {
                      return 'Your password must be at least 8 characters';
                    }
                  },
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  // to-do: Connect to sqlite or database and navigate to 2nd screen for posts
                      if (jsonEncode(await(getItem(_uidcontroller.text))) != '[]') {
                        var element =(await(getItem(_uidcontroller.text)))[0];
                        var uid = element['username'];
                        var psw = element['password'];

                        debugPrint(uid);
                        debugPrint(psw);
                        if ((uid == _uidcontroller.text) && (psw == _pswdcontroller.text)) {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          pref.setString('userid', uid);
                          if (!mounted) return;
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeL(usid: uid)),
                        );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('You are logged in.')),
                            );
                          debugPrint('user confirmed');
                        }
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
              ]
            )
          ),
        )
      )
    );
  }
}