import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';
import 'package:pinder/widgets/animal_card_list.dart';

class PinderHomePageRoute extends StatefulWidget {
  @override
  _PinderHomePageRouteState createState() => _PinderHomePageRouteState();
}

class _PinderHomePageRouteState extends State<PinderHomePageRoute> {
  @override
  Widget build(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SplashDialog()
    );

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

class SplashDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        width: MediaQuery.of(context).size.width * 0.4,
        height: 700,
        color: Colors.white,
      ),
    );
  }
}