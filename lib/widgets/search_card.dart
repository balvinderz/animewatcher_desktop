import 'package:animewatcher_desktop/bloc/search_screen_bloc.dart';
import 'package:animewatcher_desktop/database/favorite_db.dart';
import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/models/favourite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchCard extends StatefulWidget
{
  final Anime anime;
  SearchCard(this.anime);

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  SearchScreenBloc bloc;
  FavouriteDatabase database;
  Favourite favourite ;

  @override
  void initState() {
    super.initState();

    $FloorFavouriteDatabase.databaseBuilder('app_database.db').build().then((value)async {
      database = value;
      favourite = await database.favouriteDao.findFavouriteByName(widget.anime.name);

      setState(() {

      });
    });
  }

  final Color colorLight = Color(0xFFE5E1DE);
  bool clicked = false;


  // TODO: implement build
  @override
  Widget build(BuildContext context) {
    Anime anime  = widget.anime;
    bloc = Provider.of(context);
    bloc.context = context;
    return InkWell(
      splashColor: Colors.yellow,
      onTap: ()=> bloc.selectAnime(anime),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Card(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag:  anime.imageLink,
                        child: Image.network(anime.imageLink,fit : BoxFit.cover
                          ,),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right : 15.0,top: 15),
                child: database !=null ? Align(

                  alignment: Alignment.topRight,
                  child: IconButton(icon : Icon(favourite != null  ? Icons.favorite : Icons.favorite_border,size: 30,color: favourite != null  ? Colors.pink : null,),onPressed: () async {
                    if(favourite== null)
                    {
                      await database.favouriteDao.insertFavourite(Favourite(null,anime.imageLink,anime.name,anime.link));
                      favourite = await database.favouriteDao.findFavouriteByName(widget.anime.name);

                    }
                    else {
                      database.favouriteDao.deleteFavourite(favourite);
                      favourite = null;
                    }
                    setState(() {

                    });
                  },),
                ):  Container(),

              ),

              Positioned(
                  bottom: -1,
                  left: -1,
                  right: -1,
                  child: Container(
                    height: 50,
                    color: colorLight.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        anime.name,

                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ))
            ],
          )),
    );

  }
}