import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';
import 'package:pinder/widgets/animal_card_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Stack of cards that can be swiped. Set width, height, etc here.
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Pinder',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      PinderIcons.cog,
                      color: PinderColors.dark
                    ),
                  ),
                ]
              )
            ),
            Container(
              //width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              child: PinderAnimalCardList(),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pinder',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ]
              ),
            )
          ]
        )
      ),
    );
  }
}