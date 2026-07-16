import 'dart:io';

import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/testimonial/model/experience_model.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../testimonial_screen.dart';

class ShareTestimonialForm extends StatefulWidget {
  // Passed in by the caller (from the logged-in doctor's profile/session).
  final String authorName;
  final String authorSpeciality;

  const ShareTestimonialForm({
    super.key,
    this.authorName = 'You',
    this.authorSpeciality = '',
  });

  @override
  State<ShareTestimonialForm> createState() => _ShareTestimonialFormState();
}

class _ShareTestimonialFormState extends State<ShareTestimonialForm> {
  final TextEditingController _textController = TextEditingController();
  TestimonialMode _mode = TestimonialMode.text;
  File? _videoFile;
  VideoPlayerController? _videoController;
  bool _isSubmitting = false;
  bool _isSubmitted = false;
  ExperienceModel? _createdExperience;

  @override
  void dispose() {
    _textController.dispose();
    _videoController?.dispose();
    super.dispose();
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

      if (!mounted) return;
      setState(() {
        _videoFile = file;
        _videoController?.dispose();
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

      if (!mounted) return;
      setState(() {
        _videoFile = file;
        _videoController?.dispose();
        _videoController = controller;
      });
    } catch (e) {
      if (mounted) {
        context.showWarningSnackBar('Could not record video: $e');
      }
    }
  }

  void _removeVideo() {
    setState(() {
      _videoController?.dispose();
      _videoController = null;
      _videoFile = null;
    });
  }

  String _formattedToday() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final now = DateTime.now();
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  Future<void> _submit() async {
    if (_mode == TestimonialMode.text && _textController.text.trim().isEmpty) {
      context.showWarningSnackBar('Please write your testimonial first');
      return;
    }
    if (_mode == TestimonialMode.video && _videoFile == null) {
      context.showWarningSnackBar('Please add a video first');
      return;
    }

    setState(() => _isSubmitting = true);

    // TODO: wire to your testimonial repository/view model.
    // e.g. ref.read(testimonialViewModelProvider.notifier).submit(
    //   type: _mode, text: _textController.text, video: _videoFile,
    // );
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final newExperience = ExperienceModel(
      name: widget.authorName,
      speciality: widget.authorSpeciality,
      experienceType: _mode == TestimonialMode.text
          ? ExperienceType.text
          : ExperienceType.video,
      experience: _mode == TestimonialMode.text
          ? _textController.text.trim()
          : (_videoFile?.path ?? ''),
      addedOn: _formattedToday(),
    );

    setState(() {
      _isSubmitting = false;
      _isSubmitted = true;
      _createdExperience = newExperience;
    });
  }

  void _resetForm() {
    setState(() {
      _isSubmitted = false;
      _createdExperience = null;
      _mode = TestimonialMode.text;
      _textController.clear();
      _removeVideo();
    });
  }

  void _done() {
    // Return the created testimonial to ExperienceListScreen so it can
    // be inserted into the list.
    Navigator.pop(context, _createdExperience);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Share Experience'),
      body: _isSubmitted ? _buildSuccessView() : _buildForm(),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.w(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          height(Responsive.h(20)),
          _buildModeToggle(),
          height(Responsive.h(20)),
          if (_mode == TestimonialMode.text)
            _buildTextInput()
          else
            _buildVideoInput(),
          height(Responsive.h(28)),
          PrimaryButton(
            backgroundColor: AppColors.newPri,
            text: _isSubmitting ? 'Submitting...' : 'Share Testimonial',
            onPressed: _isSubmitting ? null : _submit,
            icon: Icons.send_rounded,
          ),
          height(Responsive.h(12)),
          Center(
            child: Text(
              'Your story helps other doctors make informed decisions',
              textAlign: TextAlign.center,
              style: customTextStyle(
                fontSize: Responsive.sp(11.5),
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                  'Share Your Experience',
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(4)),
                Text(
                  'Tell us about your experience — in your own words or on camera',
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
            icon: Icons.edit_note_rounded,
            mode: TestimonialMode.text,
          ),
          _toggleOption(
            label: 'Video',
            icon: Icons.videocam_rounded,
            mode: TestimonialMode.video,
          ),
        ],
      ),
    );
  }

  Widget _toggleOption({
    required String label,
    required IconData icon,
    required TestimonialMode mode,
  }) {
    final selected = _mode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _mode = mode),
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
    return Container(
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
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.cardRed,
                    side: BorderSide(
                      color: AppColors.cardRed.withValues(alpha: 0.4),
                    ),
                    padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                    ),
                  ),
                ),
              ),
              width(Responsive.w(10)),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickVideo,
                  icon: const Icon(Icons.swap_horiz_rounded, size: 16),
                  label: const Text('Change'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                    ),
                  ),
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
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
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
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Responsive.w(12)),
                  ),
                ),
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
                  padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Responsive.w(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

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
      if (mounted) setState(() {});
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
