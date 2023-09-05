import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test3/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var userid = prefs.getString("userid");
  debugPrint(userid);
  if (userid == null) {
    runApp(const MyApp());
  } else {
    runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeL(usid: userid),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade500),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Simple App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;
  bool logged = false;

  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit the App?'),
          content: const Text('Confirm your actions.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => SystemNavigator.pop(), 
              child: const Text('Yes'),
            ),
          ],
        ),
      )) ??
      false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop,
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.orange,
              ),
              onPressed: _onWillPop,
            )
          ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You are logged out.',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              'Choose one of the menus below.',
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.grey.shade200,
                  ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 15)
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              child: const Text(
                "New here? Register",
                style: TextStyle(fontSize: 15),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade300,
                  foregroundColor: Colors.deepPurple.shade600),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Forgot()),
                );
              },
              child: const Text(
                "Forgot password",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
