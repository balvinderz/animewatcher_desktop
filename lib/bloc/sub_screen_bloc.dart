import 'package:animewatcher_desktop/api/gogoanime_api.dart';
import 'package:animewatcher_desktop/models/anime.dart';
import 'package:flutter/cupertino.dart';

class SubScreenBloc extends ChangeNotifier
{
  BuildContext context;
  List<Anime> animeList;
  bool loading = true;

  Future<void> getAnime()
  async {
    GogoAnimeScraper scraper = GogoAnimeScraper();
    animeList = await scraper.getNewAnimeList();
    loading = false;
    notifyListeners();

  }
}