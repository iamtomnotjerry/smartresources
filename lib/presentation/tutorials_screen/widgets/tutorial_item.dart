import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';
import 'package:video_player/video_player.dart';

class TutorialItem extends StatefulWidget {
  final TutorialModel tutorial;

  const TutorialItem({
    super.key,
    required this.tutorial,
  });

  @override
  State<TutorialItem> createState() => _TutorialItemState();
}

class _TutorialItemState extends State<TutorialItem> {
  // late YoutubePlayerController videoController;
  late VideoPlayerController _videoPlayerController;
  // late ChewieController _chewieController;

  @override
  void initState() {
    // videoController = YoutubePlayerController(
    //   initialVideoId: widget.tutorial.videoId,
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: false,
    //     mute: false,
    //   ),
    // );
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
      widget.tutorial.videoId
    ),)..initialize().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // videoController.dispose();
    _videoPlayerController.dispose();
    // _chewieController.dispose();
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
                    tutorial: widget.tutorial,
                  ),
                ),
              );
            },
            child: SizedBox(
              height: 200,
              width: 350,
              child: _videoPlayerController.value.isInitialized ? VideoPlayer(_videoPlayerController) : const Center(child: Text("Loading..."))
            ),
            // Chewie(controller: _chewieController),
            // Stack(
            //   alignment: Alignment.center,
            //   children: [
            //     ClipRRect(
            //       borderRadius: BorderRadius.circular(16),
            //       child: YoutubePlayer(
            //         controller: videoController,
            //         bottomActions: [
            //           CurrentPosition(),
            //           ProgressBar(isExpanded: true),
            //           RemainingDuration(),
            //         ],
            //       ),
            //     ),
            //     const Positioned(
            //       top: 12,
            //       right: 8,
            //       child: Icon(
            //         Icons.more_vert,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ],
            // ),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TutorialDetailsScreen(
                    tutorial: widget.tutorial,
                  ),
                ),
              );
            },
            child: Text(
              widget.tutorial.title,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: widget.tutorial.avatar.isNotEmpty
                        ? NetworkImage(widget.tutorial.avatar)
                        : AssetImage(ImageConstant.avatarPlaceholder)
                            as ImageProvider,
                    radius: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.tutorial.username,
                    style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    size: 18,
                    color: Colors.blueGrey.shade200,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.tutorial.likes.length.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey.shade500,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: List<Widget>.generate(
              widget.tutorial.materials.length +
                  widget.tutorial.purposes.length,
              (index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blueGrey.shade50,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Text([
                  ...widget.tutorial.materials,
                  ...widget.tutorial.purposes
                ][index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
