import 'package:animewatcher_desktop/bloc/anime_list_screen_bloc.dart';
import 'package:animewatcher_desktop/widgets/psyduck_loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:provider/provider.dart';

class AnimeListScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(create: (_)=> AnimeListScreenBloc(),child: _AnimeListScreen(),);

  }
}

class _AnimeListScreen extends StatefulWidget {
  @override
  __AnimeListScreenState createState() => __AnimeListScreenState();
}

class __AnimeListScreenState extends State<_AnimeListScreen> {
  AnimeListScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    bloc.context =context;

    // TODO: implement build
    return bloc.isLoading ? Center(child: PsyduckLoadingIndicator(),) : IncrementallyLoadingListView(
      hasMore:()=>  bloc.hasMore,
      itemCount:  ()=> bloc.animeList.length,
      loadMore: ()=> bloc.getAnimeList(),
      onLoadMore: (){
        bloc.loadingMore = true;

      },
      itemBuilder: (context,index){
        if(bloc.loadingMore && index == bloc.animeList.length-1)
          return Center(child: PsyduckLoadingIndicator(),);
        return ListTile(
          title: Text(bloc.animeList[index].name),
          onTap : ()=> bloc.selectAnime(index),
        );

      },
      onLoadMoreFinished: (){bloc.loadingMore = false;
      },
    ) ;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.getAnimeList();

    });


  }
}