import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center( child: Text("Sorsana"),),
//        backgroundColor: Colors.green,
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
    TextButton(
           style: TextButton.styleFrom(
             textStyle: const TextStyle(fontSize: 20),
           ),
           onPressed: null,
           child: const Text('Aşk'),
        ),
//        const SizedBox(height: 30),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
              Navigator.pushNamed(context, '/game');
          },
          child: const Text('Çocuk'),
        ),
  ],
      ),
    );
  }
}