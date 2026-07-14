import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/secondary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../features/common/ui/widgets/primary_button.dart';
import '../../../theme/app_colors.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final titleController = TextEditingController();
  final summaryController = TextEditingController();
  final contentController = TextEditingController();

  String? category;
  String visibility = "Public";
  bool allowComments = true;

  final List<String> categories = [
    "Medical",
    "Medico Legal",
    "Insurance",
    "Clinical Tips",
    "Case Study",
    "Career",
    "Awareness",
    "Other",
  ];

  final List<String> tags = [
    "Medical",
    "Insurance",
    "Doctors",
    "Healthcare",
    "Legal",
  ];

  final List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: const CustomAppBar(title: "Add Blog"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cover Image",
              style: customTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.sp(12),
              ),
            ),
            height(10),
            InkWell(
              onTap: () {},
              child: Container(
                height: Responsive.h(180),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      color: AppColors.newPri,
                      size: 55,
                    ),
                    height(10),
                    Text(
                      "Upload Cover Image",
                      style: customTextStyle(
                        color: AppColors.newPri,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Tap to choose image",
                      style: customTextStyle(
                        color: Colors.grey,
                        fontSize: Responsive.sp(11),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            height(25),
            CustomTextField(
              controller: titleController,
              label: "Blog Title",
              hint: "Enter blog title",
            ),
            height(18),
            CustomDropdownField(
              label: 'Category',
              hint: 'Select Category',
              items: categories,
              onChanged: (v) {
                setState(() {
                  category = v;
                });
              },
            ),
            height(18),
            CustomTextField(
              controller: summaryController,
              label: "Short Summary",
              hint: "Write short description",
              maxLines: 3,
            ),
            height(18),
            CustomTextField(
              controller: contentController,
              label: "Blog Content",
              hint: "Share your knowledge...",
              maxLines: 8,
            ),
            height(22),
            Text("Tags", style: customTextStyle(fontWeight: FontWeight.bold)),
            height(10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((tag) {
                final selected = selectedTags.contains(tag);

                return FilterChip(
                  backgroundColor: Colors.white,
                  label: Text(tag),
                  selected: selected,
                  selectedColor: AppColors.newPri.withValues(alpha: .18),
                  checkmarkColor: AppColors.newPri,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedTags.add(tag);
                      } else {
                        selectedTags.remove(tag);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            height(25),
            Text(
              "Attachments",
              style: customTextStyle(fontWeight: FontWeight.bold),
            ),
            height(10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.picture_as_pdf,
                      color: AppColors.textColor,
                    ),
                    label: Text(
                      "Upload Pdf",
                      style: customTextStyle(color: AppColors.textColor),
                    ),
                  ),
                ),
                width(12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.photo_library, color: AppColors.textColor),
                    label: Text(
                      "Images",
                      style: customTextStyle(color: AppColors.textColor),
                    ),
                  ),
                ),
              ],
            ),
            height(35),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(onPressed: () {}, text: "Save Draft"),
                ),
                width(15),
                Expanded(
                  child: PrimaryButton(
                    text: "Publish",
                    backgroundColor: AppColors.newPri,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            height(40),
          ],
        ),
      ),
    );
  }
}
