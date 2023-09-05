import 'package:flutter/material.dart';
import 'package:test3/main.dart';
import 'package:test3/screens/reset.dart';
import 'package:test3/simple_bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/posts/posts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeL extends StatefulWidget {
  final String usid;
  const HomeL({super.key, required this.usid});

  @override
  State<HomeL> createState() => _HomeL();
}

class _HomeL extends State<HomeL> {
  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
        return false;
      },
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
        title: const Text('Home Page'),
        actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onPressed: () async{
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove('userid');
                if (!mounted) return;
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Simple App')),
                );
              },
            )
          ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome, User #',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              widget.usid,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color:Colors.blue.shade600),
            ),
            const Text(
              'You are logged in.',
              style: TextStyle(fontSize: 18.5),  
            ),
            const SizedBox(height:10),
            const Text(
              'Please choose one of the menus below:',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 5),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.grey.shade700),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reset(useid: widget.usid)),
                );
              },
              child: const Text(
                "Change password",
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height:5),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.yellow),
              onPressed: () {
                Bloc.observer = const SimpleBlocObserver();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PostsPage()),
                );
              },
              child: const Text(
                "View Your Posts",
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