import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARFrogSkin extends StatefulWidget {
  @override
  _HelloWorldState createState() => _HelloWorldState();
}

class _HelloWorldState extends State<ARFrogSkin> {
  ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      );

  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    _addToon(arCoreController);
  }
  _addToon(ArCoreController controller){
    final node = ArCoreReferenceNode(
      name: 'Toon',
      object3DFileName:'Toon.sfb',
      scale: vector.Vector3(0.5,0.5,0.5),
      position: vector.Vector3(0,-1,-1),
      rotation: vector.Vector4(10,0,0,0),
    );
    controller.addArCoreNode(node);
  }


  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

