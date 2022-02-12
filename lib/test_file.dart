import 'package:flutter/material.dart';

class TestFile extends StatefulWidget {
  static const routeName = "test_file_page";

  @override
  State<TestFile> createState() => _TestFileState();
}

class _TestFileState extends State<TestFile> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Container(
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: CircleBorder(),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0 * animationController.value),
                  child: child,
                ),
              );
            },
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: IconButton(
                onPressed: () {},
                color: Colors.blue,
                icon: Icon(Icons.calendar_today, size: 24),
              ),
            ),
          ),
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
