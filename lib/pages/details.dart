import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:pinder/widgets/back_button.dart';
import 'package:pinder/widgets/contact_shelter.dart';
import 'package:pinder/widgets/name_gender.dart';
import 'package:pinder/widgets/good_with_environment.dart';
import 'package:pinder/widgets/attributes.dart';

class DetailsPage extends StatefulWidget {
 final Map<String, dynamic> metadata;

  DetailsPage({required this.metadata});

  @override
  _DetailsPageState createState() => _DetailsPageState(metadata: this.metadata);
}

class _DetailsPageState extends State<DetailsPage> {
  Map<String, dynamic> metadata;

  late String name = 'Pet Name';
  late String imageUrl;

  var unescape = HtmlUnescape();

  _DetailsPageState({required this.metadata});

  void initMetadata() {
    this.name = this.metadata['name'];

    if (this.metadata['photos'].length > 0) {
      if (this.metadata['photos'][0].containsKey('small')) {
        this.imageUrl = this.metadata['photos'][0]['small'];
      }

      if (this.metadata['photos'][0].containsKey('medium')) {
        this.imageUrl = this.metadata['photos'][0]['medium'];
      }

      if (this.metadata['photos'][0].containsKey('large')) {
        this.imageUrl = this.metadata['photos'][0]['large'];
      }

      if (this.metadata['photos'][0].containsKey('full')) {
        this.imageUrl = this.metadata['photos'][0]['full'];
      }
    } else {
      this.imageUrl = 'https://via.placeholder.com/200';
    }
  }

  @override
  Widget build(BuildContext context) {
    this.initMetadata();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: CachedNetworkImage(
                        imageUrl: this.imageUrl,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )
                            )
                          );
                        }
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: PinderBackButton(),
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PinderNameGender(name: this.metadata['name'], gender: this.metadata['gender']),
                    Container(
                      padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                      alignment: Alignment.center,
                      child: Text(
                        '${this.metadata['distance'].round()} miles',
                        style: TextStyle(
                          color: Colors.black87
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
              PinderContactShelter(contact: this.metadata['contact']),
              PinderGoodWithEnvironment(environment: this.metadata['environment']),
              PinderAttributes(attributes: this.metadata['attributes']),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  unescape.convert(this.metadata['description']),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18
                  )
                ),
              ),
            ]
          )
          )
        )
      )
    );
  }
}

class ImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.pink,
      ),
    );
  }
}