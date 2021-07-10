import 'package:flutter/widgets.dart';

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
          border: Border.all(color: this.iconColor.withAlpha(60)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: this.buttonColor.withAlpha(70),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ]
        ),
        child: Icon(iconData, color: this.iconColor)
      )
    );
  }
}