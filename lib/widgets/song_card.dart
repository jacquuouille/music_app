import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/song_model.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/song', arguments: song);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [ 
          Container(
            margin: const EdgeInsets.only(right: 15.0),
            width: MediaQuery.of(context).size.width * 0.40, 
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                song.url,
              ),
            ),
          ),),
          Padding(
            padding: const EdgeInsets.only(bottom: 21.0, right: 15.0), 
            child: Container(
              height: 53,
              width: MediaQuery.of(context).size.width * 0.40, 
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
              ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                song.title, 
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Colors.deepPurple, 
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                song.artiste, 
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: const Color.fromARGB(255, 38, 0, 0), 
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.play_circle,
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),
              )
            )
          ]
        ),
    );    
    }
}