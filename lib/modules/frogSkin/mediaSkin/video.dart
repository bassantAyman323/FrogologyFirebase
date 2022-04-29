import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduationproj1/localization/demo_localization.dart';
import 'package:graduationproj1/models/videoItems.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<VideoPage> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DemoLocalization.of(context).translate('videos'),
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Frog life cycle",
                      style: Theme.of(context).textTheme.headline6),
                  VideoItems(
                    name: "Frog life cycle",
                    videoPlayerController:
                        VideoPlayerController.asset('assets/FrogVideo.mp4'),
                    looping: false,
                    autoplay: false,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            myDivider(),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Frog simple dissection",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  VideoItems(
                    videoPlayerController:
                        VideoPlayerController.asset("assets/videoplayback.mp4"),
                    name: "Frog dissection",
                    looping: false,
                    autoplay: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<VideoItems> names = [
    VideoItems(
      name: "frog life cycle",
      videoPlayerController:
          VideoPlayerController.asset('assets/FrogVideo.mp4'),
      looping: true,
      autoplay: false,
    ),
    VideoItems(
      name: "frog dissection",
      videoPlayerController:
          VideoPlayerController.asset("assets/videoplayback.mp4"),
      looping: true,
      autoplay: false,
    ),
  ];

// final names=["Frog life cycle",
//               "Frog dissection"];

  List<VideoItems> recentnames = [
    VideoItems(
      name: "frog dissection",
      videoPlayerController:
          VideoPlayerController.asset("assets/videoplayback.mp4"),
      looping: true,
      autoplay: false,
    ),
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
        color: HexColor("#96aa88"),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    VideoPlayerController one;
    String name;

    if (query == "frog life cycle") {
      one = VideoPlayerController.asset("assets/FrogVideo.mp4");
      name = "frog life cycle";
    } else {
      one = VideoPlayerController.asset("assets/videoplayback.mp4");
      name = "frog dissection";
    }
    // TODO: implement buildResults
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            VideoItems(
              videoPlayerController: one,
              name: query,
              looping: false,
              autoplay: false,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentnames
        : names.where((p) => p.name.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.video_collection),
        iconColor: HexColor("#96aa88"),
        onTap: () {
          showResults(context);
        },
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].name.substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].name.substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
