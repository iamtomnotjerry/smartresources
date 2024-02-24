import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/core/utils/validation_functions.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';
import 'package:smartresource/providers/auth_provider.dart';
import 'package:smartresource/providers/blogs_provider.dart';
import 'package:smartresource/services/blog_service.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';
import 'package:uuid/uuid.dart';

enum AddBlogAction { add, update }

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({
    super.key,
    this.action = AddBlogAction.add,
    this.blog,
  });

  final AddBlogAction action;
  final BlogModel? blog;

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController thumbnailUrlController = TextEditingController();

  bool isLoading = false;
  File? _imageFile;
  String? _imageUrl;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadImageToStorage(File imageFile) async {
    try {
      final storage = FirebaseStorage.instance;
      final Reference reference = storage.ref().child('blogs/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await reference.putFile(imageFile);
      final imageUrl = await reference.getDownloadURL();
      setState(() {
        _imageUrl = imageUrl;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not upload the image"),
        ),
      );
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.action == AddBlogAction.update) {
      contentController.text = widget.blog!.content;
      titleController.text = widget.blog!.title;
      thumbnailUrlController.text = widget.blog!.thumbnail;
    }
  }

  void onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        final user = Provider.of<MyAuthProvider>(
          context,
          listen: false,
        ).user;

        await uploadImageToStorage(_imageFile!);

        if (user != null) {
          final blog = BlogModel(
            id: widget.action == AddBlogAction.add
                ? const Uuid().v1()
                : widget.blog!.id,
            thumbnail: _imageUrl!,
            title: titleController.text,
            username: user.name,
            content: contentController.text,
            uid: FirebaseAuth.instance.currentUser!.uid,
            avatar: user.avatar,
            likes: widget.action == AddBlogAction.add ? [] : widget.blog!.likes,
            createdAt: widget.action == AddBlogAction.add
                ? DateTime.now().toString()
                : widget.blog!.createdAt,
          );

          if (widget.action == AddBlogAction.add) {
            await BlogsService().addBlog(blog);
          } else {
            await BlogsService().updateBlog(blog);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.action == AddBlogAction.add
                    ? 'Blog added successfully'
                    : 'Blog updated successfully',
              ),
            ),
          );

          setState(() {
            isLoading = false;
          });

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => BlogDetailsScreen(
                blog: blog,
              ),
            ),
          );

          Provider.of<BlogsProvider>(
            context,
            listen: false,
          ).refreshBlogs();
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

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    thumbnailUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.action == AddBlogAction.add ? 'Add New Blog' : 'Update Blog',
          style: TextStyle(color: theme.colorScheme.primary),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onPressed: () => onSubmit(context),
        action: widget.action,
        isLoading: isLoading
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
                    buildFormGroup(
                      label: 'Content',
                      hintText: 'Write your blog content here',
                      controller: contentController,
                      multiple: true,
                      minLines: 5,
                      maxLines: 1000,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter blog content'
                          : null,
                    ),
                     _imageFile != null
                    ? Image.file(
                      _imageFile!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                    : Text("Pick an image for your blog's cover!"),
                    ElevatedButton(
                      onPressed: _getImage,
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), child: Text('Choose image', style: TextStyle(color: Colors.white),),)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildThumbnailInput() {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 24),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           'Thumbnail',
  //           style: TextStyle(
  //             fontWeight: FontWeight.w500,
  //             fontSize: 16,
  //           ),
  //         ),
  //         const SizedBox(height: 4),
  //         AspectRatio(
  //           aspectRatio: 16 / 7,
  //           child: DottedBorder(
  //             color: Colors.blueGrey.shade100,
  //             strokeWidth: 2,
  //             borderType: BorderType.RRect,
  //             radius: const Radius.circular(16),
  //             dashPattern: const [10, 5],
  //             child: Container(
  //               width: double.infinity,
  //               decoration: BoxDecoration(
  //                 color: Colors.blueGrey.shade50,
  //                 borderRadius: BorderRadius.circular(16),
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Icon(
  //                     Icons.add_photo_alternate_outlined,
  //                     size: 48,
  //                     color: Colors.blueGrey.shade100,
  //                   ),
  //                   const SizedBox(height: 16),
  //                   Text(
  //                     'Upload a thumbnail image',
  //                     style: TextStyle(
  //                       color: Colors.blueGrey.shade500,
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w300,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           'Or enter a URL',
  //           style: TextStyle(
  //             color: Colors.blueGrey.shade500,
  //             fontSize: 14,
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         CustomTextFormField(
  //           controller: thumbnailUrlController,
  //           hintText: 'https://www.example.com/thumbnail.jpg',
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    super.key,
    this.onPressed,
    this.action = AddBlogAction.add,
    required this.isLoading
  });

  final VoidCallback? onPressed;
  final AddBlogAction action;
  final bool isLoading;

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
          onPressed: onPressed,
          height: 56.v,
          text: action == AddBlogAction.add ? "Publish" : 'Update',
          margin: EdgeInsets.only(left: 2.h),
          buttonStyle: CustomButtonStyles.fillPrimary,
          buttonTextStyle:
              CustomTextStyles.titleMediumOnPrimaryContainerSemiBold,
        ),
      ),
    );
  }
}
