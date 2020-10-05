import 'package:animewatcher_desktop/bloc/sub_screen_bloc.dart';
import 'package:animewatcher_desktop/widgets/anime_card.dart';
import 'package:animewatcher_desktop/widgets/psyduck_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_) => SubScreenBloc(),
      child: _SubScreen(),
    );
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
    return bloc.loading
        ? Center(
            child: PsyduckLoadingIndicator(),
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              childAspectRatio: 4/5
            ),
            itemCount: bloc.animeList.length,
            itemBuilder: (_, index) => AnimeCard(bloc.animeList[index])

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
