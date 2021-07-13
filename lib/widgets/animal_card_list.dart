import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pinder/pet_finder.dart' as pet_finder;
import 'package:pinder/widgets/animal_card.dart';
import 'package:location/location.dart';


class PinderAnimalCardList extends StatefulWidget {
  @override
  _PinderAnimalCardListState createState() => _PinderAnimalCardListState();
}

class _PinderAnimalCardListState extends State<PinderAnimalCardList> {
  TCardController _controller = TCardController();
  int _index = 0;
  int apiPage = 1;
  List<PinderAnimalCard> nextAnimalSet = [];
  final List<PinderAnimalCard> animalsList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: getAnimals(this.apiPage), // sets the getTranding method as the expected Future
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) { //checks if the response returns valid data
            // Add the widgets to the list
            getAnimals(++this.apiPage).then((data) {
              data['animals'].forEach((dynamic animal) {
                PinderAnimalCard card = PinderAnimalCard(metadata: animal, controller: _controller);
                nextAnimalSet.add(card);
              });
            });

            snapshot.data['animals'].forEach((dynamic animal) {
              PinderAnimalCard card = PinderAnimalCard(metadata: animal, controller: _controller);
              animalsList.add(card);
            });

            print(animalsList.length);

            // Building the basic UI
            return Container(
              child: TCard(
                size: Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.7),
                cards: animalsList,
                controller: _controller,
                lockYAxis: true,
                onForward: (index, info) {
                  _index = index;
                  //print(info.direction);
                  //setState(() {});
                },
                onEnd: () {
                  InterstitialAd.load(
                    adUnitId: 'ca-app-pub-3940256099942544/1033173712',
                    request: AdRequest(),
                    adLoadCallback: InterstitialAdLoadCallback(
                      onAdLoaded: (InterstitialAd ad) {
                        // Keep a reference to the ad so you can show it later.
                        //this._interstitialAd = ad;
                        ad.show();
                      },
                      onAdFailedToLoad: (LoadAdError error) {
                        print('InterstitialAd failed to load: $error');
                      },
                    )
                  );

                  _controller.reset(cards: this.nextAnimalSet);
                  nextAnimalSet.clear();
                  getAnimals(++this.apiPage).then((data) {
                    data['animals'].forEach((dynamic animal) {
                      PinderAnimalCard card = PinderAnimalCard(metadata: animal, controller: _controller);
                      nextAnimalSet.add(card);
                    });
                  });
                },
              ),
            );
          } else if (snapshot.hasError) { //checks if the response throws an error
            return Text('${snapshot.error}');
          }

          return const Text('Loading...'); // If no errors and no data, assume still loading
        }
      )
    );
  }
}

getAnimals(page) async {
  LocationData locationData = await getLocation();

  return pet_finder.getAnimals({'page': '$page', 'location': '${locationData.latitude},${locationData.longitude}', 'sort': 'distance'});
}

getLocation() async {
  Location location = new Location();

  bool _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  PermissionStatus _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  return location.getLocation();
}