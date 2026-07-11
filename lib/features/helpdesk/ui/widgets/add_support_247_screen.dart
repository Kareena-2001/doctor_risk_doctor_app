import 'dart:io';

import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/helpdesk/ui/widgets/success_view.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../extensions/build_context_extension.dart';
import '../../../../theme/app_theme.dart';
import '../provider/help_categories_provider.dart';
import '../state/help_state.dart';
import '../view_model/help_view_model.dart';

class AddSupport247Screen extends ConsumerStatefulWidget {
  const AddSupport247Screen({super.key});

  @override
  ConsumerState<AddSupport247Screen> createState() =>
      _AddSupport247ScreenState();
}

class _AddSupport247ScreenState extends ConsumerState<AddSupport247Screen> {
  final TextEditingController _customQueryController = TextEditingController();

  String? _selectedFileName;
  PlatformFile? _selectedFile;
  String? selectedCategory;
  String? selectedQuestion;
  bool isSubmitted = false;
  String? generatedTicketNumber;

  @override
  void dispose() {
    _customQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen<HelpState>(helpViewModelProvider, (prev, next) {
      if (prev?.isSuccess == false && next.isSuccess) {
        context.showSuccessSnackBar('Query submitted successfully');
        setState(() => isSubmitted = true);
      }

      if (next.error != null && next.error != prev?.error) {
        context.showErrorSnackBar(next.error!);
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: '24/7 Support'),
      body: isSubmitted ? _buildSuccessView() : _buildFormView(isDark),
    );
  }

  Widget _buildFormView(bool isDark) {
    final helpState = ref.watch(helpViewModelProvider);
    final helpCategories = ref.watch(helpCategoriesProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          height(24),
          _buildStepOne(isDark),
          height(24),
          if (selectedCategory != null) ...[
            Text('Step 2: Select Your Question', style: AppTheme.title16),
            height(12),
            ...helpCategories[selectedCategory]!.map((question) {
              final isSelected = selectedQuestion == question;
              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      selectedQuestion = question;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : (isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade50),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : (isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? Colors.grey.shade600 : Colors.grey),
                        ),
                        width(12),
                        Expanded(
                          child: Text(
                            question,
                            style: customTextStyle(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            height(16),
          ],
          if (selectedQuestion != null) ...[
            Text(
              'Step 3: Additional Details (Optional)',
              style: customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            height(12),
            TextField(
              controller: _customQueryController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Provide more details about your query...',
                hintStyle: customTextStyle(
                  color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                ),
                filled: true,
                fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              style: customTextStyle(
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            height(12),
            _buildAttachmentField(),
            height(24),
          ],
          if (selectedQuestion != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: helpState.isLoading
                    ? null
                    : () {
                        ref
                            .read(helpViewModelProvider.notifier)
                            .addRequestSupport(
                              category: selectedCategory!,
                              question: selectedQuestion!,
                              details: _customQueryController.text,
                              userAttachment: _selectedFile?.path != null
                                  ? File(_selectedFile!.path!)
                                  : null,
                            );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send_rounded, color: Colors.white),
                    width(8),
                    Text(
                      'Submit Query',
                      style: customTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            height(12),
          ],
        ],
      ),
    );
  }

  Widget _buildStepOne(bool isDark) {
    final helpCategories = ref.watch(helpCategoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Step 1: Select Category', style: AppTheme.title16),
        height(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: helpCategories.keys.map((category) {
            final isSelected = selectedCategory == category;
            return Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                    selectedQuestion = null;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : (isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300),
                    ),
                  ),
                  child: Text(
                    category,
                    style: customTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white : Colors.black87),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.15),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.help_outline_rounded, size: 30, color: AppColors.primary),
          width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('What do you need help with?', style: AppTheme.title14),
                height(4),
                Text(
                  'Select a category and question below',
                  style: AppTheme.label12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachments',
          style: customTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: context.primaryTextColor,
          ),
        ),
        height(4),
        GestureDetector(
          onTap: _selectedFile == null
              ? _pickFile
              : () => _openFilePreview(context, _selectedFile!),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.secondaryWidgetColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  _selectedFile != null
                      ? (_isImage(_selectedFile!.extension)
                            ? Icons.image
                            : Icons.picture_as_pdf)
                      : Icons.picture_as_pdf,
                  color: _selectedFile != null ? Colors.green : Colors.red,
                ),
                width(8),
                Expanded(
                  child: Text(
                    _selectedFileName ?? "Choose File (pdf, jpg, jpeg, png)",
                    style: AppTheme.label12,
                  ),
                ),
                if (_selectedFile != null)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFile = null;
                        _selectedFileName = null;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppColors.cardRed,
                      size: 18,
                    ),
                  ),
                const SizedBox(width: 8),
                const Icon(Icons.attach_file, color: AppColors.cardRed),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _isImage(String? extension) {
    if (extension == null) return false;
    final ext = extension.toLowerCase();
    return ext == 'jpg' || ext == 'jpeg' || ext == 'png';
  }

  void _openFilePreview(BuildContext context, PlatformFile file) {
    final path = file.path;
    if (path == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("File path not available")));
      return;
    }

    if (_isImage(file.extension)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text("Image Preview - ${file.name}")),
            body: Center(
              child: Image.file(
                File(path),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Text("Cannot display image")),
              ),
            ),
          ),
        ),
      );
    } else {
      context.showErrorSnackBar(
        "Preview not supported for .${file.extension} files yet",
      );
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFile = result.files.first;
          _selectedFileName = _selectedFile!.name;
        });
      }
    } catch (e) {
      context.showErrorSnackBar('Error picking file: $e');
    }
  }

  Widget _buildSuccessView() {
    return SuccessView();
  }
}
