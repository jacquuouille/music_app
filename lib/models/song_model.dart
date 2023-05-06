class Song {
  final String title;
  final String artiste;
  final String url;
  // final String coverUrl;

  Song({
    required this.title, 
    required this.artiste, 
    required this.url, 
    // required this.coverUrl,
  });

  static List<Song> songs = [
    Song(
      title: 'Playbox', 
      artiste: 'Purple Disco Machine', 
      url: 'assets/image/pdm.jpeg', 
      // coverUrl: 
    ), 
    Song(
      title: 'Poppiholla', 
      artiste: 'Chicane', 
      url: 'assets/image/chicane.jpeg', 
      // coverUrl: 
    ), 
    Song(
      title: 'Where The Streets Have No Name', 
      artiste: 'U2', 
      url: 'assets/image/u2.jpg', 
  // coverUrl: 
), 
  ];

}