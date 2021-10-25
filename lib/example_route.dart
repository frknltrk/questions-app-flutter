import 'package:flutter/material.dart';
import 'package:swipeable_card/swipeable_card.dart';

import 'card_example.dart';

class ExampleRoute extends StatefulWidget {
  const ExampleRoute({Key key}) : super(key: key);

  @override
  _ExampleRouteState createState() => _ExampleRouteState();
}

class _ExampleRouteState extends State<ExampleRoute> {
  final List<CardExample> cards = [
    CardExample(color: Colors.red, text: "First question"),
    CardExample(color: Colors.blue, text: "Second question"),
    CardExample(color: Colors.orange, text: "Third question"),
//    CardExample(color: Colors.indigo),
//    CardExample(color: Colors.green, text: "The next card is the last"),
//    CardExample(color: Colors.purple, text: "This is the last card"),
  ];
  int currentCardIndex = 0;

  @override
  Widget build(BuildContext context) {
//  _cardController is an identifier.
    SwipeableWidgetController _cardController = SwipeableWidgetController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            if (currentCardIndex < cards.length)
              SwipeableWidget(
                cardController: _cardController,
                animationDuration: 500,
                horizontalThreshold: 0.85,
                child: cards[currentCardIndex],
                  nextCards: <Widget>[
                  // show next card
                  // if there are no next cards, show nothing
                  if (!(currentCardIndex + 1 >= cards.length))
                    Align(
                      alignment: Alignment.center,
//                      child: cards[currentCardIndex + 1],
                    ),
                ],
                onLeftSwipe: () {
                    if (currentCardIndex + 1 == cards.length - 1)
                      cards.add(CardExample(color: Colors.red, text: "${currentCardIndex+3}th question"));
                    swipeLeft();},
                onRightSwipe: () {
                    if (currentCardIndex != 0)
                      swipeRight();},
              )
            else
              // if the deck is complete, add a button to reset deck
              Center(
                child: FlatButton(
                  child: Text("Reset deck"),
                  onPressed: () => setState(() => currentCardIndex = 0),
                ),
              ),

            // only show the card controlling buttons when there are cards
            // otherwise, just hide it
            if (currentCardIndex < cards.length)
              cardControllerRow(_cardController),
          ],
        ),
      ),
    );
  }

  void swipeLeft() {
    print("left");

    // NOTE: it is your job to change the card
    setState(() {
      currentCardIndex++;
    });
  }

  void swipeRight() {
    print("right");
    setState(() {
      currentCardIndex--;
    });
  }

  Widget cardControllerRow(SwipeableWidgetController cardController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          child: Text("Önceki"),
          onPressed: () => cardController.triggerSwipeRight(),
        ),
        TextButton(
          child: Text("Rastgele"),
          onPressed: () => cardController.triggerSwipeLeft(),
        ),
      ],
    );
  }
}