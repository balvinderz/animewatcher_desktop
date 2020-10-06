import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/scraper/gogoanime_api.dart';
import 'package:animewatcher_desktop/screens/anime_screen.dart';
import 'package:flutter/material.dart';

class AnimeListScreenBloc extends ChangeNotifier
{
  BuildContext context;
  List<Anime> animeList =[];
  bool isLoading = true;
  bool hasMore = true;
  int page =1 ;
  bool _loadingMore =false;

  get loadingMore => _loadingMore;

  set loadingMore(bool loadingMore) {
    _loadingMore = loadingMore;

    notifyListeners();

  }

  Future<void> getAnimeList() async {
    GogoAnimeScraper scraper = GogoAnimeScraper();
    animeList.addAll(await scraper.getAnimeList(page));
    if(animeList.length%136!=0)
      hasMore =false;

    if(page ==1)
      isLoading = false;
    page+=1;

    notifyListeners();


  }
  void selectAnime(int index){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> AnimeScreen(animeList[index])));

  }
}