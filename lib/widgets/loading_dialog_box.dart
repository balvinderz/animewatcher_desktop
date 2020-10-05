import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/scraper/gogoanime_api.dart';
import 'package:animewatcher_desktop/screens/video_screen.dart';
import 'package:animewatcher_desktop/widgets/psyduck_loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialogBox extends StatefulWidget
{
  final Anime anime;
  LoadingDialogBox(this.anime);

  @override
  _LoadingDialogBoxState createState() => _LoadingDialogBoxState();
}

class _LoadingDialogBoxState extends State<LoadingDialogBox> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(

    mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: Text("Loading Url"),),
        SizedBox(height: 20,),
        PsyduckLoadingIndicator()
      ],
    );

  }

  @override
  void initState() {
    super.initState();
    myAsyncMethod();

  }

  void myAsyncMethod() async {
    GogoAnimeScraper scraper = GogoAnimeScraper();
   String url =  await scraper.getVideoUrl(widget.anime.link);
   print(url);

   await Navigator.push(context, MaterialPageRoute(builder: (_)=> VideoScreen(url)));
   Navigator.pop(context);


  }


}
