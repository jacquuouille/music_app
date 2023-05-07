import 'package:music_app/models/song_model.dart';

class Playlist {
  final String title;
  final List<Song> songs; 
  final String url;

  Playlist({
    required this.title, 
    required this.songs, 
    required this.url
  });

  static List<Playlist> playlists = [
    Playlist(
      title: 'House', 
      songs: Song.songs, 
      url: 'assets/image/house_music.jpg',
    ),
    Playlist(
      title: 'Chill', 
      songs: Song.songs, 
      url: 'assets/image/chill_music.jpg',
    ),
    Playlist(
      title: 'Focus', 
      songs: Song.songs, 
      url: 'assets/image/focus_music.jpg',
    ),
  ];


}