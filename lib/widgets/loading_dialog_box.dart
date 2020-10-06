import 'dart:io';

import 'package:animewatcher_desktop/models/anime.dart';
import 'package:animewatcher_desktop/scraper/gogoanime_api.dart';
import 'package:animewatcher_desktop/screens/video_screen.dart';
import 'package:animewatcher_desktop/widgets/psyduck_loading_indicator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
   if(Platform.isWindows)
     {

       try {
         Navigator.pop(context);

         final results = await Process.run('vlca', ['$url']).then((
             ProcessResult results) {
           print(results.stdout);
         });
       }catch(e)
    {
      print(e);

      showDialog(context: context,builder: (_)=> AlertDialog(
        title: Text("VLC Not found"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text("Please install vlc from here : "),
                FlatButton(onPressed: () async {
                  if(await canLaunch("https://www.videolan.org/vlc/download-windows.html"))
                    {
                      launch("https://www.videolan.org/vlc/download-windows.html");

                    }
                }, child: Text("VLC",style: TextStyle(color: Colors.blue),))

              ],
            ),
            Row(
              children: [
                Text("Then add it to path by following these "),
                FlatButton(onPressed: () async {
                  if(await canLaunch("https://www.vlchelp.com/add-vlc-command-prompt-windows/"))
                  {
                    launch("https://www.vlchelp.com/add-vlc-command-prompt-windows/");

                  }
                }, child: Text("Instructions",style: TextStyle(color: Colors.blue),))
              ],
            ),

          ],
        ),
      ));
    }
         


     }else {
     await Navigator.push(
         context, MaterialPageRoute(builder: (_) => VideoScreen(url)));
     Navigator.pop(context);
   }

  }


}
