import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/video_player_screen.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Tappable 16:9 video preview. Opens [VideoPlayerScreen] with [videoUrl].
///
/// Requires the `url_launcher` package for [DocumentPreviewTile] below:
///   url_launcher: ^6.3.1
class VideoPreviewTile extends StatelessWidget {
  const VideoPreviewTile({super.key, required this.videoUrl, this.title});

  final String videoUrl;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final hasVideo = videoUrl.trim().isNotEmpty;

    return GestureDetector(
      onTap: !hasVideo
          ? null
          : () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPlayerScreen(videoUrl: videoUrl, title: title),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Responsive.w(14)),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.black87,
            child: Center(
              child: Icon(
                hasVideo ? Icons.play_circle_fill_rounded : Icons.videocam_off_rounded,
                color: Colors.white,
                size: Responsive.sp(46),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tappable document row. Opens [fileUrl] in an external viewer.
class DocumentPreviewTile extends StatelessWidget {
  const DocumentPreviewTile({super.key, required this.fileUrl, this.label = 'Document'});

  final String fileUrl;
  final String label;

  Future<void> _openDocument(BuildContext context) async {
    final uri = Uri.tryParse(fileUrl.trim());

    if (uri == null || !await canLaunchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open this document.')),
        );
      }
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final hasFile = fileUrl.trim().isNotEmpty;

    return InkWell(
      onTap: !hasFile ? null : () => _openDocument(context),
      borderRadius: BorderRadius.circular(Responsive.w(12)),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(14)),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.picture_as_pdf_rounded, color: Colors.red, size: Responsive.sp(30)),
            width(Responsive.w(10)),
            Expanded(
              child: Text(
                label,
                style: customTextStyle(
                  fontSize: Responsive.sp(12.5),
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ),
            if (hasFile)
              Icon(Icons.open_in_new_rounded, size: Responsive.sp(18), color: AppColors.newPri),
          ],
        ),
      ),
    );
  }
}