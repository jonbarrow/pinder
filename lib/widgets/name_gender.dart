import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinder/pinder_icons_icons.dart';

class PinderNameGender extends StatelessWidget {
  final String name;
  final String gender;

  PinderNameGender({ required this.name, required this.gender });

  @override
  Widget build(BuildContext context) {
    IconData icon = PinderIcons.times_circle;
    Color color = Colors.black87;

    if (this.gender == 'Female') {
      icon = PinderIcons.venus;
      color = Colors.pinkAccent;
    }

    if (this.gender == 'Male') {
      icon = PinderIcons.mars;
      color = Colors.blueAccent;
    }
    
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${this.name} ',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black87
            )
          ),
          WidgetSpan(
            child: Icon(
              icon,
              size: 25,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}