import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:pinder/pinder_icons_icons.dart';

// Localization
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PinderAttributes extends StatelessWidget {
  final Map<String, dynamic> attributes;

  PinderAttributes({required this.attributes});

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = [];

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: AppLocalizations.of(context)!.spayedTitle,
            actions: [
              SheetAction(
                icon: PinderIcons.baby_carriage,
                label: AppLocalizations.of(context)!.spayedDescription,
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.baby_carriage,
            color: this.attributes['spayed_neutered'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

   icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: AppLocalizations.of(context)!.houseTrainedTitle,
            actions: [
              SheetAction(
                icon: PinderIcons.toilet_paper,
                label: AppLocalizations.of(context)!.houseTrainedDescription,
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.toilet_paper,
            color: this.attributes['house_trained'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: AppLocalizations.of(context)!.declawedTitle,
            actions: [
              SheetAction(
                icon: PinderIcons.bird_claw,
                label: AppLocalizations.of(context)!.declawedDescription,
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.bird_claw,
            color: this.attributes['declawed'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: AppLocalizations.of(context)!.specialNeedsTitle,
            actions: [
              SheetAction(
                icon: PinderIcons.notes_medical,
                label: AppLocalizations.of(context)!.specialNeedsDescription,
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.notes_medical,
            color: this.attributes['special_needs'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () async {
          await showModalActionSheet(
            context: context,
            title: AppLocalizations.of(context)!.shotsTitle,
            actions: [
              SheetAction(
                icon: PinderIcons.syringe,
                label: AppLocalizations.of(context)!.shotsDescription,
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.syringe,
            color: this.attributes['shots_current'] != null ? Colors.blue : Colors.grey
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
            AppLocalizations.of(context)!.otherInfo,
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