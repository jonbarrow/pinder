import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';

class PinderDetailsButton extends StatelessWidget {
  final void Function() onTap;

  PinderDetailsButton({ required this.onTap });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(90),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 20.0,
              spreadRadius: -13.0,
              color: Colors.black,
            )
          ]
        ),
        child: Icon(PinderIcons.info_circle, color: Color(0xFF083F91))
      )
    );
  }
}