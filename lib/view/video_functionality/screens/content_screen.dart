import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/video_functionality/screens/like_icon.dart';
import 'package:shortnews/view/video_functionality/screens/options_screen.dart';

import 'package:video_player/video_player.dart';

class ContentScreen extends StatefulWidget {
  final String? src;
  final String? title;

  const ContentScreen({Key? key, this.src, this.title}) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  bool _isMuted = true;
  bool _isAudioOn = true;
  bool showButton = false;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.src!);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    _videoPlayerController.setVolume(0.0);
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  void _toggleAudio() {
    setState(() {
      _isAudioOn = !_isAudioOn;
      if (_isAudioOn) {
        _videoPlayerController.setVolume(1.0);
      } else {
        _videoPlayerController.setVolume(0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  _toggleAudio();
                },
              
                child: Chewie(
                  controller: _chewieController!,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...')
                ],
              ),
        if (!_isAudioOn)
          Positioned(
            top: 50.h,
            child: InkWell(
              onTap: () {
                _toggleAudio();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                      20,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    _isAudioOn ? Icons.mic : Icons.mic_off,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
          ),
        OptionsScreen(widget.title!)
      ],
    );
  }
}
