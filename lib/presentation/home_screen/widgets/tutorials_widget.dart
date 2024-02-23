import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class TutorialWidget extends StatefulWidget {
  final String videoId;
  final String title;
  final List<String> materials;
  final String instructions;
  Function()? onTap;

  TutorialWidget({
    super.key,
    required this.videoId,
    required this.title,
    required this.materials,
    required this.instructions,
    required this.onTap,
  });

  @override
  State<TutorialWidget> createState() => _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> {
  late YoutubePlayerController videoController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    videoController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
      widget.videoId))..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: widget.onTap,
            child: Container(
              height: 200,
              width: 350,
              child: _videoPlayerController.value.isInitialized ? VideoPlayer(_videoPlayerController) : const Center(child: Text("Loading..."))
            // VideoPlayer(_videoPlayerController)
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
          )),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: widget.onTap,
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
        ],
      ),
    );
  }
}
