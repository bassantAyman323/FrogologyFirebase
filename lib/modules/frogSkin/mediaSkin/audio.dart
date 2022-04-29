import 'package:flutter/material.dart';

// import 'package:assets_audio_player/assets_audio_player.dart';
class AudioPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  // AssetsAudioPlayer player2=AssetsAudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // player2.open(Audio("assets/sound/audio.mp3"),autoStart: false,showNotification: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          onPressed: () {
            // player2.play();
          },
          child: Text("click me"),
        ),
      ),
    );
  }
}
