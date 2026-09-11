import 'dart:io';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/blog_central/model/my_submission_list_model.dart';
import 'package:Doctors_App/features/blog_central/ui/viewmodel/blog_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/common/ui/widgets/secondary_button.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddBlogScreen extends ConsumerStatefulWidget {
  final SubmissionModel? blogToEdit;

  const AddBlogScreen({super.key, this.blogToEdit});

  @override
  ConsumerState<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends ConsumerState<AddBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final keywordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  File? coverImage;
  String? existingImageUrl;
  List<String> keywords = [];
  bool isAgreed = false;
  int? _editId;

  String _currentStatus = 'draft';
  bool _isLoadingDetails = false;

  bool get isEditing => widget.blogToEdit != null;

  bool get _isDraftStatus => !isEditing || _currentStatus == 'draft';

  @override
  void initState() {
    super.initState();
    debugPrint('AddBlogScreen initState — blogToEdit=${widget.blogToEdit}');
    _fetchAndPrefill();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isEditing) {
      final routeExtra = GoRouterState.of(context).extra;
      if (routeExtra is SubmissionModel) {
        debugPrint('Recovered blogToEdit from GoRouterState.extra fallback');
        _applyListSubmission(routeExtra);
        _fetchDetailsFor(routeExtra.id.toString());
      }
    }
  }

  Future<void> _fetchDetailsFor(String id) async {
    setState(() => _isLoadingDetails = true);
    final details = await ref
        .read(blogViewModelProvider.notifier)
        .fetchMySubmissionDetails(id);
    if (!mounted) return;
    setState(() => _isLoadingDetails = false);
    final detailData = details?.data;
    if (detailData != null) _applyDetailResponse(detailData);
  }

  Future<void> _fetchAndPrefill() async {
    final blog = widget.blogToEdit;
    if (blog == null) return;

    _applyListSubmission(blog);

    setState(() => _isLoadingDetails = true);

    final details = await ref
        .read(blogViewModelProvider.notifier)
        .fetchMySubmissionDetails(blog.id.toString());

    if (!mounted) return;
    setState(() => _isLoadingDetails = false);

    final detailData = details?.data;
    if (detailData != null) {
      _applyDetailResponse(detailData);
    }
  }

  void _applyListSubmission(SubmissionModel blog) {
    _editId = blog.id;
    titleController.text = blog.title;
    contentController.text = blog.description;

    if (blog.image != null && blog.image!.isNotEmpty) {
      existingImageUrl = blog.image;
    }

    keywords = blog.keywords.map((k) => k.keyword).toList();
    isAgreed = blog.iAgreeAccepted == '1';
    _currentStatus = (blog.approveStatus ?? 'draft').toLowerCase().trim();
  }

  void _applyDetailResponse(Object detailData) {
    final dynamic data = detailData;

    try {
      final title = data.title;
      if (title != null && title.toString().isNotEmpty) {
        titleController.text = title.toString();
      }
    } catch (_) {}

    try {
      final description = data.description;
      if (description != null) {
        contentController.text = description.toString();
      }
    } catch (_) {}

    try {
      final img = data.image;
      if (img != null && img.toString().isNotEmpty) {
        existingImageUrl = img.toString();
      }
    } catch (_) {}

    try {
      final kw = data.keywords;
      if (kw is List) {
        keywords = kw.map((e) {
          try {
            final k = e.keyword;
            if (k != null) return k.toString();
          } catch (_) {}
          return e.toString();
        }).toList();
      }
    } catch (_) {}

    try {
      final status = data.approveStatus;
      if (status != null && status.toString().isNotEmpty) {
        _currentStatus = status.toString().toLowerCase().trim();
      }
    } catch (_) {}

    try {
      final agree = data.iAgreeAccepted;
      if (agree != null) {
        isAgreed = agree == true || agree.toString() == '1';
      }
    } catch (_) {}

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    keywordController.dispose();
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
        existingImageUrl = null;
      });
    }
  }

  void _addKeyword() {
    final value = keywordController.text.trim();
    if (value.isEmpty) return;
    if (keywords.contains(value)) {
      keywordController.clear();
      return;
    }
    setState(() {
      keywords.add(value);
      keywordController.clear();
    });
  }

  void _removeKeyword(String value) {
    setState(() => keywords.remove(value));
  }

  Future<void> _saveAsDraft() => _handleSubmit('draft');

  Future<void> _submitForReview() => _handleSubmit('awaiting_admin_approval');

  Future<void> _saveChangesKeepStatus() => _handleSubmit(_currentStatus);

  Future<void> _handleSubmit(String approveStatus) async {
    final isDraft = approveStatus == 'draft';

    if (titleController.text.trim().isEmpty) {
      context.showWarningSnackBar('Please enter title');
      return;
    }
    if (!isDraft) {
      if (contentController.text.trim().isEmpty) {
        context.showWarningSnackBar('Please write your article');
        return;
      }
      if (!isAgreed) {
        context.showWarningSnackBar('Please accept the agreement');
        return;
      }
    }

    final success = await ref
        .read(blogViewModelProvider.notifier)
        .submitBlog(
          id: _editId,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          coverImage: coverImage,
          iAgreeAccepted: isAgreed ? '1' : '0',
          keywords: keywords,
          approveStatus: approveStatus,
        );

    if (!mounted) return;
    if (success) {
      context.showSuccessSnackBar(
        isDraft
            ? (isEditing ? 'Changes saved' : 'Saved as draft')
            : 'Submitted for review',
      );
      Navigator.pop(context);
    } else {
      final err = ref.read(blogViewModelProvider).submitStatus;
      context.showErrorSnackBar('Submission failed: ${err.error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(
      blogViewModelProvider.select((s) => s.submitStatus.isLoading),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: CustomAppBar(title: isEditing ? 'Edit Blog' : 'Write a Blog'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isLoadingDetails) ...[
              const LinearProgressIndicator(minHeight: 2),
              height(12),
            ],

            Text(
              'Share your experience with the group. Your submission goes '
              'to admin for review before it\'s published — you\'ll earn '
              'points once it\'s approved.',
              style: customTextStyle(
                fontSize: Responsive.sp(10.5),
                color: Colors.grey.shade700,
              ).copyWith(height: 1.5),
            ),

            height(22),

            Text(
              'Keywords',
              style: customTextStyle(
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.w700,
              ),
            ),
            height(8),
            _buildKeywordInput(),
            if (keywords.isNotEmpty) ...[height(10), _buildKeywordChips()],

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

            _buildActionButtons(isSubmitting),

            SocialLinkWidget(),
            height(30),
          ],
        ),
      ),
    );
  }

  /// - New blog, or editing a DRAFT: Cancel + "Save Changes"/"Save as
  ///   Draft" side by side, then a full-width "Submit for Review" below.
  /// - Editing a submission that's AWAITING_ADMIN_APPROVAL: only Cancel +
  ///   "Save Changes" — no submit action, status stays as-is.
  Widget _buildActionButtons(bool isSubmitting) {
    if (_isDraftStatus) {
      return Column(
        children: [
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
                child: SecondaryButton(
                  onPressed: isSubmitting ? () {} : _saveAsDraft,
                  text: isEditing ? 'Save Changes' : 'Save as Draft',
                ),
              ),
            ],
          ),
          height(12),
          PrimaryButton(
            borderRadius: 25,
            fontSize: 14,
            text: 'Submit for Review',
            backgroundColor: AppColors.newPri,
            onPressed: isSubmitting ? () {} : _submitForReview,
          ),
        ],
      );
    }

    // Already awaiting_admin_approval — only allow saving changes.
    return Row(
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
            text: 'Save Changes',
            backgroundColor: AppColors.newPri,
            onPressed: isSubmitting ? () {} : _saveChangesKeepStatus,
          ),
        ),
      ],
    );
  }

  Widget _buildKeywordInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: keywordController,
            onSubmitted: (_) => _addKeyword(),
            textInputAction: TextInputAction.done,
            style: customTextStyle(fontSize: Responsive.sp(12)),
            decoration: InputDecoration(
              hintText: 'Add a keyword and tap +',
              hintStyle: customTextStyle(
                fontSize: Responsive.sp(11),
                color: Colors.grey.shade500,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Responsive.w(12),
                vertical: Responsive.h(10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.newPri),
              ),
            ),
          ),
        ),
        width(8),
        InkWell(
          onTap: _addKeyword,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: Responsive.h(40),
            width: Responsive.h(40),
            decoration: BoxDecoration(
              color: AppColors.newPri,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildKeywordChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: keywords.map((keyword) {
        return Chip(
          label: Text(
            keyword,
            style: customTextStyle(fontSize: Responsive.sp(11)),
          ),
          backgroundColor: Colors.grey.shade100,
          deleteIcon: const Icon(Icons.close, size: 16),
          onDeleted: () => _removeKeyword(keyword),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        );
      }).toList(),
    );
  }

  Widget _buildImagePicker() {
    final hasLocalImage = coverImage != null;
    final hasExistingImage =
        !hasLocalImage &&
        existingImageUrl != null &&
        existingImageUrl!.isNotEmpty;

    if (!hasLocalImage && !hasExistingImage) {
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
          child: hasLocalImage
              ? Image.file(
                  coverImage!,
                  width: double.infinity,
                  height: Responsive.h(160),
                  fit: BoxFit.cover,
                )
              : Image.network(
                  existingImageUrl!,
                  width: double.infinity,
                  height: Responsive.h(160),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: Responsive.h(160),
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image_outlined),
                  ),
                ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () {
              setState(() {
                coverImage = null;
                existingImageUrl = null;
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
