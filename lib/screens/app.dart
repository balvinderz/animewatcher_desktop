import 'package:animewatcher_desktop/screens/anime_list_screen.dart';
import 'package:animewatcher_desktop/screens/favourite_screen.dart';
import 'package:animewatcher_desktop/screens/search_screen.dart';
import 'package:animewatcher_desktop/screens/sub_screen.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget
{
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title:Text( "Anime Watcher"),),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: index,
            onDestinationSelected: (index){
              setState(() {
                this.index = index;

              });
            },
            labelType: NavigationRailLabelType.selected,

            destinations: [
              NavigationRailDestination(icon: Icon(Icons.watch_later_rounded,),label: Text("Watch ")),
              // NavigationRailDestination(icon: Icon(Icons.favorite_border),label: Text("Favourite")),
              NavigationRailDestination(icon: Icon(Icons.search),label: Text("Search")),
              NavigationRailDestination(icon: Icon(Icons.list),label: Text("Anime List"))
            ],

          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: IndexedStack(
                index: index,
                children: [
                  SubScreen(),
                  // FavouriteScreen(),
                  SearchScreen(),
                  AnimeListScreen()
                ],
              )
            ),
          )
        ],
      ),
    );

  }
}
