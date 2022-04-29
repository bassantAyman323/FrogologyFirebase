import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<PdfPage> {
  String url =
      "https://wilmaortega.files.wordpress.com/2014/11/frog_and_toad_together.pdf";
  String pdfasset = "assets/frogg.pdf";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Frog book",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SfPdfViewer.network(
          'https://wilmaortega.files.wordpress.com/2014/11/frog_and_toad_together.pdf'),
      // body: Center(child: ,),
    );
  }
}
