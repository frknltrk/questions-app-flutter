// check out https://github.com/ninest/swipeable_card/tree/master/example
// for a better explanation

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'example_route.dart';
import 'categories.dart';
// import 'example_slide_route.dart';

// implement: https://youtube.com/watch?v=EXp0gq9kGxI#t=14m25s
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/game': (context) => ExampleRoute(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // make the background color darker to put the cards in focus!
        scaffoldBackgroundColor: const Color(0xFF111111),
      ),
    );
  }
}

// 0xFF111111
