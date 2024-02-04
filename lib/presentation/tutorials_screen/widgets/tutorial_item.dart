import 'package:flutter/material.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';

// ignore: must_be_immutable
class TutorialItem extends StatelessWidget {
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
                    videoId: videoId,
                    title: title,
                    materials: materials,
                    instructions: instructions,
                  ),
                ),
              );
            },
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
          const SizedBox(
            height: 8,
          ),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: List<Widget>.generate(
              materials.length,
              (index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blueGrey.shade50,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Text(materials[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
