import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../tutorial_details_screen/widgets/framenine2_item_widget.dart';

class TutorialDetailsScreen extends StatefulWidget {
  final String videoId;
  final String title;
  final List<String> materials;
  final String instructions;

  const TutorialDetailsScreen({
    super.key,
    required this.videoId,
    required this.title,
    required this.materials,
    required this.instructions,
  });

  @override
  State<TutorialDetailsScreen> createState() => _TutorialDetailsScreenState();
}

class _TutorialDetailsScreenState extends State<TutorialDetailsScreen> {
  late YoutubePlayerController videoController;

  @override
  void initState() {
    videoController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
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
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      },
      player: YoutubePlayer(
        controller: videoController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: theme.colorScheme.primary,
        progressColors: ProgressBarColors(
          playedColor: theme.colorScheme.primary,
          handleColor: theme.colorScheme.primary,
        ),
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          actions: const [
            Icon(Icons.more_vert),
          ],
          title: Text(
            'Tutorial',
            style: TextStyle(
              color: theme.colorScheme.primary,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            player,
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 16,
                    bottom: 96,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        runSpacing: -8,
                        spacing: 8,
                        children: List<Widget>.generate(
                          widget.materials.length,
                          (index) {
                            return Framenine2ItemWidget(
                              materialItem: widget.materials[index],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage('https://picsum.photos/200'),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.thumb_up_outlined,
                                color: appTheme.blueGray200,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '10',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: appTheme.gray600,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.more_vert,
                                color: appTheme.gray600,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Instruction",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 14.v),
                      Text(
                        widget.instructions,
                        maxLines: 21,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          color: appTheme.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
