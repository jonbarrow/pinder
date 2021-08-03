import 'package:flutter/widgets.dart';

class PinderColors {
  // Normal colors
  static const Color pink = Color(0xFFFF9E9E);
  static const Color redpink = Color(0xFFFF5C5C);
  static const Color green = Color(0xffdaffcc);
  static const Color darkgreen = Color(0xff228000);
  static const Color red = Color(0xFFFF2929);
  static const Color lightred = Color(0xFFFF5353);
  static const Color darkblue = Color(0xFF083F91);

  // Brand colors
  static const Color github = Color(0xFF181717);
  static const Color patreon = Color(0xFFFF424D);
  static const Color kofi = Color(0xFFFF5E5B);



  static const Color dark = Color(0xFF1D1D27);
  static const Color placeholder = Color(0xFF252534);
  static const Color component = Color(0xFF30303F);

  static const Color textmuted = Color(0xFF4C4C66);
  static const Color textnofocus = Color(0xFFADADC9);
  static const Color text = Color(0xFFC4C4D9);
  static const Color textemphasis = Color(0xFFFFFFFF);

  static const Color action = Color(0xFF9E9EFF);
  

  static const Color gradienttop = Color(0xFFA25AFF);
  static const Color gradientbottom = Color(0xFF9E9EFF);

  static const Color overlay = Color.fromRGBO(0, 0, 0, .5);
}

class PinderText {
  static const TextStyle title = TextStyle(
    color: PinderColors.textemphasis,
    fontWeight: FontWeight.normal,
    fontSize: 25,
    fontFamily: 'OpenSans'
  );
  static const TextStyle subtitle = TextStyle(
    color: PinderColors.textnofocus,
    fontWeight: FontWeight.normal,
    fontSize: 15,
    fontFamily: 'OpenSans'
  );
  static const TextStyle heading = TextStyle(
    color: PinderColors.textemphasis,
    fontWeight: FontWeight.normal,
    fontSize: 20,
    fontFamily: 'OpenSans'
  );
  static const TextStyle action = TextStyle(
    color: PinderColors.action,
    fontWeight: FontWeight.normal,
    fontSize: 15,
    fontFamily: 'OpenSans'
  );
  static const TextStyle emphasis = TextStyle(
    color: PinderColors.textemphasis,
    fontWeight: FontWeight.normal,
    fontSize: 15,
    fontFamily: 'OpenSans'
  );
  static const TextStyle text = TextStyle(
    color: PinderColors.text,
    fontWeight: FontWeight.normal,
    fontSize: 15,
    fontFamily: 'OpenSans'
  );
}