import 'dart:async';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

/// Full-screen player used to preview an experience/testimonial video.
///
/// Requires the `video_player` package in pubspec.yaml:
///   video_player: ^2.9.2
class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.videoUrl, this.title});

  final String videoUrl;
  final String? title;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerController _controller;
  Future<void>? _initializeFuture;
  Timer? _hideControlsTimer;
  bool _showControls = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..addListener(_onVideoStateChanged);

    _initializeFuture = _initializePlayer();
  }

  Future<void> _initializePlayer() {
    return _controller
        .initialize()
        .then((_) {
      if (!mounted) return;
      _hasError = false;
      _controller.play();
      _startHideControlsTimer();
      setState(() {});
    })
        .catchError((_) {
      if (!mounted) return;
      setState(() => _hasError = true);
    });
  }

  void _onVideoStateChanged() {
    if (mounted) setState(() {});
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (_controller.value.isPlaying) {
        setState(() => _showControls = false);
      }
    });
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
      _startHideControlsTimer();
    }
    setState(() {});
  }

  void _toggleControlsVisibility() {
    setState(() => _showControls = !_showControls);
    if (_showControls && _controller.value.isPlaying) {
      _startHideControlsTimer();
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _controller.removeListener(_onVideoStateChanged);
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title ?? 'Video',
          style: customTextStyle(fontSize: Responsive.sp(15), color: Colors.white),
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeFuture,
        builder: (context, snapshot) {
          if (_hasError || snapshot.hasError) {
            return _buildErrorState();
          }

          if (snapshot.connectionState != ConnectionState.done ||
              !_controller.value.isInitialized) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          return GestureDetector(
            onTap: _toggleControlsVisibility,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio == 0
                        ? 16 / 9
                        : _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  if (_showControls) _buildControlsOverlay(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Responsive.w(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: Responsive.sp(42), color: AppColors.cardRed),
            height(Responsive.h(12)),
            Text(
              'Unable to play this video.',
              textAlign: TextAlign.center,
              style: customTextStyle(fontSize: Responsive.sp(13), color: Colors.white70),
            ),
            height(Responsive.h(16)),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white54),
              ),
              onPressed: () => setState(() => _initializeFuture = _initializePlayer()),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlsOverlay() {
    final value = _controller.value;
    final position = value.position;
    final duration = value.duration;
    final maxMs = duration.inMilliseconds > 0 ? duration.inMilliseconds.toDouble() : 1.0;
    final posMs = position.inMilliseconds.clamp(0, duration.inMilliseconds).toDouble();

    return Container(
      color: Colors.black.withValues(alpha: 0.25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: Responsive.sp(56),
            icon: Icon(
              value.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
              color: Colors.white,
            ),
            onPressed: _togglePlayPause,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.w(12), vertical: Responsive.h(8)),
            child: Row(
              children: [
                Text(
                  _formatDuration(position),
                  style: customTextStyle(fontSize: Responsive.sp(11), color: Colors.white),
                ),
                width(Responsive.w(8)),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2.5,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                      activeTrackColor: AppColors.newPri,
                      inactiveTrackColor: Colors.white30,
                      thumbColor: AppColors.newPri,
                    ),
                    child: Slider(
                      min: 0,
                      max: maxMs,
                      value: posMs,
                      onChanged: (newValue) {
                        _controller.seekTo(Duration(milliseconds: newValue.toInt()));
                      },
                      onChangeStart: (_) => _hideControlsTimer?.cancel(),
                      onChangeEnd: (_) {
                        if (value.isPlaying) _startHideControlsTimer();
                      },
                    ),
                  ),
                ),
                width(Responsive.w(8)),
                Text(
                  _formatDuration(duration),
                  style: customTextStyle(fontSize: Responsive.sp(11), color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}