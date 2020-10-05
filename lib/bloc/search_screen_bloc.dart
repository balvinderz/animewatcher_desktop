
import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/scraper/gogoanime_api.dart';
import 'package:animewatcher_desktop/screens/anime_screen.dart';
import 'package:flutter/material.dart';

class SearchScreenBloc extends ChangeNotifier
{
  BuildContext context;
  GogoAnimeScraper scraper ;
  SearchScreenBloc()
  {
    scraper = GogoAnimeScraper();

  }

  String _searchText;

  set searchText(String value) {
    _searchText = value;
    searchAnime();

  }

  List<Anime> animeList;

  Future<void> searchAnime()
  async {
    animeList = await scraper.searchAnime(_searchText);
    notifyListeners();

  }
  void  selectAnime(Anime anime){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> AnimeScreen(anime)));

  }
}