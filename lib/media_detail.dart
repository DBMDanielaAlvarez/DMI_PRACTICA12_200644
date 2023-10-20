import 'package:flutter/material.dart';
import 'package:movieapp_200644/model/Media.dart';

class MediaDetail extends StatelessWidget {
  final Media media;
  MediaDetail(this.media);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.network(
            media.getBackDroprUrl(),
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
