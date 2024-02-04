import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'framenine1_item_widget.dart';

// ignore: must_be_immutable
class TutorialItem extends StatelessWidget {
  final String videoId;
  final String title;
  final List<String> materials;
  final String instructions;

  TutorialItem({
    super.key,
    required this.videoId,
    required this.title,
    required this.materials,
    required this.instructions,
  });

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
    final YoutubePlayerController controller = _buildYoutubeController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {},
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'http://i3.ytimg.com/vi/$videoId/hqdefault.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Icon(
                Icons.play_circle,
                size: 44,
                color: Colors.white.withOpacity(0.5),
              ),
              const Positioned(
                top: 12,
                right: 8,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {},
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
    );
  }
}
