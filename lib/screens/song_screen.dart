import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import '../widgets/seekbar.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer(); // make sure you convert Stateless into Stateful widget first
  Song song = Get.arguments ?? Song.songs[0]; // to get the picture changing on the song_screen.dart
  // init the Stateful widget
  @override 
    void initState() {
      super.initState();

      // to set up a song
      audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: [
             AudioSource.uri(
               Uri.parse('asset:///${song.coverUrl}'),
             ),
             AudioSource.uri(
               Uri.parse('asset:///${Song.songs[1].coverUrl}'),
             ),
             AudioSource.uri(
               Uri.parse('asset:///${Song.songs[2].coverUrl}'),
             ),
           ],
        ),
      );
    }
    
    // to dispose, so when the user close it, the app will close it as well
    @override
    void dispose() {
      audioPlayer.dispose();
      super.dispose();
    }

    // use 2 different strings and combine them
    Stream<SeekBarData> get _seekBarDataStream => 
    rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>( 
      audioPlayer.positionStream, 
      audioPlayer.durationStream, 
      (Duration position, Duration? duration,) {
        return SeekBarData(position, duration ?? Duration.zero,); // '??' for optional
      }
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            song.url, 
            fit: BoxFit.cover
          ), 
          const _BackgroundFilter(),
          _MusicPlayer(
            seekBarDataStream: _seekBarDataStream, 
            audioPlayer: audioPlayer, 
            song: song,
          ),
        ],
      ),
    );
  }
}


class _MusicPlayer extends StatelessWidget {
  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final Song song;

  const _MusicPlayer({
    super.key,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
    required this.song,
  }) : _seekBarDataStream = seekBarDataStream;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title, 
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            song.artiste, 
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white, 
              // fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 18.0),
          StreamBuilder<SeekBarData>(
            stream:_seekBarDataStream, 
            builder: (context, snapshot) { 
              final positionData = snapshot.data;
              return SeekBar(
                position: positionData?.position ?? Duration.zero, 
                duration: positionData?.duration ?? Duration.zero,
                onChangeEnd: audioPlayer.seek,
                );
            }
          ),
          PlayerButtons(audioPlayer: audioPlayer),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 30, 
                onPressed: () {}, 
                icon: const Icon(
                  Icons.settings, 
                  color: Colors.white,
                ),
              ),
              IconButton(
                iconSize: 30, 
                onPressed: () {}, 
                icon: const Icon(
                  Icons.download, 
                  color: Colors.white,
                )
              )
            ]
          )
        ],
      ),
    );
  }
}

class PlayerButtons extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const PlayerButtons({
    super.key,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // we create a SteamBuilder in order to create other buttons
        //2 . what can be previously listened by the user?
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream, 
          builder: (context, index) {
            return IconButton(
              onPressed: audioPlayer.hasPrevious ? 
              audioPlayer.seekToPrevious : null, 
              iconSize: 45, 
              icon: const Icon(
                Icons.skip_previous, 
                color: Colors.white,
              )
            );
          }
        ),


        // 1. what do the user listen
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState = (playerState! as PlayerState).processingState;

            // if the music is loading or buffering, we show the loading progress feature
            if(processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
              return Container(
                width: 64.0, 
                height: 64.0, 
                margin: const EdgeInsets.all(10.0), 
                child: const CircularProgressIndicator(),
              );

            // if the player is not playing, we return the button 'playing'  
            } else if (!audioPlayer.playing) {
              return IconButton(
                onPressed: audioPlayer.play, 
                iconSize: 75, 
                icon: const Icon(
                  Icons.play_circle, 
                  color: Colors.white,
                ),
              );
            
            // if the music is playing (processing is completing)
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                onPressed: audioPlayer.pause, 
                iconSize: 75.0,
                icon: const Icon(
                    Icons.pause_circle, 
                    color: Colors.white
                  ),
                );

            // when the app has data, but not of the cause above are true 
            // the song is over and the player can play the same song again
            } else {
              return IconButton(
                onPressed: () => audioPlayer.seek(
                  Duration.zero,  // move the current song to 0
                  index: audioPlayer.effectiveIndices!.first,  // the song starts again
                ),
                iconSize: 75.0,
                icon: const Icon(
                  Icons.replay_circle_filled, 
                  color: Colors.white,
                ), 
              );
            } 
            } else {
              return const CircularProgressIndicator();
            }
          }
        ),


        //3 . what can be listened next by the user?
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream, 
          builder: (context, index) {
            return IconButton(
              onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null,
              iconSize: 45, 
              icon: const Icon(
                Icons.skip_next, 
                color: Colors.white,
              )
            );
          }
        ),
      ],
    );
  }
}


//
class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask( 
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter, 
          colors: [
            Colors.white, 
            Colors.white.withOpacity(0.5), 
            Colors.white.withOpacity(0.0),
          ], 
        stops: [0.0, 0.4, 0.6]
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter, 
            colors: [
              Colors.deepPurple.shade200, 
              Colors.deepPurple.shade800,
            ]
          )
        )
      ),
    );
  }
}
