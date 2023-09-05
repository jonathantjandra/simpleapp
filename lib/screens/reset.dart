import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test3/databases/database_helper.dart';
import 'package:test3/main.dart';

// change password page
class Reset extends StatefulWidget {
  final String useid;
  const Reset({super.key, required this.useid});

  @override
  State<Reset> createState() => _Reset();
}

class _Reset extends State<Reset> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  final TextEditingController _opswcontroller = TextEditingController();
  final TextEditingController _npswcontroller = TextEditingController();
  final TextEditingController _cnpswcontroller = TextEditingController();

  Future<List<Map<String, dynamic>>> getItem(String a) async {
    final value = await DatabaseHelper.getItem(
        a);
    debugPrint(jsonEncode(value));
    return value;
  }

  Future<int> updateItem(int a, String b, String c, String d) async {
    final value = await DatabaseHelper.updateItem(a,b,c,d);
    debugPrint(value.toString());
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change your Password'),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _opswcontroller,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.link_off),
                    hintText: 'Input your Old Password?',
                    labelText: 'Old Password*',
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
                    } else
                    if (value.length < 8) {
                      return 'Your password must be at least 8 characters';
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _npswcontroller,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password),
                    hintText: 'Input your New Password?',
                    labelText: 'New Password*',
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
                    } else
                    if ((!value.contains(RegExp(r"[a-z]"))) && (!value.contains(RegExp(r"[A-Z]"))) || (!value.contains(RegExp(r"[0-9]")))) {
                      return 'Password must contain Num and Alphabets.';
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _cnpswcontroller,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password, color:Colors.amber),
                    hintText: 'Confirm your New Password?',
                    labelText: 'Confirm Password*',
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
                    } else
                    if (value.length < 8) {
                      return 'Your password must be at least 8 characters';
                    } else
                    if ((!value.contains(RegExp(r"[a-z]"))) && (!value.contains(RegExp(r"[A-Z]"))) || (!value.contains(RegExp(r"[0-9]")))) {
                      return 'Password must contain Num and Alphabets.';
                    }
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      if (jsonEncode(await(getItem(widget.useid))) != '[]') {
                        var element =(await(getItem(widget.useid)))[0];
                        var uid = element['username'];
                        var psw = element['password'];
                        var no = element['id'];
                        var em = element['email'];

                        debugPrint(uid);
                        debugPrint(psw);
                        debugPrint(no.toString());
                        debugPrint(em);
                        if ((psw == _opswcontroller.text) && (psw != _npswcontroller.text) && (_npswcontroller.text == _cnpswcontroller.text)) {
                          updateItem(no,uid,em,_npswcontroller.text);
                          var element2 =(await(getItem(widget.useid)))[0];
                          var uid2 = element2['username'];
                          var psw2 = element2['password'];
                          var no2 = element2['id'];
                          var em2 = element2['email'];
                          debugPrint(uid2);
                          debugPrint(psw2);
                          debugPrint(no2.toString());
                          debugPrint(em2);
                          if (!mounted) return;
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyHomePage(title:'Simple App')),
                        );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Change Password Successful, Logged out...')),
                            );
                          debugPrint('update confirmed');
                        }
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
              ]
            )
          ),
        )
      )
    );
  }
}