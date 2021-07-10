import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
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
  final List<PinderAnimalCard> animalsList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: getAnimalData(), // sets the getTranding method as the expected Future
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) { //checks if the response returns valid data
            // Add the widgets to the list
            snapshot.data['animals'].forEach((dynamic animal) {
              PinderAnimalCard card = PinderAnimalCard(metadata: animal, controller: _controller);
              animalsList.add(card);
            });

            // Building the basic UI
            return Container(
              child: TCard(
                size: Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.7),
                //size: Size(400, 600),
                cards: animalsList,
                controller: _controller,
                lockYAxis: true,
                onForward: (index, info) {
                  //_index = index;
                  //print(info.direction);
                  //setState(() {});
                },
                onBack: (index, info) {
                  //_index = index;
                  //setState(() {});
                  //_controller.forward();
                  //_controller.forward();
                },
                onEnd: () {
                  _controller.reset(cards: animalsList);
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

getAnimalData() async {
  return pet_finder.getAnimals({'location': '32224', 'sort': 'distance'});
}