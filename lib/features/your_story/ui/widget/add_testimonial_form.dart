import 'dart:io';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/your_story/ui/viewmodel/your_story_view_model.dart';
import 'package:Doctors_App/features/your_story/ui/your_story_screen.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AddTestimonialForm extends ConsumerStatefulWidget {
  final String authorName;
  final String authorSpeciality;

  const AddTestimonialForm({
    super.key,
    this.authorName = 'You',
    this.authorSpeciality = '',
  });

  @override
  ConsumerState<AddTestimonialForm> createState() =>
      _AddTestimonialFormState();
}

class _AddTestimonialFormState
    extends ConsumerState<AddTestimonialForm> {
  bool _rememberMe = false;

  File? _pdfFile;
  String? _pdfName;

  final TextEditingController _textController =
  TextEditingController();

  YourStoryMode _mode = YourStoryMode.text;

  File? _videoFile;
  VideoPlayerController? _videoController;

  bool _isSubmitted = false;

  @override
  void dispose() {
    _textController.dispose();
    _videoController?.dispose();
    super.dispose();
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
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
          width(10),
          Expanded(
            child: Text(
              text,
              style: AppTheme.label12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final testimonialType = switch (_mode) {
      YourStoryMode.text => 'text',
      YourStoryMode.video => 'video',
      YourStoryMode.document => 'document',
    };

    final File? file = switch (_mode) {
      YourStoryMode.text => null,
      YourStoryMode.video => _videoFile,
      YourStoryMode.document => _pdfFile,
    };

    if (_mode == YourStoryMode.text &&
        _textController.text.trim().isEmpty) {
      context.showWarningSnackBar(
        'Please write your testimonial first',
      );
      return;
    }

    if (_mode == YourStoryMode.video &&
        _videoFile == null) {
      context.showWarningSnackBar(
        'Please add a video first',
      );
      return;
    }

    if (_mode == YourStoryMode.document &&
        _pdfFile == null) {
      context.showWarningSnackBar(
        'Please upload a PDF first',
      );
      return;
    }

    if (!_rememberMe) {
      context.showWarningSnackBar(
        'Please accept the sharing agreement',
      );
      return;
    }

    final success = await ref
        .read(yourStoryViewModelProvider.notifier)
        .submitTestimonial(
      testimonialType: testimonialType,
      description: _textController.text.trim(),
      iAgreeAccepted: _rememberMe ? '1' : '0',
      file: file,
    );

    if (!mounted) return;

    if (success) {
      setState(() {
        _isSubmitted = true;
      });
    } else {
      final submitState =
          ref.read(yourStoryViewModelProvider).submitTestimonialStatus;

      submitState.whenOrNull(
        error: (error, _) {
          context.showErrorSnackBar(
            error.toString(),
          );
        },
      );
    }
  }

  void _resetForm() {
    _videoController?.dispose();

    setState(() {
      _isSubmitted = false;
      _mode = YourStoryMode.text;
      _rememberMe = false;

      _textController.clear();

      _videoController = null;
      _videoFile = null;

      _pdfFile = null;
      _pdfName = null;
    });
  }

  void _done() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final submitState =
        ref.watch(yourStoryViewModelProvider).submitTestimonialStatus;

    final isSubmitting = submitState.isLoading;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Share Testimonial',
      ),
      body: _isSubmitted
          ? _buildSuccessView()
          : _buildForm(isSubmitting),
    );
  }

  Widget _buildForm(bool isSubmitting) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(
        Responsive.w(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          height(Responsive.h(20)),
          _infoBanner(
            icon: Icons.lock,
            'Approved testimonials are published under Community → Testimonials, open for members and non-members to view.',
          ),
          height(Responsive.h(20)),

          _buildModeToggle(),

          height(Responsive.h(15)),

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
            text: isSubmitting
                ? 'Submitting...'
                : 'Share Testimonial',
            onPressed: isSubmitting ? null : _submit,
            icon: Icons.send_rounded,
          ),

          height(Responsive.h(50)),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Container(
      padding: EdgeInsets.all(
        Responsive.w(4),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(
          Responsive.w(30),
        ),
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
          if (_mode == mode) return;

          setState(() {
            _mode = mode;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            vertical: Responsive.h(10),
          ),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.newPri
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              Responsive.w(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: Responsive.sp(16),
                color: selected
                    ? Colors.white
                    : Colors.grey.shade600,
              ),
              width(Responsive.w(6)),
              Text(
                label,
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? Colors.white
                      : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          Responsive.w(16),
        ),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: TextField(
        controller: _textController,
        maxLines: 8,
        maxLength: 1000,
        style: customTextStyle(
          fontSize: Responsive.sp(13.5),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(
            Responsive.w(16),
          ),
          hintText:
          'Share how our service helped you — a case resolved, guidance you received, or peace of mind you gained...',
          hintStyle: customTextStyle(
            fontSize: Responsive.sp(12),
            color: Colors.grey.shade400,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

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

      final oldController = _videoController;

      setState(() {
        _videoFile = file;
        _videoController = controller;
      });

      await oldController?.dispose();
    } catch (e) {
      if (mounted) {
        context.showWarningSnackBar(
          'Could not load video',
        );
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

      final oldController = _videoController;

      setState(() {
        _videoFile = file;
        _videoController = controller;
      });

      await oldController?.dispose();
    } catch (e) {
      if (mounted) {
        context.showWarningSnackBar(
          'Could not record video',
        );
      }
    }
  }

  void _removeVideo() {
    final controller = _videoController;

    setState(() {
      _videoController = null;
      _videoFile = null;
    });

    controller?.dispose();
  }

  Widget _buildVideoInput() {
    if (_videoFile != null &&
        _videoController != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              Responsive.w(16),
            ),
            child: AspectRatio(
              aspectRatio:
              _videoController!.value.aspectRatio == 0
                  ? 16 / 9
                  : _videoController!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_videoController!),
                  _PlayPauseOverlay(
                    controller: _videoController!,
                  ),
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
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 16,
                  ),
                  label: const Text('Remove'),
                ),
              ),
              width(Responsive.w(10)),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickVideo,
                  icon: const Icon(
                    Icons.swap_horiz_rounded,
                    size: 16,
                  ),
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
          padding: EdgeInsets.symmetric(
            vertical: Responsive.h(30),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              Responsive.w(16),
            ),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
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

  Widget _buildPdfInput() {
    if (_pdfFile != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.picture_as_pdf,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            Text(
              _pdfName ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
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
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.picture_as_pdf,
            size: 40,
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          const Text('No PDF selected'),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _pickPdf,
            icon: Icon(
              Icons.upload_file,
              color: AppColors.textPri,
            ),
            label: Text(
              'Upload PDF',
              style: customTextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickPdf() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return;

      final path = result.files.single.path;

      if (path == null) {
        context.showWarningSnackBar(
          'Unable to access selected PDF',
        );
        return;
      }

      setState(() {
        _pdfFile = File(path);
        _pdfName = result.files.single.name;
      });
    } catch (_) {
      if (mounted) {
        context.showWarningSnackBar(
          'Unable to pick PDF',
        );
      }
    }
  }

  void _removePdf() {
    setState(() {
      _pdfFile = null;
      _pdfName = null;
    });
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(
        Responsive.w(15),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.newPri.withValues(alpha: 0.12),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(
          Responsive.w(18),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(
              Responsive.w(10),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.newPri,
                  AppColors.primary,
                ],
              ),
              borderRadius: BorderRadius.circular(
                Responsive.w(12),
              ),
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
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Share Your Testimonial',
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(4)),
                Text(
                  'Tell us about your testimonial — in your own words or on camera',
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

  Widget _buildSuccessView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          Responsive.w(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(
                Responsive.w(20),
              ),
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
              'Your testimonial will go live once approved by our team',
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
                  side: const BorderSide(
                    color: AppColors.newPri,
                    width: 1.5,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: Responsive.h(14),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Responsive.w(12),
                    ),
                  ),
                ),
                child: Text(
                  'Share Another Testimonial',
                  style: AppTheme.label14.copyWith(
                    color: AppColors.newPri,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayPauseOverlay extends StatefulWidget {
  final VideoPlayerController controller;

  const _PlayPauseOverlay({
    required this.controller,
  });

  @override
  State<_PlayPauseOverlay> createState() =>
      _PlayPauseOverlayState();
}

class _PlayPauseOverlayState
    extends State<_PlayPauseOverlay> {
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
        widget.controller.value.isPlaying
            ? widget.controller.pause()
            : widget.controller.play();
      },
      child: AnimatedOpacity(
        opacity: widget.controller.value.isPlaying
            ? 0
            : 1,
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