import 'package:flutter/material.dart';
import '../models/playlist_model.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Playlist playlist = Playlist.playlists[0]; // to fit the image playlist
    
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
        appBar: AppBar(
          backgroundColor: Colors.transparent, 
          elevation: 0, 
          title: Text(
            'Playlist',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white,
            )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _PlaylistInformation(playlist: playlist),  
              const SizedBox(height: 30.0), 
              const _PlayOrShuffle(), 
              const SizedBox(height: 5.0), 
              _PlaylistSongs(playlist: playlist)
            ],
          )
        )
      )
    );
  }
}


class _PlaylistSongs extends StatelessWidget {
  const _PlaylistSongs({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: playlist.songs.length, 
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text( // a number
            '${index + 1}', 
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
          title: Text( // a number
            playlist.songs[index].title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: 
            Text(
              '${playlist.songs[index].artiste}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            ), 
            trailing: const Icon(
              Icons.more_vert, 
              color: Colors.white,
            )
        );
      }
    );
  }
}


class _PlayOrShuffle extends StatefulWidget { //Stateful because the mode will be changing (normal or shuffled)
  const _PlayOrShuffle({
    super.key,
  });

  @override
  State<_PlayOrShuffle> createState() => _PlayOrShuffleState();
}

class _PlayOrShuffleState extends State<_PlayOrShuffle> {
  bool isPlay = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: () {
        setState( () {
          isPlay = !isPlay;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 70.0, right: 70.0),
        child: Container(
          height: 50, 
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack( // since we are going to use a container inside play and shuffle
            children: [
              AnimatedPositioned( 
                duration: const Duration(milliseconds: 150), 
                left: isPlay ? 0 : MediaQuery.of(context).size.width  * 0.33, 
                child: Container(
                  height: 50, 
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                  color: Colors.deepPurple, 
                  borderRadius: BorderRadius.circular(15.0), 
                  ), 
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Play',
                              style: TextStyle(
                                color: isPlay ? Colors.white : Colors.deepPurple,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.play_circle,
                          color: isPlay ? Colors.white : Colors.deepPurple,
                        ),
                      ],
                    ),
                  ),
                Expanded( // to both of the Row, put Expanded so it can be well center
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Shuffle',
                          style: TextStyle(
                            color: isPlay ? Colors.deepPurple : Colors.white,
                            fontSize: 17, 
                            fontWeight: FontWeight.bold,
                          ), 
                        ),    
                      ),
                      const SizedBox(width: 10),
                        Icon(
                          Icons.play_circle,
                          color: isPlay ? Colors.deepPurple : Colors.white,
                        ),
                      ],
                  ),
                ),
                ]
              ),
          ],
          ),
        ),
      ),
    );
  }
}


class _PlaylistInformation extends StatelessWidget {
  const _PlaylistInformation({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              playlist.url,
              height: MediaQuery.of(context).size.height * 0.38, 
              width: MediaQuery.of(context).size.height * 0.38, 
              fit: BoxFit.cover,  // to make sure the image cover all the space
              ),
          ),
        ),
        const SizedBox(height: 15.0),
        Text(
          playlist.title, 
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.bold)
        ),
      ],
    );
  }
}