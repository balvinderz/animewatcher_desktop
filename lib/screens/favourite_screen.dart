import 'package:animewatcher_desktop/bloc/favourite_bloc.dart';
import 'package:animewatcher_desktop/widgets/anime_card.dart';
import 'package:animewatcher_desktop/widgets/favourite_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(create: (_)=> FavouriteBloc(),child: _FavouriteScreen(),);

  }
}

class _FavouriteScreen extends StatefulWidget {
  @override
  __FavouriteScreenState createState() => __FavouriteScreenState();
}

class __FavouriteScreenState extends State<_FavouriteScreen> {
  FavouriteBloc bloc;

    @override
    Widget build(BuildContext context) {
      bloc = Provider.of(context);

      // TODO: implement build
      return bloc.isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              childAspectRatio: 4/5
          ),
          itemCount: bloc.favourites.length,
          itemBuilder: (_, index) => FavouriteCard(bloc.favourites[index])

      );
    }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.loadFavourite();

    });

  }
}