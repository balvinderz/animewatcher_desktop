// database.dart

// required package imports
import 'dart:async';
import 'package:animewatcher_desktop/dao/favourite_dao.dart';
import 'package:animewatcher_desktop/models/favourite.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'favorite_db.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Favourite])
abstract class FavouriteDatabase extends FloorDatabase {
  FavouriteDao get favouriteDao;
}