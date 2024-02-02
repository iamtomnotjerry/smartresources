import '../tutorial_details_screen/widgets/framenine2_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:smartresource/widgets/app_bar/custom_app_bar.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialDetailsScreen extends StatelessWidget {
  final String videoId;
  final String title;
  final List<String> materials;
  final String instructions;
  
  TutorialDetailsScreen({
    super.key, 
    required this.videoId, 
    required this.title, 
    required this.materials, 
    required this.instructions
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
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 6.v),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNine(context, controller),
                  SizedBox(height: 15.v),
                  Padding(
                    padding: EdgeInsets.only(left: 2.h),
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 6.v),
                  _buildFrameNine(context),
                  SizedBox(height: 37.v),
                  Padding(
                    padding: EdgeInsets.only(left: 2.h),
                    child: Text(
                      "Instruction",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 14.v),
                  SizedBox(
                    width: 382.h,
                    child: Text(
                      instructions,
                      maxLines: 21,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: CustomTextStyles.bodyLargeBlack900.copyWith(
                        height: 1.50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingIconbutton(
        margin: EdgeInsets.fromLTRB(24.h, 10.v, 370.h, 10.v),
      ),
    );
  }

  /// Section Widget
  Widget _buildNine(BuildContext context, YoutubePlayerController videocontroller) {
    return Container(
      height: 200.v,
      width: 380.h,
      margin: EdgeInsets.only(left: 2.h),
      child: YoutubePlayer(
        controller: videocontroller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        progressColors: ProgressBarColors(
          playedColor: Colors.blue,
          handleColor: Colors.blueAccent,
        )
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameNine(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: Wrap(
        runSpacing: 4.89.v,
        spacing: 4.89.h,
        children: List<Widget>.generate(materials.length, (index) { 
          return Framenine2ItemWidget(materialItem: materials[index]);
        }),
        // children: [
        //   GridView.builder(itemCount: 32, physics: const ScrollPhysics(), shrinkWrap: true, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5), itemBuilder: (context, index) {
        //     return Framenine2ItemWidget(materialItem: materials[index]);
        // })]
      ),
    );
  }
}
