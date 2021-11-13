import 'package:flutter/material.dart';
import 'package:swipeable_card/swipeable_card.dart';

import 'card_example.dart';

class ExampleRoute extends StatefulWidget {
  const ExampleRoute({Key key}) : super(key: key);

  @override
  _ExampleRouteState createState() => _ExampleRouteState();
}

class _ExampleRouteState extends State<ExampleRoute> {
  SwipeableWidgetController _cardController;
  CardExample question;
  List<CardExample> cards;
  List<CardExample> previousCards;
  int currentCardIndex;

  @override
  void initState() {
    super.initState();
    _cardController = SwipeableWidgetController();
    cards = [
      CardExample()
    ];
    previousCards = [];
    currentCardIndex = 0;
    debugPrint("initState() has run.");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Card Length: ${cards.length.toString()}");
    debugPrint("Current Index: $currentCardIndex");
//  _cardController is an identifier.
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SwipeableWidget(
              cardController: _cardController,
              animationDuration: 500,
              horizontalThreshold: 0.85,
              child: cards.last,
              nextCards: <Widget>[
                // show next card
                // if there are no next cards, show nothing
                Align(
                  alignment: Alignment.center,
//                   child: cards[currentCardIndex + 1],
                ),
              ],
              onLeftSwipe: () {
                swipeLeft();
              },
              onRightSwipe: () {
                swipeRight();
              },
            ),
            cardControllerRow(_cardController),
          ],
        ),
      ),
    );
  }

  void swipeLeft() {
    debugPrint("Yeni Soru");

    // NOTE: it is your job to change the card
    setState(() {
      if (previousCards.isNotEmpty) cards.add(previousCards.removeLast());
    });
  }

  void swipeRight() {
    debugPrint("Önceki Soru");
    setState(() {
      previousCards.add(cards.removeLast());
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
