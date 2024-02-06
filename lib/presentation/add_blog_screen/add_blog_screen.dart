import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class AddBlogScreen extends StatelessWidget {
  AddBlogScreen({Key? key}) : super(key: key);

  TextEditingController blogTitleController = TextEditingController();
  TextEditingController thumbnailImageURLController = TextEditingController();
  TextEditingController blogContentController = TextEditingController();

  // Function to add blog post to Firestore
  Future<void> addBlogPost() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser?.displayName);
    try {
      await FirebaseFirestore.instance.collection('blogs').add({
        'title': blogTitleController.text,
        'thumbnail': thumbnailImageURLController.text,
        'content': blogContentController.text,
        'timestamp': Timestamp.now(), // Optionally, you can add a timestamp
        'userEmail': currentUser?.email,
      });
      // Reset the text controllers after successful addition
      blogTitleController.clear();
      thumbnailImageURLController.clear();
      blogContentController.clear();
    } catch (e) {
      print('Error adding blog post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add New Blog',
            style: TextStyle(color: theme.colorScheme.primary),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputWithLabel(context),
              SizedBox(height: 23),
              Text(
                "Thumbnail",
                style: theme.textTheme.headline6,
              ),
              SizedBox(height: 7),
              _buildInput(context),
              SizedBox(height: 9),
              Text(
                "Or import from URL",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 6),
              CustomTextFormField(
                controller: thumbnailImageURLController,
                hintText: "Thumbnail image URL",
              ),
              SizedBox(height: 23),
              Text(
                "Content",
                style: theme.textTheme.headline6,
              ),
              SizedBox(height: 7),
              CustomTextFormField(
                controller: blogContentController,
                hintText: "Blog content...",
                textInputAction: TextInputAction.done,
                maxLines: 7,
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onPressed: addBlogPost), // Passing onPressed callback
      ),
    );
  }

  Widget _buildInputWithLabel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Title",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 7),
        CustomTextFormField(
          controller: blogTitleController,
          hintText: "Blog title",
        ),
      ],
    );
  }

  Widget _buildInput(BuildContext context) {
    return DottedBorder(
      color: Theme.of(context).colorScheme.error,
      padding: EdgeInsets.all(8),
      strokeWidth: 1,
      radius: Radius.circular(12),
      borderType: BorderType.RRect,
      dashPattern: [8, 8],
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.error),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate, size: 48),
            SizedBox(height: 11),
            Text(
              "Choose file to upload",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  final VoidCallback? onPressed; // Callback function to execute on button press
  const BottomNavigationBar({Key? key, this.onPressed}) : super(key: key);

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
          onPressed:
              onPressed, // Call onPressed callback when button is pressed
          height: 56,
          text: "Publish",
          margin: EdgeInsets.zero,
          // Add your button styles here
        ),
      ),
    );
  }
}
