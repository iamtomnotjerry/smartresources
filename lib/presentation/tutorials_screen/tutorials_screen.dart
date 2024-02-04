import 'package:flutter/material.dart' hide SearchBar;
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/data_sources/tutorial/tutorial_source.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/presentation/add_tutorial_screen/add_tutorial_screen.dart';
import 'package:smartresource/widgets/search_bar.dart';

import 'widgets/chip.dart';
import 'widgets/tutorial_item.dart';

const List<String> materials = [
  'Bottles',
  'Plastic',
  'Wood',
  'Metal',
  'Glass',
  'Paper',
  'Cardboard',
];

const List<String> purposes = [
  'Decoration',
  'Storage',
  'Furniture',
  'Lighting',
  'Toys',
  'Stationery',
  'Others',
];

class TutorialsScreen extends StatelessWidget {
  TutorialsScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tutorials',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTutorialScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.add_rounded,
              size: 32,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBar(),
            const SizedBox(height: 32),
            Text(
              "Materials",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: -4,
              spacing: 8,
              children: List<Widget>.generate(
                materials.length,
                (index) => CustomChip(text: materials[index]),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Purposes",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: -4,
              spacing: 8,
              children: List<Widget>.generate(
                purposes.length,
                (index) => CustomChip(text: purposes[index]),
              ),
            ),
            const SizedBox(height: 32),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tutorialsList.length,
              itemBuilder: (context, index) {
                TutorialModel tutorialItem = tutorialsList[index];
                return TutorialItem(
                  videoId: tutorialItem.videoId,
                  title: tutorialItem.title,
                  materials: tutorialItem.materials,
                  instructions: tutorialItem.instructions,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
