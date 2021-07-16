import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';
import 'package:pinder/routes/splash_dialog.dart';
import 'package:pinder/routes/remove_ads.dart';
import 'package:pinder/widgets/animal_card_list.dart';
import 'package:pinder/widgets/icon_button.dart';

class PinderHomePageRoute extends StatefulWidget {
  @override
  _PinderHomePageRouteState createState() => _PinderHomePageRouteState();
}

class _PinderHomePageRouteState extends State<PinderHomePageRoute> {
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      bool seen = prefs.getBool('seen_plash') ?? false;

      if (!seen) {
        showSplashDialog(context);
        prefs.setBool('seen_plash', true);
      }
    });

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
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Pinder',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25
                      ),
                    ),
                  ),
                  /*
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      PinderIcons.cog,
                      color: PinderColors.dark
                    ),
                  ),
                  */
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
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PinderIconButton(
                    iconData: PinderIcons.dollar_sign,
                    iconColor: Colors.white,
                    buttonColor: PinderColors.darkgreen,
                    onTap: () => showRemoveAdsDialog(context)
                  ),
                  PinderIconButton(
                    iconData: PinderIcons.info,
                    iconColor: Colors.white,
                    buttonColor: PinderColors.darkgreen,
                    onTap: () => showSplashDialog(context)
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

showRemoveAdsDialog(BuildContext context) {
  PageRouteBuilder route = PageRouteBuilder(
    opaque: false,
    pageBuilder: (BuildContext context, _, __) => PinderRemoveAdsDialogRoute()
  );

  Navigator.of(context).push(route);
}

showSplashDialog(BuildContext context) {
  PageRouteBuilder route = PageRouteBuilder(
    opaque: false,
    pageBuilder: (BuildContext context, _, __) => PinderSplashDialogRoute()
  );

  Navigator.of(context).push(route);
}