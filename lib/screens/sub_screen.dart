import 'package:animewatcher_desktop/bloc/sub_screen_bloc.dart';
import 'package:animewatcher_desktop/bloc/video_screen_bloc.dart';
import 'package:animewatcher_desktop/screens/video_screen.dart';
import 'package:animewatcher_desktop/widgets/loading_dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SubScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(create: (_)=> SubScreenBloc(),child: _SubScreen(),);

  }
}

class _SubScreen extends StatefulWidget {
  @override
  __SubScreenState createState() => __SubScreenState();
}

class __SubScreenState extends State<_SubScreen> {
  SubScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    // TODO: implement build
    return bloc.loading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
      itemCount: bloc.animeList.length,
      itemBuilder: (_,index)=> ListTile(
        title: Text(bloc.animeList[index].name),
        onTap: () async {
          
          await showDialog(context: context,builder: (_)=> AlertDialog(content: LoadingDialogBox(bloc.animeList[index]),),);
        },
      ),
    );


  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.getAnime();

    });

  }
}
