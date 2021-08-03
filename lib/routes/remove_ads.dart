import 'package:flutter/material.dart';
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';
import 'package:pinder/widgets/icon_button.dart';
import 'package:pinder/iap_handler.dart' as iap;

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
                  PinderIcons.emo_laugh,
                  color: PinderColors.darkgreen,
                  size: 72
                ),
                Text(
                  'Want to remove ads and show support for future delevopment? Consider purchasing the Ad Free version of Pinder!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PinderIconButton(
                        iconData: PinderIcons.dollar_sign,
                        iconColor: Colors.white,
                        buttonColor: PinderColors.darkgreen,
                        onTap: () async {
                          await iap.restore();
                          iap.purchase(iap.getProducts()[0]);
                        }
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