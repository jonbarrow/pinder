import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinder/assets.dart';
import 'package:pinder/pinder_icons_icons.dart';
import 'package:pinder/widgets/icon_button.dart';

class PinderAnimalCard extends StatelessWidget {
  final Map<String, dynamic> metadata;
  final void Function() onDislikeTap;
  final void Function() onDetailsTap;
  final void Function() onLikeTap;

  late String name = 'Pet Name';
  late String imageUrl;

  PinderAnimalCard({required this.metadata, required this.onDislikeTap, required this.onDetailsTap, required this.onLikeTap});

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
            color: Colors.black12,
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
                      placeholder: (context, url) => CircularProgressIndicator(),
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
                        PinderIconButton(iconData: PinderIcons.times_circle, iconColor: PinderColors.red, buttonColor: Colors.white, onTap: this.onDislikeTap),
                        PinderIconButton(iconData: PinderIcons.info_circle, iconColor: PinderColors.darkblue, buttonColor: Colors.white, onTap: this.onDetailsTap),
                        PinderIconButton(iconData: PinderIcons.heart, iconColor: PinderColors.pink, buttonColor: Colors.white, onTap: this.onLikeTap),
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