import 'package:flutter/material.dart';

class PinderIconButton extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color buttonColor;
  final void Function() onTap;

  PinderIconButton({ required this.iconData, required this.iconColor, required this.buttonColor, required this.onTap });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: this.buttonColor,
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
        child: Icon(this.iconData, color: this.iconColor)
      )
    );
  }
}