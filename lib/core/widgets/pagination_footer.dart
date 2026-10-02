import 'package:flutter/material.dart';

class PaginationFooter extends StatefulWidget {
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onLoadMore;
  final String? errorMessage;

  const PaginationFooter({
    super.key,
    required this.hasMore,
    required this.isLoading,
    required this.onLoadMore,
    this.errorMessage,
  });

  @override
  State<PaginationFooter> createState() => _PaginationFooterState();
}

class _PaginationFooterState extends State<PaginationFooter> {
  ScrollPosition? _scrollPosition;
  bool _autoLoadRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nextPosition = Scrollable.maybeOf(context)?.position;
    if (_scrollPosition != nextPosition) {
      _scrollPosition?.removeListener(_checkForMore);
      _scrollPosition = nextPosition;
      _scrollPosition?.addListener(_checkForMore);
    }
    _scheduleCheck();
  }

  @override
  void didUpdateWidget(covariant PaginationFooter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading && !widget.isLoading) {
      _autoLoadRequested = false;
    }
    if (oldWidget.hasMore != widget.hasMore ||
        oldWidget.isLoading != widget.isLoading ||
        oldWidget.errorMessage != widget.errorMessage) {
      _scheduleCheck();
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_checkForMore);
    super.dispose();
  }

  void _scheduleCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _checkForMore();
    });
  }

  void _checkForMore() {
    final position = _scrollPosition;
    if (!mounted ||
        position == null ||
        !position.hasContentDimensions ||
        !widget.hasMore ||
        widget.isLoading ||
        widget.errorMessage != null ||
        _autoLoadRequested ||
        position.extentAfter > 200) {
      return;
    }

    _autoLoadRequested = true;
    widget.onLoadMore();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.hasMore && widget.errorMessage == null) {
      return const SizedBox.shrink();
    }
    if (widget.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (widget.errorMessage == null) return const SizedBox.shrink();

    return Center(
      child: TextButton(
        onPressed: () {
          _autoLoadRequested = true;
          widget.onLoadMore();
        },
        child: const Text('Could not load more. Tap to retry.'),
      ),
    );
  }
}
