import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinder/pinder_icons_icons.dart';

class PinderBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Icon(
          PinderIcons.arrow_back,
          color: Colors.white70
        )
      )
    );
  }
}