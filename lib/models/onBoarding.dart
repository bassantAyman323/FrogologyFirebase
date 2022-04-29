import 'package:flutter/material.dart';
import 'package:graduationproj1/modules/fingerprint_page.dart';
import 'package:graduationproj1/network/local/cache_helper.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/013-edit-1.png',
      title: '3d programming',
      body:
          'View 3D frog with all details that help you understand the structure of it.',
    ),
    BoardingModel(
      image: 'assets/R.png',
      title: 'AR Model',
      body:
          'View AR model with all details that help you understand the structure of it and look like a real life experience.',
    ),
    BoardingModel(
      image: 'assets/3800860.png',
      title: 'Learning',
      body: 'All the information that help you understand frog antomy.',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          FingerprintPage(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SmoothPageIndicator(
                    controller: boardController,
                    effect: ScrollingDotsEffect(
                      dotColor: Colors.black,
                      activeDotColor: Colors.black,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: boarding.length,
                  ),
                ),
                Spacer(),
                if (isLast)
                  TextButton(
                    child: Text(
                      "Got it",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    // child: Icon(
                    //   Icons.arrow_forward_ios,
                    // ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Text(
              '${model.title}',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text(
              '${model.body}',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
