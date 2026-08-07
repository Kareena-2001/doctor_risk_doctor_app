import 'package:flutter/material.dart';

enum ForumContentType {
  experience,
  blog,
  news,
  circular,
  notification,
}

extension ForumContentTypeX on ForumContentType {
  String get label {
    switch (this) {
      case ForumContentType.experience:
        return 'Experience';

      case ForumContentType.blog:
        return 'Blog';

      case ForumContentType.news:
        return 'News';

      case ForumContentType.circular:
        return 'Circulars';

      case ForumContentType.notification:
        return 'Notifications';
    }
  }

  IconData get icon {
    switch (this) {
      case ForumContentType.experience:
        return Icons.auto_stories_rounded;

      case ForumContentType.blog:
        return Icons.article_rounded;

      case ForumContentType.news:
        return Icons.newspaper_rounded;

      case ForumContentType.circular:
        return Icons.description_rounded;

      case ForumContentType.notification:
        return Icons.notifications_rounded;
    }
  }

  Color get color {
    switch (this) {
      case ForumContentType.experience:
        return const Color(0xFFE67E22);

      case ForumContentType.blog:
        return const Color(0xFF6C63FF);

      case ForumContentType.news:
        return const Color(0xFF3498DB);

      case ForumContentType.circular:
        return const Color(0xFF27AE60);

      case ForumContentType.notification:
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