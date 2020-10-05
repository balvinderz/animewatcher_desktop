import 'package:animewatcher_desktop/models/favourite.dart';
import 'package:floor/floor.dart';
@dao
abstract class FavouriteDao
{
  @Query("SELECT * FROM Favourite")
  Stream<List<Favourite>> findAnime();
  @insert
  Future<void> insertFavourite(Favourite favourite);
  @delete
  Future<void> deleteFavourite(Favourite favourite);
  @Query("SELECT * FROM Favourite where name =:name")
  Future<Favourite> findFavouriteByName(String name);

}