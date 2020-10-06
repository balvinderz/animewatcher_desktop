import 'package:animewatcher_desktop/bloc/search_screen_bloc.dart';
import 'package:animewatcher_desktop/widgets/anime_card.dart';
import 'package:animewatcher_desktop/widgets/search_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_) => SearchScreenBloc(),
      child: _SearchScreen(),
    );
  }
}

class _SearchScreen extends StatefulWidget {
  @override
  __SearchScreenState createState() => __SearchScreenState();
}

class __SearchScreenState extends State<_SearchScreen> {
  SearchScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    bloc.context = context;

    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (_) {
              bloc.searchText = _;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
          ),
        ),
        bloc.animeList == null
            ? Expanded(
              child: Center(
                  child: Text("Search Anime"),
                ),
            )
            : bloc.animeList.length ==0 ? Center(child: Text("No anime found "),) : Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6, childAspectRatio: 4 / 5),
                    itemCount: bloc.animeList.length,
                    itemBuilder: (_, index) =>
                        SearchCard(bloc.animeList[index])),
              )
      ],
    );
  }
}
