import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:pinder/pinder_icons_icons.dart';

class PinderAttributes extends StatelessWidget {
  final Map<String, dynamic> attributes;

  PinderAttributes({required this.attributes});

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = [];

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: 'Spayed/neutered',
            actions: [
              const SheetAction(
                icon: PinderIcons.baby_carriage,
                label: 'When active this indicates that the pet has been spayed/neutered!',
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.baby_carriage,
            color: this.attributes['spayed_neutered'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

   icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: 'House trained',
            actions: [
              const SheetAction(
                icon: PinderIcons.toilet_paper,
                label: 'When active this indicates that the pet has been house trained!',
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.toilet_paper,
            color: this.attributes['house_trained'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: 'Declawed',
            actions: [
              const SheetAction(
                icon: PinderIcons.bird_claw,
                label: 'When active this indicates that the pet has been declawed!',
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.bird_claw,
            color: this.attributes['declawed'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: 'Special needs',
            actions: [
              const SheetAction(
                icon: PinderIcons.notes_medical,
                label: 'When active this indicates that the pet has special needs!',
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.notes_medical,
            color: this.attributes['special_needs'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: 'Shots',
            actions: [
              const SheetAction(
                icon: PinderIcons.syringe,
                label: 'When active this indicates that the pet has up-to-date shots!',
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.syringe,
            color: this.attributes['shots_current'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Other Info',
            style: TextStyle(
              fontSize: 22
            ),
          ),
          Divider(
            color: Colors.black
          ),
          Row(
            children: icons,
          )
        ]
      )
    );
  }
}