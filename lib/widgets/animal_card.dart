import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';
import 'package:pinder/widgets/icon_button.dart';
import 'package:tcard/tcard.dart';

class PinderAnimalCard extends StatelessWidget {
  final Map<String, dynamic> metadata;
  final TCardController controller;

  late String name = 'Pet Name';
  late String imageUrl;

  PinderAnimalCard({required this.metadata, required this.controller});

  final BoxFit fit = BoxFit.cover;

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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 23.0,
            spreadRadius: -13.0,
            color: Colors.black54,
          )
        ],
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: EdgeInsets.only(
              left: 15,
              top: 15,
              right: 15
            ),
            child: Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.7,
                  width: constraints.maxWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: CachedNetworkImage(
                      imageUrl: this.imageUrl,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: this.fit,
                            )
                          )
                        );
                      }
                    ),
                  ),
                ),
                Container(
                  height: (constraints.maxHeight * 0.3) - 20,
                  child: Padding(
                    padding: EdgeInsetsDirectional.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        PinderIconButton(
                          iconData: PinderIcons.times_circle,
                          iconColor: PinderColors.red,
                          buttonColor: PinderColors.lightred,
                          onTap: () {
                            this.controller.forward(direction: SwipDirection.Left);
                          }
                        ),
                        PinderIconButton(
                          iconData: PinderIcons.info_circle,
                          iconColor: PinderColors.darkgreen,
                          buttonColor: PinderColors.green,
                          onTap: () {
                            Navigator.pushNamed(context, '/details', arguments: { 'metadata': this.metadata });
                          }
                        ),
                        PinderIconButton(
                          iconData: PinderIcons.heart,
                          iconColor: PinderColors.pink,
                          buttonColor: PinderColors.redpink,
                          onTap: () {
                            this.controller.forward(direction: SwipDirection.Right);
                          }
                        ),
                      ]
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}