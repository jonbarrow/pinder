import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:pinder/pinder_icons_icons.dart';

// Localization
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            title: AppLocalizations.of(context)!.childrenTitle,
            actions: [
              SheetAction(
                icon: PinderIcons.baby,
                label: AppLocalizations.of(context)!.childrenDescription,
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
            title: AppLocalizations.of(context)!.dogsTitle,
            actions: [
              SheetAction(
                icon: PinderIcons.dog,
                label: AppLocalizations.of(context)!.dogsDescription,
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
            title: AppLocalizations.of(context)!.catsTitle,
            actions: [
              SheetAction(
                icon: PinderIcons.cat,
                label: AppLocalizations.of(context)!.catsDescription,
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
            AppLocalizations.of(context)!.goodWith,
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