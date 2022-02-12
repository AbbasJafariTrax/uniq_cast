import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class TestFile extends StatelessWidget {
  static const routeName = "test_file_page";

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer.network(
        "https://mnmedias.api.telequebec.tv/m3u8/29880.m3u8",
        betterPlayerConfiguration: const BetterPlayerConfiguration(
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:uniq_cast_test/general/my_loader.dart';
// import 'package:video_player/video_player.dart';
//
// class TestFile extends StatefulWidget {
//   static const routeName = "test_file";
//
//   @override
//   _TestFileState createState() => _TestFileState();
// }
//
// class _TestFileState extends State<TestFile> {
//   bool isLoading = true;
//   final videoPlayerController = VideoPlayerController.network(
//     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//   );
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initPlayer();
//   }
//
//   void initPlayer() async {
//
//     await videoPlayerController.initialize();
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       autoPlay: true,
//       looping: true,
//     );
//
//     Size deviceSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Example player"),
//       ),
//       body: isLoading
//           ? myLoader(deviceSize)
//           : AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Chewie(
//                 controller: chewieController,
//               ),
//             ),
//     );
//   }
// }
