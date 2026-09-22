import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/video_player_screen.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  builder: (_) =>
                      VideoPlayerScreen(videoUrl: videoUrl, title: title),
                ),
              );
            },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Responsive.w(14)),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.newPri.withValues(alpha: 0.92),
                      const Color(0xFF1E1B4B),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: -18,
                top: -18,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.07),
                  ),
                ),
              ),
              Positioned(
                left: -28,
                bottom: -28,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(Responsive.w(14)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    hasVideo
                        ? Icons.play_arrow_rounded
                        : Icons.videocam_off_rounded,
                    color: AppColors.newPri,
                    size: Responsive.sp(28),
                  ),
                ),
              ),
              Positioned(
                left: Responsive.w(12),
                right: Responsive.w(12),
                bottom: Responsive.h(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.videocam_rounded,
                      color: Colors.white,
                      size: Responsive.sp(14),
                    ),
                    width(Responsive.w(6)),
                    Expanded(
                      child: Text(
                        hasVideo ? 'Tap to watch video' : 'Video unavailable',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(11),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentPreviewTile extends StatelessWidget {
  const DocumentPreviewTile({
    super.key,
    required this.fileUrl,
    this.label = 'Document',
  });

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
      borderRadius: BorderRadius.circular(Responsive.w(14)),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(14)),
        decoration: BoxDecoration(
          color: context.secondaryWidgetColor,
          borderRadius: BorderRadius.circular(Responsive.w(14)),
          border: Border.all(color: context.secondaryWidgetColor,),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.w(10)),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.picture_as_pdf_rounded,
                color: Colors.red,
                size: Responsive.sp(22),
              ),
            ),
            width(Responsive.w(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: Responsive.sp(12.5),
                      fontWeight: FontWeight.w600,
                      color: context.secondaryTextColor,
                    ),
                  ),
                  height(Responsive.h(2)),
                  Text(
                    hasFile ? 'Tap to open document' : 'No document attached',
                    style: customTextStyle(
                      fontSize: Responsive.sp(10.5),
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            if (hasFile)
              Icon(
                Icons.open_in_new_rounded,
                size: Responsive.sp(18),
                color: AppColors.newPri,
              ),
          ],
        ),
      ),
    );
  }
}
