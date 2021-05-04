import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/models/anime_details.dart';
import 'package:animewatcher_desktop/scraper/gogoanime_api.dart';
import 'package:animewatcher_desktop/widgets/loading_dialog_box.dart';
import 'package:flutter/material.dart';

class AnimeScreenBloc extends ChangeNotifier
{
  BuildContext context;

  AnimeScreenBloc(this.anime);
  Anime anime;
  bool isLoading= true;
  AnimeDetails details;

  Future<void> getDetails() async {
    GogoAnimeScraper scraper = GogoAnimeScraper();
    details = await scraper.getAnimeDetails(anime.link);
    print(details.startEpisode);

    isLoading = false;

    notifyListeners();

  }

  startEpisode(int i) async {
    String link = anime.link.replaceAll("/category", "").replaceAll("org/", "org/watch/")+ "-episode-$i";
    print(link);

    Anime episodeAnime = Anime(link : link,name : anime.name,episodeNo: i.toString(),imageLink: anime.imageLink);

    await showDialog(context: context,builder: (context)=> AlertDialog(content: LoadingDialogBox(episodeAnime),),);
  }
}