import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/providers/auth_provider.dart';
import 'package:smartresource/services/product_service.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';
import 'dart:developer' as devtools show log;

import 'package:uuid/uuid.dart';

class AddPrpdcutScreen extends StatefulWidget {
  const AddPrpdcutScreen({super.key, this.product});

  final ProductModel? product;

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddPrpdcutScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;

  TextEditingController nameInputController = TextEditingController();

  TextEditingController priceInputController = TextEditingController();

  TextEditingController productDescriptionInputController =
      TextEditingController();

  // TextEditingController thumbnailImageURLInputController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<File> selectedImages = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void addProduct(BuildContext context) async {
    List<String> imageUrls = [];
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('${currentUser!.email}');

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final user = Provider.of<MyAuthProvider>(context, listen: false).user;

        if (user != null) {
          for (File image in selectedImages) {
            String uniqueFileName =
                DateTime.now().millisecondsSinceEpoch.toString();
            Reference referenceImageToUpload =
                referenceDirImages.child(uniqueFileName);

            await referenceImageToUpload.putFile(image);

            String imageUrl = await referenceImageToUpload.getDownloadURL();
            imageUrls.add(imageUrl);
          }
          final product = ProductModel(
            prodname: nameInputController.text,
            description: productDescriptionInputController.text,
            userEmail: user.email,
            price: priceInputController.text,
            images: imageUrls,
            id: const Uuid().v1(),
            createdAt: DateTime.now().toString(),
          );

          await ProductService().addProduct(product);
          // await FirebaseFirestore.instance.collection('products').add({
          //   'prodName': nameInputController.text,
          //   'price': priceInputController.text,
          //   'description': productDescriptionInputController.text,
          //   'images': imageUrls,
          //   'timestamp': Timestamp.now(),
          //   'userEmail': currentUser?.email,
          // });

          nameInputController.clear();
          priceInputController.clear();
          productDescriptionInputController.clear();
          // thumbnailImageURLInputController.clear();
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pop();
        }
      } catch (e) {
        await showErrorDialog(context, e.toString());
      }
    }
  }

  Future<void> pickImages() async {
    try {
      List<XFile>? pickedImages =
          await ImagePicker().pickMultiImage(imageQuality: 50);
      setState(() {
        selectedImages = pickedImages.map((image) => File(image.path)).toList();
      });
    } catch (e) {
      devtools.log('Error picking images: $e');
    }
  }

  @override
  void dispose() {
    nameInputController.dispose();
    priceInputController.dispose();
    productDescriptionInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
        "Add New Product",
        style: theme.textTheme.titleLarge,
      )),
      body: SizedBox(
        width: SizeUtils.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 37.v),
                  _buildInputWithLabel(context),
                  SizedBox(height: 23.v),
                  _buildInputWithLabel1(context),
                  SizedBox(height: 24.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "Description",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.v),
                  _buildProductDescriptionInput(context),
                  SizedBox(height: 8.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "Images",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.v),
                  _buildImageInput(context),
                  // SizedBox(height: 9.v),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: 24.h),
                  //     child: Text(
                  //       "Or import from URL",
                  //       style: CustomTextStyles.bodyMediumGray600,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 6.v),
                  // _buildFrame(context),
                  SizedBox(height: 22.v),
                  _buildBottomNavigation(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNameInput(BuildContext context) {
    return CustomTextFormField(
      controller: nameInputController,
      hintText: "Product name",
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter product name' : null,
    );
  }

  /// Section Widget
  Widget _buildInputWithLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 7.v),
          _buildNameInput(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPriceInput(BuildContext context) {
    return CustomTextFormField(
      textInputType: const TextInputType.numberWithOptions(decimal: true),
      controller: priceInputController,
      hintText: "Product price",
      validator: (value) => value == null || value.isEmpty
          ? "Please enter product's price"
          : null,
    );
  }

  /// Section Widget
  Widget _buildInputWithLabel1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 7.v),
          _buildPriceInput(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProductDescriptionInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: CustomTextFormField(
        controller: productDescriptionInputController,
        hintText: "Product description",
        maxLines: 10,
      ),
    );
  }

  /// Section Widget
  Widget _buildImageInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: DottedBorder(
        color: theme.colorScheme.onError,
        padding: EdgeInsets.only(
          left: 1.h,
          top: 1.v,
          right: 1.h,
          bottom: 1.v,
        ),
        strokeWidth: 1.h,
        radius: const Radius.circular(12),
        borderType: BorderType.RRect,
        dashPattern: const [
          8,
          8,
        ],
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 119.h,
            vertical: 38.v,
          ),
          decoration: AppDecoration.outlineOnError.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomImageView(
              //   imagePath: ImageConstant.imgCalendarOnerror,
              //   height: 48.adaptSize,
              //   width: 48.adaptSize,
              // ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: selectedImages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    selectedImages[index],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                },
              ),
              SizedBox(height: 11.v),
              TextButton(
                onPressed: () {
                  pickImages();
                },
                child: Text(
                  "Choose file to upload",
                  style: CustomTextStyles.bodyMediumBluegray200,
                ),
                // style: CustomTextStyles.bodyMediumBluegray200,
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () async {
              //     File? imageFile = await _pickImage(ImageSource.gallery);
              //     if (imageFile != null) {
              //       await _uploadImageAndSaveURL(imageFile);
              //       devtools.log('Image uploaded successfully!');
              //     }
              //   },
              //   child: Text('Upload Image from library', style: TextStyle(color: Colors.white)),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  // Widget _buildThumbnailImageURLInput(BuildContext context) {
  //   return Expanded(
  //     child: CustomTextFormField(
  //       controller: thumbnailImageURLInputController,
  //       hintText: "Thumbnail image URL",
  //       textInputAction: TextInputAction.done,
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildLoadButton(BuildContext context) {
    return CustomElevatedButton(
      height: 44.v,
      width: 72.h,
      text: "Load",
      margin: EdgeInsets.only(
        left: 8.h,
        top: 6.v,
        bottom: 6.v,
      ),
      buttonStyle: CustomButtonStyles.fillPrimaryTL12,
      buttonTextStyle: CustomTextStyles.titleSmallOnPrimaryContainer_1,
    );
  }

  /// Section Widget
  // Widget _buildFrame(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 24.h),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         _buildThumbnailImageURLInput(context),
  //         _buildLoadButton(context),
  //       ],
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildPublishButton(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    return CustomElevatedButton(
      onPressed: () {
        addProduct(context);
      },
      text: "Publish",
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2.h),
      padding: EdgeInsets.symmetric(
        horizontal: 23.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.v),
          _buildPublishButton(context),
        ],
      ),
    );
  }
}

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('An error occur'),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        );
      });
}

Future<String> uploadImageToFirebaseStorage(File imageFile) async {
  try {
    // Create a unique filename for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('images/$fileName.jpg');

    // Upload image to Firebase Storage
    await reference.putFile(imageFile);

    // Get the download URL
    String downloadURL = await reference.getDownloadURL();

    return downloadURL;
  } catch (e) {
    devtools.log(e.toString());
    return '';
  }
}
