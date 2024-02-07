import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/presentation/add_tutorial_screen/add_tutorial_screen.dart';
import 'package:smartresource/services/tutorials_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../tutorial_details_screen/widgets/framenine2_item_widget.dart';

class TutorialDetailsScreen extends StatefulWidget {
  final TutorialModel tutorial;

  const TutorialDetailsScreen({
    super.key,
    required this.tutorial,
  });

  @override
  State<TutorialDetailsScreen> createState() => _TutorialDetailsScreenState();
}

class _TutorialDetailsScreenState extends State<TutorialDetailsScreen> {
  late YoutubePlayerController videoController;

  @override
  void initState() {
    videoController = YoutubePlayerController(
      initialVideoId: widget.tutorial.videoId,
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
          actions: [
            widget.tutorial.uid == FirebaseAuth.instance.currentUser!.uid
                ? PopupMenuButton(
                    offset: const Offset(0, 56),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTutorialScreen(
                                action: AddTutorialAction.update,
                                tutorial: widget.tutorial,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete Tutorial'),
                                content: const Text(
                                  'Are you sure you want to delete this tutorial?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      TutorialService().deleteTutorial(
                                        widget.tutorial.id,
                                      );
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  )
                : const Icon(Icons.more_vert),
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
                        widget.tutorial.title,
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
                          widget.tutorial.materials.length +
                              widget.tutorial.purposes.length,
                          (index) {
                            return Framenine2ItemWidget(
                              materialItem: [
                                ...widget.tutorial.materials,
                                ...widget.tutorial.purposes
                              ][index],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    widget.tutorial.avatar.isNotEmpty
                                        ? NetworkImage(widget.tutorial.avatar)
                                        : AssetImage(
                                                ImageConstant.avatarPlaceholder)
                                            as ImageProvider,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.tutorial.username,
                                style: const TextStyle(
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
                                widget.tutorial.likes.length.toString(),
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
                      const SizedBox(height: 8),
                      Text(
                        widget.tutorial.instructions,
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
