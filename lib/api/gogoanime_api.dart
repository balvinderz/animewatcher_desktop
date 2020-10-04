import 'dart:async';
import 'package:animewatcher_desktop/models/anime.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import "dart:convert";

String _gogoAnimeUrl = "https://www25.gogoanimes.tv/";

class GogoAnimeScraper
{
  Dio _dio;
  GogoAnimeScraper()
  {
    _dio = Dio();


  }
  Future<List<Anime>> getNewAnimeList() async
  {
    List<Anime> listOfAnime = new List();
    //http.Response response = await _client.get(_gogoAnimeUrl);
    Response response = await _dio.get(_gogoAnimeUrl);


    var gogoAnimeBasePage  = parse(response.data);
    List<dom.Element> listOfNewAnime  = gogoAnimeBasePage.querySelectorAll("div.last_episodes > ul.items > li ");
    for(dom.Element newAnime in listOfNewAnime)
    {
      Anime anime = new Anime();
      dom.Element animeImage = newAnime.querySelector("div.img");

      anime.link = _gogoAnimeUrl+ animeImage.querySelector("a").attributes['href'];
      anime.name = animeImage.querySelector("a").attributes['title'];
      anime.imageLink = animeImage.querySelector("img").attributes['src'];
      anime.episodeNo =  newAnime.querySelector("p.episode").text ;
      listOfAnime.add(anime);

    }

    return listOfAnime;
  }
  Future<String> getVideoUrl(String animeEpisodeUrl) async{
    Response response = await Dio().get(animeEpisodeUrl);
    if(response.statusCode ==200) {
      //  print(response.statusCode);
      final episodePageDocument = parse(response.data);
      String vidStreamUrl = "https:" + episodePageDocument
          .querySelector('iframe')
          .attributes['src'];
      vidStreamUrl = vidStreamUrl.replaceAll("streaming.php","ajax.php");

      response = await _dio.get(vidStreamUrl);
     final json =  jsonDecode(response.data);
      print(json['source'][0]['file']);
      return json['source'][0]['file'];

    }
    else
      return null;

  }

}
