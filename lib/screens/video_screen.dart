import 'package:animewatcher_desktop/bloc/video_screen_bloc.dart';
import 'package:animewatcher_desktop/models/anime.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  final String  url;

  VideoScreen(this.url );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
        create: (_) => VideoScreenBloc(url ), child: _VideoScreen());
  }
}

class _VideoScreen extends StatefulWidget {
  @override
  __VideoScreenState createState() => __VideoScreenState();
}

class __VideoScreenState extends State<_VideoScreen> {
  VideoScreenBloc bloc;

  ChewieController _chewieController;

  TargetPlatform _platform;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animewatcher"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SizedBox.expand(

                child: FittedBox(
                  fit: BoxFit.cover,

                  child: SizedBox(
                    width: _controller.value.size?.width ?? MediaQuery.of(context).size.width-50,
                    height: _controller.value.size?.height ?? MediaQuery.of(context).size.height-100,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }


  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
   String url =  Provider.of<VideoScreenBloc> (context,listen: false).url;

    _controller = VideoPlayerController.network(
      url );
    _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        fullScreenByDefault: true,
        allowFullScreen: true,

        looping: true);


  }

  @override
  void dispose() {
    _controller.dispose();

    _chewieController.dispose();
    super.dispose();
  }
}
