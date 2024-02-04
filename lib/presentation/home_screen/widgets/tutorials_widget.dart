import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class TutorialWidget extends StatelessWidget {
  final String videoId;
  final String title;
  final List<String> materials;
  final String instructions;
  Function()? onTap;

  TutorialWidget(
      {super.key,
      required this.videoId,
      required this.title,
      required this.materials,
      required this.instructions,
      required this.onTap});

  YoutubePlayerController _buildYoutubeController() {
    return YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController videocontroller = _buildYoutubeController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: YoutubePlayer(
                        controller: videocontroller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.blueAccent,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.blue,
                          handleColor: Colors.blueAccent,
                        )),
                  ),
                ),
                const Positioned(
                  top: 12,
                  right: 8,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
