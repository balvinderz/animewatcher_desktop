import 'dart:io';
import 'dart:math';

import 'package:animewatcher_desktop/bloc/video_screen_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  final String url;

  VideoScreen(this.url);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
        create: (_) => VideoScreenBloc(url), child: _VideoScreen());
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Platform.isWindows
                        ? Video(
                            playerId: player.id,
                            width: MediaQuery.of(context).size.width,

                            height: MediaQuery.of(context).size.height)
                        : SizedBox(
                            width: _controller.value.size?.width ??
                                MediaQuery.of(context).size.width - 50,
                            height: _controller.value.size?.height ??
                                MediaQuery.of(context).size.height - 100,
                            child: Chewie(
                              controller: _chewieController,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Player player;
  VideoPlayerController _controller;
  String url;

  @override
  void initState() {
    super.initState();

    url = Provider.of<VideoScreenBloc>(context, listen: false).url;
    player = new Player(
        id: Random().nextInt(100000),
        // videoWidth: 480,
        videoHeight: 1024,
        videoWidth: 1920
        // videoHeight: 320,
        );
    asyncMethod();
    if (!Platform.isWindows) {
      _controller = VideoPlayerController.network(url);
      _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          fullScreenByDefault: true,
          allowFullScreen: true,
          looping: true);
      _chewieController.enterFullScreen();
    }
  }

  Future<void> asyncMethod() async {
    await player.add(await Media.network(url));
   await  player.play();
  }

  @override
  void dispose() {
    _controller?.dispose();

    _chewieController?.dispose();
    player?.stop();
    player?.dispose();


    super.dispose();
  }
}
