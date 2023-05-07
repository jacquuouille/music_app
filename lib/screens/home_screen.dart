import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../models/song_model.dart';
import '../widgets/playlist_card.dart';
import '../widgets/section_header.dart';
import '../widgets/song_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Song.songs;
    List<Playlist> playlists = Playlist.playlists;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8), 
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, 
        appBar: const _CustomAppBar(),
        bottomNavigationBar: const _CustomNavBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome", 
                  style: Theme.of(context)
                    .textTheme
                    .bodyLarge,
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    "Enjoy your favorite music", 
                    style: Theme.of(context)
                    .textTheme
                    .headline6
                    !.copyWith(fontWeight: FontWeight.bold)
                  ), 
                  const SizedBox(height: 20.0), 
                  const _DiscoverMusic(),
                  const SizedBox(height: 40.0),
                  const SectionHeader(
                    title: 'Trending Music'
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.23, 
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, 
                      itemCount: songs.length, 
                      itemBuilder: (context, index) {
                        return SongCard(song: songs[index]); // don't forget to declare the widget inside widget/widgets.dart
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const SectionHeader(
                    title: 'Playlists'
                  ),
                  const SizedBox(height: 20.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // because we are using a single scrollview
                    scrollDirection: Axis.vertical,
                    itemCount: playlists.length, 
                    itemBuilder: ((context, index) {
                      return PlaylistCard(playlist: playlists[index]);
                    })
                  )
                ],
              ),
           ),
        ),
      ),
    );
  }
}



// 3. SEARCH BAR
class _DiscoverMusic extends StatelessWidget {
  const _DiscoverMusic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          isDense: true, 
          filled: true, 
          fillColor: Colors.white, 
          hintText: 'Search', 
          hintStyle: Theme.of(context)
            .textTheme 
            .bodyMedium!
            .copyWith(color: Colors.grey.shade400), 
          prefixIcon: 
            Icon(Icons.search,
            color: Colors.grey.shade400 
          ), 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0), 
            borderSide: BorderSide.none,
          )
        )
      ),
    );
  }
}


// 2.CUSTOM BOTTOM NAVIGATION BAR
class _CustomNavBar extends StatelessWidget {
  const _CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepPurple.shade800,
      unselectedItemColor: Colors.white, 
      selectedItemColor: Colors.white,
      showUnselectedLabels: false, 
      // showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home), 
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline), 
          label: 'Favourites'
        ), 
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_outline), 
          label: 'Play'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), 
          label: 'Profile'
        ),
      ]
    );
  }
}


// 1.CUSTOM HEADING BAR
class _CustomAppBar extends StatelessWidget with PreferredSizeWidget { // we need to put the operator 'with', otherwise there will be an error
  const _CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        leading: const Icon(Icons.menu), 
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0), // to separate the CircleAvatar from the right border
            child: CircleAvatar(
              child: Image.asset('assets/image/my_avatar.png'),
            )
          )
        ]
      ),
    );
  }
  
  @override // click sur '_CustomAppBar' to create it
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0); // to define the the bar on top



}