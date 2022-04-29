import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
class FrogSkinHome extends StatefulWidget {
  @override
  _CubeState createState() => _CubeState();
}

class _CubeState extends State<FrogSkinHome> {
  Object jet;

  void initState() {

    jet=Object(fileName: "assets/jet/12268_banjofrog_v1_L3.obj");
    jet.rotation.setValues(-60, 180, 0);
    jet.updateTransform();


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        child: Column(
          children: [
            Expanded(
              child: Cube(
                onSceneCreated: (Scene scene) {
                  scene.world.add(jet);
                  // loadImageFromAsset('assets/frog/frog.jpg').then((value) {
                  //   frog.mesh.texture = value;
                  //   scene.updateTexture();
                  // });
                  scene.camera.zoom = 7;
                },
              ),
            ),


          ],
        ),
      ),
    );

  }}
