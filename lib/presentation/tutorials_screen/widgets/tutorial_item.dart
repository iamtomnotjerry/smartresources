import 'package:flutter/material.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialItem extends StatefulWidget {
  final String videoId;
  final String title;
  final List<String> materials;
  final String instructions;

  const TutorialItem({
    super.key,
    required this.videoId,
    required this.title,
    required this.materials,
    required this.instructions,
  });

  @override
  State<TutorialItem> createState() => _TutorialItemState();
}

class _TutorialItemState extends State<TutorialItem> {
  late YoutubePlayerController videoController;

  @override
  void initState() {
    videoController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 32,
        top: 24,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.blueGrey.shade50,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TutorialDetailsScreen(
                    videoId: widget.videoId,
                    title: widget.title,
                    materials: widget.materials,
                    instructions: widget.instructions,
                  ),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: YoutubePlayer(
                    controller: videoController,
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(isExpanded: true),
                      RemainingDuration(),
                    ],
                  ),
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TutorialDetailsScreen(
                    videoId: widget.videoId,
                    title: widget.title,
                    materials: widget.materials,
                    instructions: widget.instructions,
                  ),
                ),
              );
            },
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
                radius: 16,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'John Doe',
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: List<Widget>.generate(
              widget.materials.length,
              (index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blueGrey.shade50,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Text(widget.materials[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
