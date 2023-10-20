import 'package:flutter/material.dart';
import 'package:movieapp_200644/media_list.dart';
import 'package:movieapp_200644/common/MediaProvider.dart';
import 'package:movieapp_200644/model/Media.dart';
import 'package:movieapp_200644/common/HttpHandler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  final MediaProvider movieProvider = new MovieProvider();
  final MediaProvider showProvider = new ShowProvider();
  PageController? _pageController;
  int _page = 0;

  MediaType mediaType = MediaType.movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Movie App -- M-200644",
            style: TextStyle(
              fontFamily: 'AmaticSC',
              color: Color.fromRGBO(255, 253, 243, 50),
              fontSize: 30,
            )),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Color.fromRGBO(26, 27, 67, 50),
      ),
      drawer: new Drawer(
          child: new Container(
        color: Color.fromRGBO(144, 133, 173, 0.9),
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Color.fromRGBO(33, 33, 33, 0.5),
                    fontSize: 24,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/fondoDrawerHeader.jpg'),
                      fit: BoxFit.cover)),
            ),
            new ListTile(
              title: new Text(
                "Peliculas",
                style: TextStyle(
                    fontFamily: 'MontserratAlternates',
                    color: Color.fromRGBO(255, 253, 243, 50)),
              ),
              selected: mediaType == MediaType.movie,
              trailing: new Icon(
                Icons.local_movies,
                color: Color.fromRGBO(255, 253, 243, 50),
              ),
              onTap: () {
                _changeMediaType(MediaType.movie);
                Navigator.of(context).pop();
              },
            ),
            new Divider(
              height: 5.0,
            ),
            new ListTile(
              title: new Text(
                "Televisión",
                style: TextStyle(
                    fontFamily: 'MontserratAlternates',
                    color: Color.fromRGBO(255, 253, 243, 50)),
              ),
              selected: mediaType == MediaType.show,
              trailing: new Icon(
                Icons.live_tv,
                color: Color.fromRGBO(255, 253, 243, 50),
              ),
              onTap: () {
                _changeMediaType(MediaType.show);
                Navigator.of(context).pop();
              },
            ),
            new Divider(
              height: 5.0,
            ),
            new ListTile(
              title: new Text(
                "Cerrar",
                style: TextStyle(
                    fontFamily: 'MontserratAlternates',
                    color: Color.fromRGBO(255, 253, 243, 50)),
              ),
              trailing: new Icon(
                Icons.close,
                color: Color.fromRGBO(255, 253, 243, 50),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      )),
      body: new PageView(
        children: _getMediaList(),
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: _getFooterItems(),
        selectedItemColor: Color.fromRGBO(255, 219, 250, 0.855),
        unselectedItemColor: Color.fromRGBO(80, 80, 80, 1),
        backgroundColor: Color.fromRGBO(26, 27, 67, 50),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  List<BottomNavigationBarItem> _getFooterItems() {
    return mediaType == MediaType.movie? [
      new BottomNavigationBarItem(
        icon: Icon(Icons.thumb_up),
        label: "Populares",
      ),
      new BottomNavigationBarItem(
        icon: Icon(Icons.update), 
        label: "Proximamente"),
      new BottomNavigationBarItem(
        icon: Icon(Icons.star), 
        label: "Favoritos")
    ]:[
      new BottomNavigationBarItem(
        icon: Icon(Icons.thumb_up),
        label: "Populares",
      ),
      new BottomNavigationBarItem(
        icon: Icon(Icons.update), 
        label: "Al aire"),
      new BottomNavigationBarItem(
        icon: Icon(Icons.star), 
        label: "Favoritos")
    ];
  }

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie)
        ? <Widget>[
            new MediaList(movieProvider, "popular"),
            new MediaList(movieProvider, "upcoming"),
            new MediaList(movieProvider, "top_rated"),
          ]
        : <Widget>[
            new MediaList(showProvider, "popular"),
            new MediaList(showProvider, "on_the_air"),
            new MediaList(showProvider, "top_rated"),
          ];
  }

  void _navigationTapped(int page) {
    _pageController?.animateToPage(page,
        duration: const Duration(milliseconds: 3000), curve: Curves.ease);
  }
}
