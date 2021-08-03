import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinder/iap_handler.dart' as iap;
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';
import 'package:pinder/routes/splash_dialog.dart';
import 'package:pinder/routes/remove_ads.dart';
import 'package:pinder/widgets/animal_card_list.dart';
import 'package:pinder/widgets/icon_button.dart';

// TODO: Actually use error codes?
const LOCATION_SERVICE_REJECTED_ERROR = 1;
const LOCATION_PERMISSION_REJECTED_ERROR = 2;

class PinderHomePageRoute extends StatefulWidget {
  @override
  _PinderHomePageRouteState createState() => _PinderHomePageRouteState();
}

class _PinderHomePageRouteState extends State<PinderHomePageRoute> {
  Location location = new Location();
  int locationErrorCode = 0;

  initLocation() async {
    bool _serviceEnabled = await this.location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await this.location.requestService();
      if (!_serviceEnabled) {
        throw(LOCATION_SERVICE_REJECTED_ERROR);
      }
    }

    PermissionStatus _permissionGranted = await this.location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await this.location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw(LOCATION_PERMISSION_REJECTED_ERROR);
      }
    }

    return this.location.getLocation();
  }

  @override
  void initState() async {
    super.initState();
    iap.init();
  }

  @override
  void dispose() {
    super.dispose();
    iap.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      bool seen = prefs.getBool('seen_splash') ?? false;

      if (!seen) {
        showSplashDialog(context);
        prefs.setBool('seen_splash', true);
      }
    });

    return Container(
      child: FutureBuilder<dynamic>(
        future: this.initLocation(), // sets the getTranding method as the expected Future
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) { //checks if the response returns valid data
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
                          // Disabled because the header looked weird
                          // And there are no settings yet
                          /*
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
                          */
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
                      //child: PinderAnimalCardList(),
                      child: PinderAnimalCardList()
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
          } else if (snapshot.hasError) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        PinderIcons.emo_displeased,
                        color: PinderColors.darkgreen,
                        size: 72
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // This just reloads the widget to ask for permissions again
                            // TODO: Change this?
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500.0),
                            color: PinderColors.darkgreen
                          ),
                          child: Text(
                            'Must enable locations. Tap here to retry',
                            style: TextStyle(color: Colors.white),
                          )
                        )
                      )
                    ]
                  )
                )
              )
            );
          }

          // TODO: Replace this
          return Center(
            child: CircularProgressIndicator()
          );
        }
      )
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