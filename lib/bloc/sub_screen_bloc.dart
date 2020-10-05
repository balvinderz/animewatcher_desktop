import 'package:animewatcher_desktop/api/gogoanime_api.dart';
import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/widgets/loading_dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Future<void> showLoadingDialog(Anime anime) async {
    await showDialog(context: context,builder: (context)=> AlertDialog(content: LoadingDialogBox(anime),),);

  }
}