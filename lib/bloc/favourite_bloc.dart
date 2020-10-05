import 'package:animewatcher_desktop/database/favorite_db.dart';
import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/models/favourite.dart';
import 'package:flutter/material.dart';

class FavouriteBloc extends ChangeNotifier
{
  BuildContext context;
  bool isLoading= true;

  List<Favourite> favourites;
  void loadFavourite() async{
    FavouriteDatabase database = await $FloorFavouriteDatabase.databaseBuilder('app_database.db').build();
    favourites = await database.favouriteDao.findAnime();
    isLoading = false;

    notifyListeners();


  }
}