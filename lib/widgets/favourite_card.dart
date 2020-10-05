import 'package:animewatcher_desktop/bloc/favourite_bloc.dart';
import 'package:animewatcher_desktop/bloc/sub_screen_bloc.dart';
import 'package:animewatcher_desktop/models/favourite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteCard extends StatefulWidget
{
final Favourite favourite;
FavouriteCard(this.favourite);

@override
_FavouriteCardState createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  FavouriteBloc bloc;

  final Color colorLight = Color(0xFFE5E1DE);


  // TODO: implement build
  @override
  Widget build(BuildContext context) {
    Favourite favourite  = widget.favourite;
    bloc = Provider.of(context);
    bloc.context = context;
    return InkWell(
      splashColor: Colors.yellow,
    //  onTap: ()=> bloc.showLoadingDialog(widget.anime),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Card(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(favourite.imageUrl,fit : BoxFit.cover
                        ,),
                    )),
              ),


              Positioned(
                  bottom: -1,
                  left: -1,
                  right: -1,
                  child: Container(
                    height: 50,
                    color: colorLight.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        favourite.name,

                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ))
            ],
          )),
    );

  }
}