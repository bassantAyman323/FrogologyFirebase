import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

class AudioPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  // AudioPlayer audioPlayer = new AudioPlayer();
  // Duration duration = new Duration();
  // Duration position = new Duration();

  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Material(

        // child: Container(
        //   color: Colors.white,
        //
        //   padding: EdgeInsets.all(20) ,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
        //
        //     children: <Widget>[
        //       Image(image: AssetImage('assets/img.png'),),
        //       slider(),
        //
        //          InkWell(
        //           onTap: (){
        //             getAudio();
        //           } ,
        //           child: Icon(
        //             playing == false
        //
        //               ? Icons.play_circle_outline
        //                 :Icons.pause_circle_outline,
        //            size:100,
        //           ),
        //         ),
        //
        //     ],
        //   ),
        // ),
        );
  }

//   Widget slider(){
//
//     return Slider.adaptive(
//         min: 0.0,
//         value: position.inSeconds.toDouble(),
//         max: duration.inSeconds.toDouble(),
//         onChanged: (double value){
//           setState(() {
//             audioPlayer.seek(new Duration(seconds: value.toInt()));
//
//           });
//         }
//     );
//   }
//   void getAudio() async{
//     var url = "assets/sound/audio.mp3";
//     if (playing){
//       //pause song
//       var res = await audioPlayer.pause();
//       if(res==1){
//         setState(() {
//           playing=false;
//         });
//       }
//     }else{
//       //play song
//       var res = await audioPlayer.play(url);
//       if (res==1){
//         setState(() {
//           playing= true;
//         });
//       }
//     }
// audioPlayer.onDurationChanged.listen((Duration dd) {
//   setState(() {
//     duration = dd;
//
// }); });
// audioPlayer.onAudioPositionChanged.listen((Duration dd) {
//   setState(() {
//     position = dd;
//
//   });
// });
//   }

}
