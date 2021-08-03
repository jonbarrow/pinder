import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';
import 'package:tcard/tcard.dart';
import 'package:location/location.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pinder/iap_handler.dart' as iap;
import 'package:pinder/pet_finder.dart' as pet_finder;
import 'package:pinder/widgets/animal_card.dart';
import 'package:pinder/config.dart' as config;


class PinderAnimalCardList extends StatefulWidget {
  @override
  _PinderAnimalCardListState createState() => _PinderAnimalCardListState();
}

class _PinderAnimalCardListState extends State<PinderAnimalCardList> {
  late Future future;
  TCardController _controller = TCardController();
  int apiPage = 1;
  int swipeCount = 0;
  List<PinderAnimalCard> nextAnimalSet = [];
  final List<PinderAnimalCard> animalsList = [];
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  createCardList(data, list) {
    data['animals'].forEach((dynamic animal) {
      PinderAnimalCard card = PinderAnimalCard(
        metadata: animal,
        onDislikeTap: () =>  this._controller.forward(direction: SwipDirection.Left),
        onDetailsTap: () => Navigator.pushNamed(context, '/details', arguments: { 'metadata': animal }),
        onLikeTap: () => this._controller.forward(direction: SwipDirection.Right),
      );

      list.add(card);
    });
  }

  loadNextAnimalSet() {
    this.nextAnimalSet.clear();

    getAnimals(++this.apiPage).then((data) {
      this.createCardList(data, nextAnimalSet);
    });
  }

  loadNextAd() {
    InterstitialAd.load(
      adUnitId: config.GOOGLE_AD_MOB_INTERSTITIAL_UNIT_ID,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          this._interstitialAd = ad;
          this._numInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          this._numInterstitialLoadAttempts += 1;
          this._interstitialAd = null;
          if (this._numInterstitialLoadAttempts <= config.MAX_AD_LOAD_ATTEMPTS) {
            this.loadNextAd();
          }
        },
      )
    );
  }

  showAd() {
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        this.loadNextAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        this.loadNextAd();
      },
    );

    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void initState() {
    this.future = getAnimals(this.apiPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: this.future, // sets the getTranding method as the expected Future
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) { //checks if the response returns valid data
            // Add the widgets to the list

            if (snapshot.data['animals'].length == 0) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PinderIcons.emo_unhappy,
                      color: PinderColors.darkgreen,
                      size: 72
                    ),
                    SizedBox(height: 20),
                    Text('Could not find any pets around you!')
                  ]
                )
              );
            }

            this.createCardList(snapshot.data, animalsList);
            this.loadNextAnimalSet();
            this.loadNextAd();

            // Building the basic UI
            return Container(
              child: TCard(
                size: Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.7),
                cards: animalsList,
                controller: _controller,
                lockYAxis: true,
                onForward: (index, info) {
                  this.swipeCount++;
                  if (this.swipeCount == 10) {
                    if (!iap.disableAds) {
                      this.showAd();
                    }
                    this.swipeCount = 0;
                  }
                },
                onEnd: () {
                  _controller.reset(cards: this.nextAnimalSet);
                  this.loadNextAnimalSet();
                },
              ),
            );
          } else if (snapshot.hasError) { //checks if the response throws an error
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    PinderIcons.emo_displeased,
                    color: PinderColors.darkgreen,
                    size: 72
                  ),
                  SizedBox(height: 20),
                  Text('${snapshot.error}')
                ]
              )
            );
          }

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PinderIcons.emo_thumbsup,
                  color: PinderColors.darkgreen,
                  size: 72
                ),
                SizedBox(height: 20),
                Text(
                  'Searching for pets around you!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ]
            )
          ); // If no errors and no data, assume still loading
        }
      )
    );
  }
}

getAnimals(page) async {
  LocationData? locationData = await getLocation();

  return pet_finder.getAnimals({'page': '$page', 'location': '${locationData?.latitude},${locationData?.longitude}', 'sort': 'distance'});
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
