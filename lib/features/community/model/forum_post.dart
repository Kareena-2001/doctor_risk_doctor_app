import 'package:flutter/material.dart';

enum ForumContentType { blog, advisory, testimonial, video }

extension ForumContentTypeX on ForumContentType {
  String get label {
    switch (this) {
      case ForumContentType.blog:
        return 'Blog';
      case ForumContentType.advisory:
        return 'Advisory';
      case ForumContentType.testimonial:
        return 'Testimonial';
      case ForumContentType.video:
        return 'Video';
    }
  }

  IconData get icon {
    switch (this) {
      case ForumContentType.blog:
        return Icons.article_rounded;
      case ForumContentType.advisory:
        return Icons.campaign_rounded;
      case ForumContentType.testimonial:
        return Icons.format_quote_rounded;
      case ForumContentType.video:
        return Icons.play_circle_fill_rounded;
    }
  }

  Color get color {
    switch (this) {
      case ForumContentType.blog:
        return const Color(0xFF6C63FF);
      case ForumContentType.advisory:
        return const Color(0xFFE67E22);
      case ForumContentType.testimonial:
        return const Color(0xFF27AE60);
      case ForumContentType.video:
        return const Color(0xFFE74C3C);
    }
  }
}

class ForumPost {
  final ForumContentType type;
  final String title;
  final String snippet;
  final String source;
  final String date;
  final int likes;
  final bool likedByMe;

  const ForumPost({
    required this.type,
    required this.title,
    required this.snippet,
    required this.source,
    required this.date,
    required this.likes,
    this.likedByMe = false,
  });
}
