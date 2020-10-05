import 'package:animewatcher_desktop/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreenBloc extends ChangeNotifier
{
  BuildContext context;
  String  url ;
  VideoScreenBloc(this.url );
  bool isLoading = true;
  VideoPlayerController controller;










  }
