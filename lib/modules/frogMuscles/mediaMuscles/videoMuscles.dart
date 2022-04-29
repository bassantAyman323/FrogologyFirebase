import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<VideoPage> {
  List<Map<String, Object>> VideoList = [
    {
      "id": "1",
      "name": "Frog life cycle",
      "media_url": "assets/FrogVideo.mp4",
      "thump_url": "assets/frog1.jpg",
    },
    {
      "id": "2",
      "name": "Frog simple disscetion",
      "media_url": "assets/videoplayback.mp4",
      "thump_url": "assets/frog1.jpg",
    },
  ];
  VideoPlayerController _controller;

  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.asset('assets/FrogVideo.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(5.0);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Frog life cycle",
                  style: TextStyle(fontSize: 20.0, color: HexColor("#e8885b")),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Stack(
                  children: [
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        child: FloatingActionButton(
                          backgroundColor: HexColor("#819b6d"),
                          onPressed: () {
                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            });
                          },
                          child: Icon(_controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
