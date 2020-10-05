import 'package:floor/floor.dart';
@entity
class Favourite
{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String imageUrl;
  final String name;
  final String gogoAnimeUrl;

  Favourite(this.id, this.imageUrl, this.name, this.gogoAnimeUrl);

}
