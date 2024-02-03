import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class TutorialWidget extends StatelessWidget {
  final String videoId;
  final String title;
  final List<String> materials;
  final String instructions;
  
  TutorialWidget({super.key, required this.videoId, required this.title, required this.materials, required this.instructions});

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
    final YoutubePlayerController videocontroller = _buildYoutubeController();

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TutorialDetailsScreen(
          videoId: videoId,
          title: title,
          materials: materials,
          instructions: instructions
        )));
      },
      child:SizedBox(
      width: 170.h,
      child: Column(
        children: [
          // CustomImageView(
          //   imagePath: ImageConstant.imgUnsplashGgtwjdt6dci,
          //   height: 134.v,
          //   width: 170.h,
          //   radius: BorderRadius.circular(
          //     10.h,
          //   ),
          // ),
          YoutubePlayer(
            controller: videocontroller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            progressColors: ProgressBarColors(
              playedColor: Colors.blue,
              handleColor: Colors.blueAccent,
            )
          ),
          SizedBox(height: 9.v),
          SizedBox(
            width: 170.h,
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: theme.textTheme.titleSmall!.copyWith(
                height: 1.14,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
