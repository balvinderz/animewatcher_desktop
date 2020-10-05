import 'package:animewatcher_desktop/bloc/anime_screen_bloc.dart';
import 'package:animewatcher_desktop/database/favorite_db.dart';
import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/models/favourite.dart';
import 'package:animewatcher_desktop/widgets/psyduck_loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimeScreen extends StatelessWidget {
  final Anime anime;

  AnimeScreen(this.anime);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_) => AnimeScreenBloc(anime),
      child: _AnimeScreen(),
    );
  }
}

class _AnimeScreen extends StatefulWidget {
  @override
  __AnimeScreenState createState() => __AnimeScreenState();
}

class __AnimeScreenState extends State<_AnimeScreen> {
  AnimeScreenBloc bloc;

  FavouriteDatabase database;

  Favourite favourite;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    bloc.context = context;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          bloc.anime.name,
        ),
        actions: [
          database == null
              ? Container()
              : IconButton(
                  icon: favourite == null
                      ? Icon(Icons.favorite_border)
                      : Icon(
                          Icons.favorite,
                          color: Colors.pink,
                        ),
                  onPressed: () async {
                    if (favourite == null) {
                      await database.favouriteDao.insertFavourite(Favourite(
                          null,
                          bloc.anime.imageLink,
                          bloc.anime.name,
                          bloc.anime.link));
                      favourite = await database.favouriteDao
                          .findFavouriteByName(bloc.anime.name);
                    } else {
                      database.favouriteDao.deleteFavourite(favourite);
                      favourite = null;
                    }
                    setState(() {});
                  })
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
              tag: bloc.anime.imageLink,
              child: Image.network(
                bloc.anime.imageLink,
                fit: BoxFit.fitHeight,
                height: MediaQuery.of(context).size.height,
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: bloc.isLoading
                    ? PsyduckLoadingIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bloc.details.description),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Episodes"),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: bloc.details.endEpisode -
                                bloc.details.startEpisode +
                                1,
                            itemBuilder: (_, index) => ListTile(
                              onTap: () => bloc.startEpisode(index + 1),
                              title: Text(
                                  "${bloc.anime.name} Episode ${index + 1}"),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    $FloorFavouriteDatabase
        .databaseBuilder('app_database.db')
        .build()
        .then((value) async {
      database = value;
      favourite = await database.favouriteDao.findFavouriteByName(
          Provider.of<AnimeScreenBloc>(context, listen: false).anime.name);
      print(favourite);

      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.getDetails();
    });
  }
}
