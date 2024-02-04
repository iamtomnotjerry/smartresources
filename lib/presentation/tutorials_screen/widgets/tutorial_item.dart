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
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController controller = _buildYoutubeController();

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TutorialDetailsScreen(
                    videoId: videoId,
                    title: title,
                    materials: materials,
                    instructions: instructions)));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          margin: const EdgeInsets.all(0),
          color: theme.colorScheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Container(
            width: 382.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 15.v,
            ),
            decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Column(
              children: [
                Container(
                  child: YoutubePlayer(
                    controller: controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.blue,
                      handleColor: Colors.blueAccent,
                    ),
                    bottomActions: [],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.v),
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 14.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.maxFinite,
                          child: Wrap(
                            runSpacing: 4.89.v,
                            spacing: 4.89.h,
                            children: List<Widget>.generate(
                              materials.length,
                              (index) => Framenine1ItemWidget(
                                materialItem: materials[index],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
