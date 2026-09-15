import 'dart:io';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/your_story/model/experience_submit_response.dart';
import 'package:Doctors_App/features/your_story/ui/viewmodel/your_story_view_model.dart';
import 'package:Doctors_App/features/your_story/ui/your_story_screen.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ShareExperienceForm extends ConsumerStatefulWidget {
  final String authorName;
  final String authorSpeciality;

  const ShareExperienceForm({
    super.key,
    this.authorName = 'You',
    this.authorSpeciality = '',
  });

  @override
  ConsumerState<ShareExperienceForm> createState() =>
      _ShareExperienceFormState();
}

class _ShareExperienceFormState extends ConsumerState<ShareExperienceForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  YourStoryMode _mode = YourStoryMode.text;

  File? _videoFile;
  VideoPlayerController? _videoController;

  File? _pdfFile;
  String? _pdfName;

  bool _isSubmitted = false;
  bool _rememberMe = false;

  ExperienceSubmitData? _submittedExperience;

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // SUBMIT
  // ---------------------------------------------------------------------------

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final description = _textController.text.trim();

    if (_mode == YourStoryMode.text && description.isEmpty) {
      context.showWarningSnackBar('Please write your experience first');
      return;
    }

    if (_mode == YourStoryMode.video && _videoFile == null) {
      context.showWarningSnackBar('Please add a video first');
      return;
    }

    if (_mode == YourStoryMode.document && _pdfFile == null) {
      context.showWarningSnackBar('Please upload a PDF first');
      return;
    }

    if (!_rememberMe) {
      context.showWarningSnackBar('Please accept the agreement');
      return;
    }

    final experienceType = switch (_mode) {
      YourStoryMode.text => 'text',
      YourStoryMode.video => 'video',
      YourStoryMode.document => 'document',
    };

    final File? file = switch (_mode) {
      YourStoryMode.text => null,
      YourStoryMode.video => _videoFile,
      YourStoryMode.document => _pdfFile,
    };

    final success = await ref
        .read(yourStoryViewModelProvider.notifier)
        .submitExperience(
          title: title,
          experienceType: experienceType,
          description: description,
          iAgreeAccepted: _rememberMe ? '1' : '0',
          file: file,
        );

    if (!mounted) return;

    if (success) {
      final response = ref
          .read(yourStoryViewModelProvider)
          .submitExperienceStatus;

      response.whenOrNull(
        data: (data) {
          if (data != null) {
            setState(() {
              _submittedExperience = data.data;
              _isSubmitted = true;
            });
          }
        },
      );

      context.showSuccessSnackBar('Experience submitted successfully');
    } else {
      final submitStatus = ref
          .read(yourStoryViewModelProvider)
          .submitExperienceStatus;

      submitStatus.whenOrNull(
        error: (error, _) {
          context.showErrorSnackBar(error.toString());
        },
      );
    }
  }

  // ---------------------------------------------------------------------------
  // VIDEO
  // ---------------------------------------------------------------------------

  Future<void> _pickVideo() async {
    try {
      final picked = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 3),
      );

      if (picked == null) return;

      final file = File(picked.path);
      final controller = VideoPlayerController.file(file);

      await controller.initialize();

      if (!mounted) {
        controller.dispose();
        return;
      }

      _videoController?.dispose();

      setState(() {
        _videoFile = file;
        _videoController = controller;
      });
    } catch (e) {
      if (mounted) {
        context.showWarningSnackBar('Could not load video: $e');
      }
    }
  }

  Future<void> _recordVideo() async {
    try {
      final picked = await ImagePicker().pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 3),
      );

      if (picked == null) return;

      final file = File(picked.path);
      final controller = VideoPlayerController.file(file);

      await controller.initialize();

      if (!mounted) {
        controller.dispose();
        return;
      }

      _videoController?.dispose();

      setState(() {
        _videoFile = file;
        _videoController = controller;
      });
    } catch (e) {
      if (mounted) {
        context.showWarningSnackBar('Could not record video: $e');
      }
    }
  }

  void _removeVideo() {
    _videoController?.dispose();

    setState(() {
      _videoController = null;
      _videoFile = null;
    });
  }

  // ---------------------------------------------------------------------------
  // PDF
  // ---------------------------------------------------------------------------

  Future<void> _pickPdf() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return;

      final path = result.files.single.path;

      if (path == null) {
        context.showWarningSnackBar('Unable to access selected PDF');
        return;
      }

      setState(() {
        _pdfFile = File(path);
        _pdfName = result.files.single.name;
      });
    } catch (e) {
      if (mounted) {
        context.showWarningSnackBar('Unable to pick PDF');
      }
    }
  }

  void _removePdf() {
    setState(() {
      _pdfFile = null;
      _pdfName = null;
    });
  }

  // ---------------------------------------------------------------------------
  // RESET
  // ---------------------------------------------------------------------------

  void _resetForm() {
    _videoController?.dispose();

    setState(() {
      _isSubmitted = false;
      _submittedExperience = null;

      _mode = YourStoryMode.text;

      _titleController.clear();
      _textController.clear();

      _videoController = null;
      _videoFile = null;

      _pdfFile = null;
      _pdfName = null;

      _rememberMe = false;
    });
  }

  void _done() {
    Navigator.pop(context, _submittedExperience);
  }

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(
      yourStoryViewModelProvider.select(
        (s) => s.submitExperienceStatus.isLoading,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: CustomAppBar(title: 'Share Experience'),
      body: _isSubmitted ? _buildSuccessView() : _buildForm(isSubmitting),
    );
  }

  // ---------------------------------------------------------------------------
  // FORM
  // ---------------------------------------------------------------------------

  Widget _buildForm(bool isSubmitting) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.w(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),

          height(Responsive.h(20)),

          _infoBanner(
            icon: Icons.lock,
            'Approved experiences are published to Peer Forum — a feature only visible to active DoctorsRisk members.',
          ),

          height(Responsive.h(20)),

          Text(
            'Experience Type',
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              fontWeight: FontWeight.w700,
            ),
          ),

          height(Responsive.h(8)),

          _buildModeToggle(),

          height(Responsive.h(20)),

          CustomTextField(
            isRequired: false,
            label: 'Title (optional)',
            controller: _titleController,
            hint: 'e.g. What I Learned from a Difficult Clinical Case',
          ),

          height(Responsive.h(20)),

          if (_mode == YourStoryMode.text)
            _buildTextInput()
          else if (_mode == YourStoryMode.video)
            _buildVideoInput()
          else
            _buildPdfInput(),

          height(Responsive.h(15)),

          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: isSubmitting
                      ? null
                      : (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'I agree to share this content within the DoctorsRisk community for publishing and viewing purposes among my medical peers.',
                  style: AppTheme.label12.copyWith(
                    color: const Color(0xFF475569),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          height(Responsive.h(15)),

          _infoBanner(
            'All submissions are reviewed by our medico-legal experts and may be lightly edited for accuracy or clarity before publishing, for your protection. To request removal of a submission, please raise a ticket with Service Support in the Support Hub, or contact our helpline.',
          ),

          height(Responsive.h(28)),

          PrimaryButton(
            backgroundColor: AppColors.newPri,
            text: isSubmitting ? 'Submitting...' : 'Share Experience',
            onPressed: isSubmitting ? null : _submit,
            icon: Icons.send_rounded,
          ),

          height(Responsive.h(50)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(Responsive.w(15)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.newPri.withValues(alpha: 0.12),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(Responsive.w(18)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.w(10)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.newPri, AppColors.primary],
              ),
              borderRadius: BorderRadius.circular(Responsive.w(12)),
            ),
            child: Icon(
              Icons.auto_stories_rounded,
              color: Colors.white,
              size: Responsive.sp(15),
            ),
          ),

          width(Responsive.w(14)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Story',
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),

                height(Responsive.h(4)),

                Text(
                  'Share your own experience or testimonial with the DoctorsRisk community. Every submission is reviewed by our team before it goes live — this is your individual space, not a shared feed.',
                  style: customTextStyle(
                    fontSize: Responsive.sp(10.5),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBanner(
    String text, {
    IconData icon = Icons.info_outline_rounded,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          width(10),
          Expanded(child: Text(text, style: AppTheme.label12)),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Container(
      padding: EdgeInsets.all(Responsive.w(4)),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(Responsive.w(30)),
      ),
      child: Row(
        children: [
          _toggleOption(
            label: 'Text',
            icon: Icons.edit,
            mode: YourStoryMode.text,
          ),
          _toggleOption(
            label: 'Video',
            icon: Icons.videocam,
            mode: YourStoryMode.video,
          ),
          _toggleOption(
            label: 'PDF',
            icon: Icons.picture_as_pdf,
            mode: YourStoryMode.document,
          ),
        ],
      ),
    );
  }

  Widget _toggleOption({
    required String label,
    required IconData icon,
    required YourStoryMode mode,
  }) {
    final selected = _mode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _mode = mode;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: Responsive.h(10)),
          decoration: BoxDecoration(
            color: selected ? AppColors.newPri : Colors.transparent,
            borderRadius: BorderRadius.circular(Responsive.w(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: Responsive.sp(16),
                color: selected ? Colors.white : Colors.grey.shade600,
              ),
              width(Responsive.w(6)),
              Text(
                label,
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Your Experience',
        //   style: customTextStyle(
        //     fontSize: Responsive.sp(12),
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        // SizedBox(height: Responsive.h(8)),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Responsive.w(16)),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: _textController,
            maxLines: 8,
            maxLength: 1000,
            style: customTextStyle(fontSize: Responsive.sp(13.5)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(Responsive.w(16)),
              hintText:
                  'Share the case context, what you learned, and how it could help a peer facing something similar…',
              hintStyle: customTextStyle(
                fontSize: Responsive.sp(12),
                color: Colors.grey.shade400,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoInput() {
    if (_videoFile != null && _videoController != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Responsive.w(16)),
            child: AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio == 0
                  ? 16 / 9
                  : _videoController!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_videoController!),
                  _PlayPauseOverlay(controller: _videoController!),
                ],
              ),
            ),
          ),

          height(Responsive.h(12)),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _removeVideo,
                  icon: const Icon(Icons.close_rounded, size: 16),
                  label: const Text('Remove'),
                ),
              ),

              width(Responsive.w(10)),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickVideo,
                  icon: const Icon(Icons.swap_horiz_rounded, size: 16),
                  label: const Text('Change'),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: Responsive.h(30)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Responsive.w(16)),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Icon(
                Icons.videocam_outlined,
                size: Responsive.sp(40),
                color: Colors.grey.shade400,
              ),
              height(Responsive.h(8)),
              Text(
                'No video added yet',
                style: customTextStyle(
                  fontSize: Responsive.sp(12.5),
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),

        height(Responsive.h(14)),

        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _recordVideo,
                icon: const Icon(
                  Icons.fiber_manual_record,
                  size: 16,
                  color: Colors.red,
                ),
                label: const Text('Record'),
              ),
            ),

            width(Responsive.w(10)),

            Expanded(
              child: ElevatedButton.icon(
                onPressed: _pickVideo,
                icon: const Icon(
                  Icons.video_library_outlined,
                  size: 16,
                  color: Colors.white,
                ),
                label: const Text('Upload'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.newPri,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // PDF
  // ---------------------------------------------------------------------------

  Widget _buildPdfInput() {
    if (_pdfFile != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            const Icon(Icons.picture_as_pdf, size: 60, color: Colors.red),

            const SizedBox(height: 12),

            Text(
              _pdfName ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _removePdf,
                    icon: const Icon(Icons.delete),
                    label: const Text('Remove'),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickPdf,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Change'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          const Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),

          const SizedBox(height: 12),

          const Text('No PDF selected'),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: _pickPdf,
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload PDF'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SUCCESS
  // ---------------------------------------------------------------------------

  Widget _buildSuccessView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Responsive.w(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.w(20)),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: Responsive.sp(48),
              ),
            ),

            height(Responsive.h(20)),

            Text(
              'Thank You for Sharing!',
              style: customTextStyle(
                fontSize: Responsive.sp(18),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),

            height(Responsive.h(8)),

            Text(
              _submittedExperience?.approveStatus == 'awaiting_admin_approval'
                  ? 'Your experience has been submitted and is awaiting admin approval.'
                  : 'Your experience has been submitted successfully.',
              textAlign: TextAlign.center,
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: Colors.grey.shade600,
              ),
            ),

            height(Responsive.h(24)),

            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                backgroundColor: AppColors.newPri,
                text: 'Done',
                onPressed: _done,
              ),
            ),

            height(Responsive.h(12)),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _resetForm,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.newPri, width: 1.5),
                  padding: EdgeInsets.symmetric(vertical: Responsive.h(14)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Responsive.w(12)),
                  ),
                ),
                child: Text(
                  'Share Another Story',
                  style: AppTheme.label14.copyWith(color: AppColors.newPri),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PLAY / PAUSE
// -----------------------------------------------------------------------------

class _PlayPauseOverlay extends StatefulWidget {
  final VideoPlayerController controller;

  const _PlayPauseOverlay({required this.controller});

  @override
  State<_PlayPauseOverlay> createState() => _PlayPauseOverlayState();
}

class _PlayPauseOverlayState extends State<_PlayPauseOverlay> {
  late final VoidCallback _listener;

  @override
  void initState() {
    super.initState();

    _listener = () {
      if (mounted) {
        setState(() {});
      }
    };

    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.controller.value.isPlaying) {
          widget.controller.pause();
        } else {
          widget.controller.play();
        }
      },
      child: AnimatedOpacity(
        opacity: widget.controller.value.isPlaying ? 0 : 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          color: Colors.black26,
          child: const Center(
            child: Icon(
              Icons.play_circle_fill_rounded,
              color: Colors.white,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }
}
