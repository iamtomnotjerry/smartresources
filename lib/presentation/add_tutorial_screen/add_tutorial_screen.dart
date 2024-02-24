import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';
import 'package:smartresource/providers/auth_provider.dart';
import 'package:smartresource/providers/tutorials_provider.dart';
import 'package:smartresource/services/tutorials_service.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';
import 'package:smartresource/widgets/multi_select.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:smartresource/data/data_sources/tutorial/materials_purposes.dart';

enum AddTutorialAction { add, update }

class AddTutorialScreen extends StatefulWidget {
  const AddTutorialScreen({
    super.key,
    this.action = AddTutorialAction.add,
    this.tutorial,
  });

  final AddTutorialAction action;
  final TutorialModel? tutorial;

  @override
  State<AddTutorialScreen> createState() => _AddTutorialScreenState();
}

class _AddTutorialScreenState extends State<AddTutorialScreen> {
  final formKey = GlobalKey<FormState>();
  File? _videoFile;
  String? _videoUrl;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();
  final TextEditingController instructionController = TextEditingController();

  List<String> selectedMaterials = [];
  List<String> selectedPurposes = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.action == AddTutorialAction.update) {
      titleController.text = widget.tutorial!.title;
      instructionController.text = widget.tutorial!.instructions;
      videoUrlController.text = widget.tutorial!.videoId;
      selectedMaterials = widget.tutorial!.materials;
      selectedPurposes = widget.tutorial!.purposes;
    }
  }

  Future<void> _chooseVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Video upload successfully'),
        ),
      );
    }
  } 

  Future<void> _uploadVideo() async {
    if (_videoFile != null) {
      try {
        final storage = FirebaseStorage.instance;
        final reference = storage.ref().child('videos/${DateTime.now().millisecondsSinceEpoch}.mp4');
        await reference.putFile(_videoFile!);
        final url = await reference.getDownloadURL();
        setState(() {
          _videoUrl = url;
        });
      } catch (error) {
        // Handle upload error
        print('Error uploading video: $error');
      }
    }
  }


  void onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (selectedMaterials.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one material'),
          ),
        );
      } else if (selectedPurposes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one purpose'),
          ),
        );
      } else if (_videoFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please wait until your video successfully uploaded'),
          ),
        );
      } else {
        try {
          setState(() {
            isLoading = true;
          });
          final user = Provider.of<MyAuthProvider>(
            context,
            listen: false,
          ).user;

          // final videoId = YoutubePlayer.convertUrlToId(
          //   videoUrlController.text,
          // );

          // if (videoId == null) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('Invalid youtube video URL'),
          //     ),
          //   );
          //   setState(() {
          //     isLoading = false;
          //   });
          //   return;
          // }
          if (user != null) {
            await _uploadVideo();
            final tutorial = TutorialModel(
              id: widget.action == AddTutorialAction.add
                  ? const Uuid().v1()
                  : widget.tutorial!.id,
              videoId: _videoUrl!,
              title: titleController.text,
              materials: selectedMaterials,
              instructions: instructionController.text,
              purposes: selectedPurposes,
              username: user.name,
              uid: FirebaseAuth.instance.currentUser!.uid,
              avatar: user.avatar,
              likes: widget.action == AddTutorialAction.add
                  ? []
                  : widget.tutorial!.likes,
              createdAt: widget.action == AddTutorialAction.add
                  ? DateTime.now().toString()
                  : widget.tutorial!.createdAt,
            );

            if (widget.action == AddTutorialAction.add) {
              await TutorialService().addTutorial(tutorial);
            } else {
              await TutorialService().updateTutorial(tutorial);
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.action == AddTutorialAction.add
                    ? 'Tutorial added successfully'
                    : 'Tutorial updated successfully'),
              ),
            );

            setState(() {
              isLoading = false;
            });

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => TutorialDetailsScreen(
                  tutorial: tutorial,
                ),
              ),
            );

            Provider.of<TutorialsProvider>(
              context,
              listen: false,
            ).refreshTutorials();
          }
        } catch (e) {
          print('---------------$e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong, please try again later.'),
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    videoUrlController.dispose();
    instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.action == AddTutorialAction.add
              ? 'Add New Tutorial'
              : 'Update Tutorial',
          style: TextStyle(color: theme.colorScheme.primary),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onPressed: () => onSubmit(context),
        action: widget.action,
        isLoading: isLoading,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLoading ? const LinearProgressIndicator() : Container(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildFormGroup(
                      label: 'Title',
                      hintText: 'Tutorial title',
                      controller: titleController,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter tutorial title'
                          : null,
                    ),
                    // buildFormGroup(
                    //   label: 'Youtube Video URL',
                    //   hintText: 'https://www.youtube.com/watch?v=...',
                    //   controller: videoUrlController,
                    //   validator: (value) => value == null || value.isEmpty
                    //       ? 'Please enter youtube video URL'
                    //       : null,
                    // ),
                    MultiSelect(
                      label: 'Materials',
                      selectedItems: selectedMaterials,
                      items: tutorialMaterials,
                      onChange: (values) {
                        setState(() {
                          selectedMaterials = values;
                        });
                      },
                      title: 'Select Materials',
                      hintText: 'Select materials',
                    ),
                    MultiSelect(
                      label: 'Purposes',
                      selectedItems: selectedPurposes,
                      items: tutorialPurposes,
                      onChange: (values) {
                        setState(() {
                          selectedPurposes = values;
                        });
                      },
                      title: 'Select Purposes',
                      hintText: 'Select purposes',
                    ),
                    buildFormGroup(
                      label: 'Instructions',
                      hintText: 'Write tutorial instructions',
                      controller: instructionController,
                      multiple: true,
                      minLines: 5,
                      maxLines: 1000,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter tutorial instructions'
                          : null,
                    ),
                    buildFormVideo(label: "Your video"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormGroup({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool multiple = false,
    int? minLines,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          CustomTextFormField(
            validator: validator,
            controller: controller,
            hintText: hintText,
            textInputType: multiple ? TextInputType.multiline : null,
            maxLines: maxLines,
            minLines: minLines,
            textCapitalization: multiple
                ? TextCapitalization.sentences
                : TextCapitalization.none,
            textInputAction:
                multiple ? TextInputAction.newline : TextInputAction.next,
          ),
        ],
      ),
    );
  }

  Widget buildFormVideo({required String label}) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          ElevatedButton(
            onPressed: _chooseVideo,
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), child: Text('Choose Video', style: TextStyle(color: Colors.white),),)
          ),
        ],
      ),
    );
}
}



class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    super.key,
    this.onPressed,
    this.action = AddTutorialAction.add,
    required this.isLoading
  });

  final VoidCallback? onPressed;
  final AddTutorialAction action;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 24,
          left: 24,
          right: 24,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -4),
              blurRadius: 8,
            ),
          ],
          borderRadius: BorderRadius.circular(32),
        ),
        child: CustomElevatedButton(
          onPressed: onPressed,
          height: 56.v,
          text: action == AddTutorialAction.add ? "Publish" : 'Update',
          margin: EdgeInsets.only(left: 2.h),
          buttonStyle: CustomButtonStyles.fillPrimary,
          buttonTextStyle:
              CustomTextStyles.titleMediumOnPrimaryContainerSemiBold,
        ),
      ),
    );
  }
}
