import 'package:flutter/material.dart';
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';
import 'package:pinder/widgets/icon_button.dart';
import 'package:pinder/util.dart';

class PinderRemoveAdsDialogRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  PinderIcons.emo_coffee,
                  color: PinderColors.darkgreen,
                  size: 72
                ),
                Text(
                  'Thank you for installing Pinder! To support future development this app contains ads every 10 swipes. A no-ad version is available for \$0.99. You can also check out my links below!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                Container(
                  //padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PinderIconButton(
                        iconData: PinderIcons.globe,
                        iconColor: Colors.white,
                        buttonColor: Colors.blueAccent,
                        onTap: () => launchUrl('https://jonbarrow.dev')
                      ),
                      PinderIconButton(
                        iconData: PinderIcons.github_alt,
                        iconColor: Colors.white,
                        buttonColor: PinderColors.github,
                        onTap: () => launchUrl('https://github.com/jonbarrow')
                      ),
                      PinderIconButton(
                        iconData: PinderIcons.patreon,
                        iconColor: Colors.white,
                        buttonColor: PinderColors.patreon,
                        onTap: () => launchUrl('https://patreon.com/jonbarrow')
                      ),
                      PinderIconButton(
                        iconData: PinderIcons.coffee,
                        iconColor: Colors.white,
                        buttonColor: PinderColors.kofi,
                        onTap: () => launchUrl('https://ko-fi.com/jonbarrow')
                      ),
                    ],
                  ),
                ),
                PinderIconButton(
                  iconData: PinderIcons.check,
                  iconColor: Colors.white,
                  buttonColor: PinderColors.darkgreen,
                  onTap: () => Navigator.pop(context)
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}