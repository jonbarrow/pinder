import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:pinder/pinder_icons_icons.dart';

class PinderContactShelter extends StatelessWidget {
  final Map<String, dynamic> contact;
  final String url;

  PinderContactShelter({ required this.contact, required this.url });

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = [];

    icons.add(
      GestureDetector(
        onTap: () {
          if (this.contact['phone'] != null) {
            final Uri _phoneLaunchUri =  Uri(scheme: 'tel', path: this.contact['phone']);
            launchUrl(_phoneLaunchUri.toString());
          }
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.phone,
            color: this.contact['phone'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () {
          if (this.contact['email'] != null) {
            final Uri _emailLaunchUri =  Uri(scheme: 'mailto', path: this.contact['email'], queryParameters: {'subject': 'Adopt Pet'});
            launchUrl(_emailLaunchUri.toString());
          }
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.mail_bulk,
            color: this.contact['email'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () async {
          if (this.contact['address']['address1'] != null) {
            String address = this.contact['address']['address1'];

            if (this.contact['address']['address2'] != null) {
              address = address + ' ' + this.contact['address']['address2'];
            }

            if (this.contact['address']['city'] != null) {
              address = address + ' ' + this.contact['address']['city'];
            }

            if (this.contact['address']['state'] != null) {
              address = address + ' ' + this.contact['address']['state'];
            }

            if (this.contact['address']['postcode'] != null) {
              address = address + ' ' + this.contact['address']['postcode'];
            }

             if (this.contact['address']['country'] != null) {
              address = address + ' ' + this.contact['address']['country'];
            }

            final availableMaps = await MapLauncher.installedMaps;
            await availableMaps.first.showMarker(
              coords: Coords(0, 0),
              title: address,
              extraParams: {
                'q': address
              }
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.route,
            color: this.contact['address']['address1'] != null ? Colors.blue : Colors.grey
          )
        )
      )
    );

    icons.add(
      GestureDetector(
        onTap: () {
          launchUrl(this.url);
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            PinderIcons.globe,
            color: Colors.blue
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
            'Contact',
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

Future<void> launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}