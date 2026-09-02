import 'dart:io';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/common/ui/widgets/secondary_button.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  File? coverImage;
  bool isAgreed = false;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        coverImage = File(image.path);
      });
    }
  }

  void _submit() {
    if (titleController.text.trim().isEmpty) {
      _showMessage('Please enter title');
      return;
    }

    if (contentController.text.trim().isEmpty) {
      _showMessage('Please write your article');
      return;
    }

    if (!isAgreed) {
      _showMessage('Please accept the agreement');
      return;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: const CustomAppBar(title: 'Write a Blog'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Share your experience with the group. Your submission goes '
              'to admin for review before it\'s published — you\'ll earn '
              'points once it\'s approved.',
              style: customTextStyle(
                fontSize: Responsive.sp(10.5),
                color: Colors.grey.shade700,
              ).copyWith(height: 1.5),
            ),

            height(24),

            CustomTextField(
              label: 'Subject Line / Title',
              controller: titleController,
              hint:
                  'e.g. Documenting Telemedicine Consults for Medico‑Legal Defensibility',
            ),
            height(22),
            Row(
              children: [
                Text(
                  'Add Image',
                  style: customTextStyle(
                    fontSize: Responsive.sp(12),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                width(10),
                Text(
                  'Optional',
                  style: customTextStyle(
                    fontSize: Responsive.sp(10.5),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            height(10),
            _buildImagePicker(),
            height(22),
            CustomTextField(
              label: 'Your Article',
              controller: contentController,
              hint:
                  'Share the case context, what you learned, and how it could help a peer facing something similar.',
              maxLines: 10,
            ),
            height(18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: isAgreed,
                  activeColor: AppColors.newPri,
                  onChanged: (value) {
                    setState(() {
                      isAgreed = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'I agree to share this content within the DoctorsRisk '
                      'community for publishing and viewing purposes among '
                      'my medical peers.',
                      style: customTextStyle(
                        fontSize: Responsive.sp(10.5),
                        color: Colors.grey.shade700,
                      ).copyWith(height: 1.45),
                    ),
                  ),
                ),
              ],
            ),

            height(14),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderGrey),
                // color: AppColors.newPri.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 19,
                    color: AppColors.newPri,
                  ),
                  width(8),
                  Expanded(
                    child: Text(
                      'All submissions are reviewed by our medico-legal '
                      'experts and may be lightly edited for accuracy or '
                      'clarity before publishing, for your protection. To '
                      'request removal of a submission, please raise a '
                      'ticket with Service Support in the Support Hub, '
                      'or contact our helpline.',
                      style: customTextStyle(
                        fontSize: Responsive.sp(10.5),
                        color: AppColors.textColor,
                      ).copyWith(height: 1.5),
                    ),
                  ),
                ],
              ),
            ),

            height(25),

            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    onPressed: () => Navigator.pop(context),
                    text: 'Cancel',
                  ),
                ),
                width(12),
                Expanded(
                  child: PrimaryButton(
                    borderRadius: 25,
                    fontSize: 14,
                    text: 'Submit for Review',
                    backgroundColor: AppColors.newPri,
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
            SocialLinkWidget(),
            height(30),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    if (coverImage == null) {
      return InkWell(
        onTap: _pickImage,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: Responsive.h(160),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_outlined, color: AppColors.newPri, size: 42),
              height(8),
              Text(
                'Upload Image',
                style: customTextStyle(
                  color: AppColors.newPri,
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.sp(12),
                ),
              ),
              height(3),
              Text(
                'Add a cover image to make your article stand out',
                textAlign: TextAlign.center,
                style: customTextStyle(
                  color: Colors.grey.shade600,
                  fontSize: Responsive.sp(10),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            coverImage!,
            width: double.infinity,
            height: Responsive.h(160),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () {
              setState(() {
                coverImage = null;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
