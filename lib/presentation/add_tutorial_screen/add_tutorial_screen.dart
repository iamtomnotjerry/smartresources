import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class AddTutorialScreen extends StatefulWidget {
  const AddTutorialScreen({super.key});

  @override
  State<AddTutorialScreen> createState() => _AddTutorialScreenState();
}

class _AddTutorialScreenState extends State<AddTutorialScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();
  final TextEditingController instructionController = TextEditingController();

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
          'Add New Tutorial',
          style: TextStyle(color: theme.colorScheme.primary),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(children: [
              buildFormGroup(
                label: 'Title',
                hintText: 'Tutorial title',
                controller: titleController,
              ),
              buildFormGroup(
                label: 'Youtube Video URL',
                hintText: 'https://www.youtube.com/watch?v=...',
                controller: videoUrlController,
              ),
              buildFormGroup(
                label: 'Instruction',
                hintText: 'Write instruction here',
                controller: instructionController,
                multiple: true,
                minLines: 10,
                maxLines: 1000,
              ),
            ]),
          ),
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
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => {},
          height: 56.v,
          text: "Publish",
          margin: EdgeInsets.only(left: 2.h),
          buttonStyle: CustomButtonStyles.fillPrimary,
          buttonTextStyle:
              CustomTextStyles.titleMediumOnPrimaryContainerSemiBold,
        ),
      ),
    );
  }
}
