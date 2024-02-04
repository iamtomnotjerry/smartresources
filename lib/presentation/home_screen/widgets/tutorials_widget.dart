import 'package:flutter/material.dart';

class TutorialWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
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
            onTap: onTap,
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
      ),
    );
  }
}
