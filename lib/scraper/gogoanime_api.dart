import 'dart:async';
import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/models/anime_details.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import "dart:convert";

String _gogoAnimeUrl = "https://ww.gogoanimes.org";

class GogoAnimeScraper {
  Dio _dio;

  GogoAnimeScraper() {
    _dio = Dio();
  }

  Future<List<Anime>> searchAnime(String text) async {
    if (text.length < 3) return null;

    List<Anime> listOfAnime = new List();
    print(_gogoAnimeUrl + "/search.html?keyword=$text");
    Response response =
        await _dio.get(_gogoAnimeUrl + "/search?keyword=$text");
    print(response.request.uri);
    var searchPage = parse(response.data);

    List<dom.Element> lis = searchPage
        .querySelector("div.main_body")
        .querySelector("div.last_episodes")
        .querySelector("ul.items]")
        .querySelectorAll("li");
    for (dom.Element li in lis) {
      String link =
          _gogoAnimeUrl + li.querySelector("div.img > a").attributes['href'];

      String name = li.querySelector("div.img > a").attributes['title'];

      String imageLink = li.querySelector("div.img >a > img").attributes['src'];

      Anime anime =
          Anime(link: link, name: name, episodeNo: "", imageLink: imageLink);
      listOfAnime.add(anime);
    }
    return listOfAnime;
  }

  Future<AnimeDetails> getAnimeDetails(String baseUrl) async {
    Response response = await _dio.get(baseUrl);
    var animePage = parse(response.data);
    List<dom.Element> lis = animePage
        .querySelectorAll("div.anime_video_body > ul#episode_page > li");
    String summary =
        animePage.querySelectorAll("div.anime_info_body_bg >p.type")[1].text;
    print(summary);
    return AnimeDetails.fromJson({
      'description': summary,
      'start_episode':
          int.parse(lis[0].querySelector("a").attributes['ep_start']) + 1,
      'end_episode':
          int.parse(lis[lis.length - 1].querySelector("a").attributes['ep_end'])
    });

    return null;

    // Elements li = searching.select("div[class=anime_video_body]").select("ul[id=episode_page]").select("li");
    // imagelink = searching.select("div[class=anime_info_body_bg]").select("img").attr("src");
    // summary = searching.select("div[class=anime_info_body_bg]").select("p[class=type]").eq(1).text();
    // String a = String.valueOf(li.select("a").eq(li.size() - 1).html());
  }

  Future<List<Anime>> getNewAnimeList() async {
    List<Anime> listOfAnime = new List();
    //http.Response response = await _client.get(_gogoAnimeUrl);
    Response response = await _dio.get(_gogoAnimeUrl);

    var gogoAnimeBasePage = parse(response.data);
    List<dom.Element> listOfNewAnime = gogoAnimeBasePage
        .querySelectorAll("div.last_episodes > ul.items > li ");
    for (dom.Element newAnime in listOfNewAnime) {
      Anime anime = new Anime();
      dom.Element animeImage = newAnime.querySelector("div.img");

      anime.link =
          _gogoAnimeUrl + animeImage.querySelector("a").attributes['href'];
      anime.name = animeImage.querySelector("a").attributes['title'];
      anime.imageLink = animeImage.querySelector("img").attributes['src'];
      anime.episodeNo = newAnime.querySelector("p.episode").text;
      listOfAnime.add(anime);
    }

    return listOfAnime;
  }

  Future<String> getVideoUrl(String animeEpisodeUrl) async {
    Response response = await Dio().get(animeEpisodeUrl);
    if (response.statusCode == 200) {
      final episodePageDocument = parse(response.data);
      String vidStreamUrl =
          episodePageDocument.querySelector('iframe').attributes['src'];
      vidStreamUrl = vidStreamUrl.replaceAll("streaming.php", "ajax.php");

      response = await _dio.get(vidStreamUrl);
      final json = jsonDecode(response.data);
      return json['source'][0]['file'];
    } else
      return null;
  }

  Future<Iterable<Anime>> getAnimeList(int page) async {
    List<Anime> animeList = [];

    String url = "$_gogoAnimeUrl/anime-list?page=$page";
    print("url is $url");
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      final animeListDocument = parse(response.data);
      List<dom.Element> lis =
          animeListDocument.querySelectorAll("ul.listing > li");
      for (dom.Element element in lis) {
        String link = "$_gogoAnimeUrl" +
            element.querySelector("a").attributes['href'];
        String liHtml = element.attributes['title'];
        final htmlParser = parse(liHtml);
        String imageUrl = htmlParser.querySelector("img").attributes['src'];
        String title = (htmlParser.querySelector("a").text);

        Anime anime =
            Anime(link: link, name: title, episodeNo: "", imageLink: imageUrl);
        animeList.add(anime);
      }
    }
    return animeList;
  }
}
