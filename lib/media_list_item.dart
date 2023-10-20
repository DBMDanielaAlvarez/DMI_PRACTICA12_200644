import 'package:flutter/material.dart';
import 'package:movieapp_200644/model/Media.dart';

class MediaListItem extends StatelessWidget {
  final Media media;
  MediaListItem(this.media);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          new Container(
            child: new Stack(
              children: <Widget>[
                FadeInImage.assetNetwork(
                  placeholder: "assets/images/placeholder.png",
                  image: media.getBackDroprUrl(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                  fadeInDuration: Duration(milliseconds: 40),
                ),
                new Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(33, 33, 33, 0.8),
                    ),
                    constraints: BoxConstraints.expand(height: 55.00),
                  )
                ),
                new Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        width: 300,
                        child: new Text(
                          media.title,
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 253, 246, 0.8)
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                      new Container(
                        width: 300.0,
                        padding: const EdgeInsets.only(top: 3.0),
                        child: new Text(
                          media.getGenres(),
                          style: new TextStyle(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      )
                    ],
                  )
                ),
                new Positioned(
                  right: 5.0,
                  bottom: 10.0,
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Text(
                            media.voteAverage.toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(255, 253, 246, 0.8)
                            ),
                          ),
                          Container(width: 4.0,),
                          new Icon(Icons.star, color: Colors.white, size: 16.0)
                        ],
                      ),
                      new Container(
                        height: 4.0,
                      ),
                      new Row(
                        children: <Widget>[
                          new Text(
                            media.getReleaseYear().toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(255, 253, 246, 0.8)
                            ),
                          ),
                          new Container(width: 4.0,),
                          new Icon(Icons.date_range, color: Colors.white, size:16.0)
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
