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
      backgroundColor: Colors.white,
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
              NavigationRailDestination(icon: Icon(Icons.favorite_border,),label: Text("Sub")),
              NavigationRailDestination(icon: Icon(Icons.favorite_border),label: Text("Dub")),
              NavigationRailDestination(icon: Icon(Icons.download_sharp),label: Text(""))
            ],

          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: SubScreen()

            ),
          )
        ],
      ),
    );

  }
}
