// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:responsive_sizer/responsive_sizer.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// // class VideoPlyerScreens extends StatefulWidget {
// //   final String video;

// //   const VideoPlyerScreens({super.key, required this.video});

// //   @override
// //   State<VideoPlyerScreens> createState() => _VideoPlyerScreensState();
// // }

// // class _VideoPlyerScreensState extends State<VideoPlyerScreens> {
// //   late YoutubePlayerController _controller;
// //   bool _showProgressIndicator = true;
// //   bool _isFullScreen = false;
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     _controller = YoutubePlayerController(
// //       initialVideoId: YoutubePlayer.convertUrlToId(widget.video).toString(),
// //       flags: YoutubePlayerFlags(
// //           autoPlay: true,
// //           mute: false,
// //           disableDragSeek: false,
// //           loop: false,
// //           isLive: false,
// //           forceHD: false,
// //           //hideControls: true,
// //           showLiveFullscreenButton: false),
// //     )..addListener(() {
// //         if (_controller.value.playerState == PlayerState.ended) {
// //           setState(() {
// //             _showProgressIndicator = false;
// //           });
// //         }
// //       });
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return YoutubePlayer(
// //       controller: _controller,
// //       showVideoProgressIndicator: true,
// //       progressIndicatorColor: Colors.transparent,
// //       onEnded: (metaData) {
// //         _controller.load(_controller.metadata.videoId);
// //       },
// //       onReady: () {},
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   final String videoUrl;

//   const VideoPlayerScreen({super.key, required this.videoUrl});

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late YoutubePlayerController _controller;
//   bool _isFullScreen = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: true,
//         showLiveFullscreenButton: true,
//       ),
//     );

//     _controller.addListener(_youtubePlayerListener);
//   }

//   void _youtubePlayerListener() {
//     if (_controller.value.isFullScreen && !_isFullScreen) {
//       setState(() {
//         _isFullScreen = true;
//       });
//     } else if (!_controller.value.isFullScreen && _isFullScreen) {
//       setState(() {
//         _isFullScreen = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_youtubePlayerListener);
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerBuilder(
//       player: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//         onReady: () {
//           _controller.addListener(() {
//             setState(() {});
//           });
//         },
//         onEnded: (metaData) {
//           _controller.seekTo(Duration.zero);
//           _controller.play();
//         },
//       ),
//       builder: (context, player) {
//         return  
//               // Video player
//               Container(
//                 height: 30.h, // Adjust the height as needed
//                 child: player,
            
          
//         );
//       },
//     );
//   }
// }

