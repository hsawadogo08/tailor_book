import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';

class AddPhoto extends StatefulWidget {
  final String title;
  const AddPhoto({
    super.key,
    required this.title,
  });

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  XFile? imageFile;

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: source,
        imageQuality: 25,
      );
      if (pickedImage != null) {
        imageFile = pickedImage;
        setState(() {});
      }
    } catch (e) {
      imageFile = null;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kGris,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: (width / 5) * 2,
              child: CustomButton(
                buttonText: "Camera",
                buttonSize: 16,
                pH: 24,
                buttonColor: secondaryColor,
                borderColor: secondaryColor,
                btnTextColor: kWhite,
                buttonFonction: () => getImage(ImageSource.camera),
              ),
            ),
            SizedBox(
              width: (width / 5) * 2,
              child: CustomButton(
                buttonText: "Galerie",
                buttonSize: 16,
                pH: 24,
                buttonColor: primaryColor,
                borderColor: primaryColor,
                btnTextColor: kWhite,
                buttonFonction: () => getImage(ImageSource.gallery),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            children: [
              Container(
                height: height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: primaryColor,
                    width: 4,
                  ),
                ),
                child: imageFile != null
                    ? Image.file(
                        File(imageFile!.path),
                        height: height / 2,
                      )
                    : const Center(
                        child: Icon(
                          Icons.image,
                          size: 256,
                          color: primaryColor,
                        ),
                      ),
              ),
              const SizedBox(
                height: 24,
              ),
              imageFile != null
                  ? CustomButton(
                      buttonText: "Enregistrer",
                      buttonSize: 16,
                      pH: 24,
                      buttonColor: kGreen,
                      borderColor: kGreen,
                      btnTextColor: kWhite,
                      buttonFonction: () => Navigator.pop(context, imageFile),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
