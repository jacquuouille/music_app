import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/playlist_model.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: () {
        Get.toNamed('/playlist', arguments: playlist);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20.0, bottom: 12.0), // space between each container
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        height: 70, 
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade800.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            ClipRRect( 
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                child: Image.asset(playlist.url), 
                height: 60,
                width: 60,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    playlist.title, 
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '${playlist.songs.length} songs', 
                    maxLines: 2, 
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {}, 
              icon: const Icon(
                Icons.play_circle,
                color: Colors.white,
              )
            ),       
         ],
        ),
      ),
    );
  }
}

