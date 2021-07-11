import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:pinder/pinder_icons_icons.dart';

class PinderGoodWithEnvironment extends StatelessWidget {
  final Map<String, dynamic> environment;

  PinderGoodWithEnvironment({required this.environment});
 
  @override
  Widget build(BuildContext context) {
    List<Widget> icons = [];

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: 'Good with children',
            actions: [
              const SheetAction(
                icon: PinderIcons.baby,
                label: 'When active this indicates that the pet is good around children!',
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.baby,
            color: this.environment['children'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: 'Good with dogs',
            actions: [
              const SheetAction(
                icon: PinderIcons.dog,
                label: 'When active this indicates that the pet is good around dogs!',
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.dog,
            color: this.environment['dogs'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: 'Good with cats',
            actions: [
              const SheetAction(
                icon: PinderIcons.cat,
                label: 'When active this indicates that the pet is good around cats!',
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.cat,
            color: this.environment['cats'] != null ? Colors.blue : Colors.grey
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
            'Good with',
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