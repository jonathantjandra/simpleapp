import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test3/databases/database_helper.dart';
import 'package:test3/screens/home.dart';

// register page
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  final TextEditingController _uidcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pswdcontroller = TextEditingController();

  Future<void> addItem() async {
    await DatabaseHelper.createItem(
        _uidcontroller.text, _emailcontroller.text,_pswdcontroller.text);
    debugPrint(_uidcontroller.text);
    debugPrint(_emailcontroller.text);
    debugPrint(_pswdcontroller.text);
  }

  Future<void> updateItem(int id) async {
    await DatabaseHelper.updateItem(
        id, _uidcontroller.text, _emailcontroller.text, _pswdcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Page'),backgroundColor: Colors.blue.shade300,),
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
                    icon: Icon(Icons.password),
                    hintText: 'Input your Password?',
                    labelText: 'Password*',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(),
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
                const SizedBox(height: 25),
                TextFormField(
                  controller: _emailcontroller,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.mail),
                    hintText: 'Input your e-mail?',
                    labelText: 'E-mail*',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border:
                      OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Your e-mail cannot be empty';
                    }
                    if ( value.isNotEmpty && !value.contains('@')|| !value.contains('.')) {
                      return 'Your e-mail format is incorrect.';
                    }
                  },
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await addItem();
                      if (!mounted) return;
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeL(usid: _uidcontroller.text)),
                        );
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