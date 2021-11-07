import 'package:flutter/material.dart';
import 'package:swipeable_card/swipeable_card.dart';

import 'card_example.dart';

class ExampleRoute extends StatefulWidget {
  const ExampleRoute({Key key}) : super(key: key);

  @override
  _ExampleRouteState createState() => _ExampleRouteState();
}

class _ExampleRouteState extends State<ExampleRoute> {
  List<CardExample> cards;
  int currentCardIndex;

  @override
  void initState() {
    super.initState();
    cards = [
      CardExample(ValueKey(0)),
      CardExample(ValueKey(1)),
      CardExample(ValueKey(2)),
    ];
    currentCardIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Card Length: ${cards.length.toString()}");
    debugPrint("Current Index: $currentCardIndex");
//  _cardController is an identifier.
    SwipeableWidgetController _cardController = SwipeableWidgetController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SwipeableWidget(
              cardController: _cardController,
              animationDuration: 500,
              horizontalThreshold: 0.85,
              child: cards[currentCardIndex],
              nextCards: <Widget>[
                // show next card
                // if there are no next cards, show nothing
                if (currentCardIndex + 1 < cards.length)
                  Align(
                    alignment: Alignment.center,
//                    child: cards[currentCardIndex + 1],
                  ),
              ],
              onLeftSwipe: () {
                if (currentCardIndex + 1 == cards.length - 1) cards.add(CardExample(key: ValueKey(currentCardIndex + 2)));
                swipeLeft();
              },
              onRightSwipe: () {
                if (currentCardIndex != 0) swipeRight();
              },
            ),
            cardControllerRow(_cardController),
          ],
        ),
      ),
    );
  }

  void swipeLeft() {
    print("Yeni Soru");

    // NOTE: it is your job to change the card
    setState(() {
      currentCardIndex++;
    });
  }

  void swipeRight() {
    print("Önceki Soru");
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
