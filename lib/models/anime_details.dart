class AnimeDetails {
  final String description;
  final int startEpisode;
  final int endEpisode;

  AnimeDetails.fromJson(Map json)
      : description = json['description'] ?? "",
        startEpisode = json['start_episode'] ?? 0,
        endEpisode = json['end_episode'] ?? 0;
}
