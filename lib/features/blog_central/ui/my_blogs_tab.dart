import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../home/ui/widgets/social_link_widget.dart';

class MyBlogsTab extends StatelessWidget {
  const MyBlogsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final blogs = [
      {
        "title": "How to Avoid Medico Legal Cases",
        "content":
            "Important practices doctors can follow to reduce medico-legal risks and handle clinical situations more effectively.",
        "image": "https://picsum.photos/600/300?random=11",
        "status": "Pending",
        "date": "12 Jul 2026",
      },
      {
        "title": "Professional Indemnity Insurance",
        "content":
            "A practical overview of professional indemnity insurance and why it is important for doctors.",
        "image": "https://picsum.photos/600/300?random=12",
        "status": "Approved",
        "date": "10 Jul 2026",
      },
      {
        "title": "Medical Documentation Tips",
        "content":
            "Simple documentation practices that can help doctors maintain accurate and useful medical records.",
        "image": "https://picsum.photos/600/300?random=13",
        "status": "Not Approved",
        "date": "08 Jul 2026",
      },
    ];

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        Responsive.w(16),
        0,
        Responsive.w(16),
        Responsive.h(24),
      ),
      itemCount: blogs.length + 1,
      separatorBuilder: (_, __) => height(Responsive.h(14)),
      itemBuilder: (context, index) {
        if (index == blogs.length) {
          return Column(
            children: [SocialLinkWidget(), height(Responsive.h(30))],
          );
        }

        final blog = blogs[index];

        return _buildBlogCard(context, blog);
      },
    );
  }

  Widget _buildBlogCard(BuildContext context, Map<String, String> blog) {
    final status = blog["status"] ?? "Pending";

    Color statusColor;

    switch (status) {
      case "Approved":
        statusColor = const Color(0xFF10B981);
        break;

      case "Not Approved":
        statusColor = const Color(0xFFEF4444);
        break;

      default:
        statusColor = const Color(0xFFF59E0B);
    }

    final isRejected = status == "Not Approved";

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Responsive.w(16)),
            ),
            child: Image.network(
              blog["image"] ?? "",
              width: double.infinity,
              height: Responsive.h(150),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: double.infinity,
                  height: Responsive.h(150),
                  color: Colors.grey.shade100,
                  child: Icon(
                    Icons.image_outlined,
                    size: Responsive.sp(40),
                    color: Colors.grey.shade400,
                  ),
                );
              },
            ),
          ),

          // Blog Content
          Padding(
            padding: EdgeInsets.all(Responsive.w(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        blog["title"] ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(14),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ).copyWith(height: 1.4),
                      ),
                    ),

                    width(Responsive.w(10)),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.w(9),
                        vertical: Responsive.h(5),
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(Responsive.w(30)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: Responsive.w(6),
                            height: Responsive.w(6),
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          width(Responsive.w(5)),
                          Text(
                            status,
                            style: customTextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.sp(9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                height(Responsive.h(8)),

                // Article Preview
                Text(
                  blog["content"] ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    color: Colors.grey.shade600,
                  ).copyWith(height: 1.45),
                ),

                height(Responsive.h(10)),

                // Submitted Date
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: Responsive.sp(13),
                      color: Colors.grey.shade500,
                    ),
                    width(Responsive.w(5)),
                    Text(
                      "Submitted : ${blog["date"]}",
                      style: customTextStyle(
                        color: Colors.grey.shade600,
                        fontSize: Responsive.sp(10.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // Rejected Actions
                if (isRejected) ...[
                  height(Responsive.h(14)),

                  Divider(height: 1, thickness: 1, color: Colors.grey.shade100),

                  height(Responsive.h(12)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: Icon(
                            Icons.edit_outlined,
                            size: Responsive.sp(16),
                          ),
                          onPressed: () {
                            context.push(Routes.addBlog);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey.shade700,
                            side: BorderSide(color: Colors.grey.shade300),
                            minimumSize: Size(
                              double.infinity,
                              Responsive.h(40),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.w(12),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Responsive.w(10),
                              ),
                            ),
                          ),
                          label: Text(
                            "Edit",
                            style: customTextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Responsive.sp(11),
                            ),
                          ),
                        ),
                      ),

                      width(Responsive.w(10)),

                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.refresh_rounded,
                            size: Responsive.sp(16),
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // TODO: Resubmit blog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            minimumSize: Size(
                              double.infinity,
                              Responsive.h(40),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.w(12),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Responsive.w(10),
                              ),
                            ),
                          ),
                          label: Text(
                            "Resubmit",
                            style: customTextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: Responsive.sp(11),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
