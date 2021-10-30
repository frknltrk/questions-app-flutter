import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CardExample extends StatelessWidget {
  String getRandomGeneratedId() {
    const int AUTO_ID_LENGTH = 20;
    const String AUTO_ID_ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    const int maxRandom = AUTO_ID_ALPHABET.length;
    final Random randomGen = Random();

    String id = '';
    for (int i = 0; i < AUTO_ID_LENGTH; i++) {
      id = id + AUTO_ID_ALPHABET[randomGen.nextInt(maxRandom)];
    }
    return id;
  }

  Future<DocumentSnapshot> getRandomQuestion() async {
    CollectionReference myRef = FirebaseFirestore.instance.collection('questions');

    // generate a random index based on the list length and use it to retrieve the element
    String _randomIndex = getRandomGeneratedId();
    QuerySnapshot querySnapshot = await myRef.where('id', isGreaterThanOrEqualTo: _randomIndex).orderBy('id', descending: false).limit(1).get();
    return querySnapshot.docs[0]; // returns a DocumentSnapshot of the (random) question
  }

  const CardExample({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: getRandomQuestion(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
            style: TextStyle(
              fontSize: 36.0,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w900,
            ),
          );
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
          return Text(
            data['text'],
            style: TextStyle(
              fontSize: 36.0,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w900,
            ),
          );
        }

        return Text("loading");
      },
    );
/*    return Container(
      height: 450,
      width: 320,

      // Warning: hard-coding values like this is a bad practice
      padding: EdgeInsets.all(38.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 7.0,
          color: Colors.transparent.withOpacity(0.3),
        ),
      ),

      child: Text(
        text,
        style: TextStyle(
          fontSize: 36.0,
          // color: Colors.white,
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
*/
  }
}
