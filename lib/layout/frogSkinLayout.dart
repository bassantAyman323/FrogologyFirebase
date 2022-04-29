import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:graduationproj1/modules/frogSkin/mediaSkin/audio.dart';
import 'package:graduationproj1/modules/frogSkin/mediaSkin/pdf.dart';
import 'package:graduationproj1/modules/frogSkin/mediaSkin/quizePage.dart';
import 'package:graduationproj1/modules/frogSkin/mediaSkin/video.dart';

import 'package:graduationproj1/shared/components/components.dart';
import 'package:graduationproj1/shared/cubit/navBarCubit.dart';
import 'package:graduationproj1/shared/cubit/navBarState.dart';
import 'package:hexcolor/hexcolor.dart';

class FrogSkinLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NavBarCubit(),
      child: BlocConsumer<NavBarCubit, NavBarState>(
        listener: (BuildContext context, NavBarState state) {},
        builder: (BuildContext context, NavBarState state) {
          NavBarCubit cubit = NavBarCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex],
                  style: Theme.of(context).textTheme.headline5),
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: SpeedDial(
              icon: Icons.perm_media,
              heroTag: "one",
              backgroundColor: HexColor("#819b6d"),
              animatedIcon: AnimatedIcons.menu_close,
              overlayColor: HexColor("#efe8d8"),
              overlayOpacity: 0.0,
              children: [
                SpeedDialChild(
                  child: Icon(
                    Icons.picture_as_pdf,
                    color: Colors.white,
                  ),
                  label: "Pdfs",
                  backgroundColor: HexColor("#e8885b"),
                  onTap: () => navigateTo(context, PdfPage()),
                ),
                SpeedDialChild(
                  child: Icon(
                    Icons.video_collection,
                    color: Colors.white,
                  ),
                  label: "Videos",
                  backgroundColor: HexColor("#e8885b"),
                  onTap: () => navigateTo(context, VideoPage()),
                ),
                SpeedDialChild(
                  child: Icon(
                    Icons.audiotrack,
                    color: Colors.white,
                  ),
                  label: "Audios",
                  backgroundColor: HexColor("#e8885b"),
                  onTap: () => navigateTo(context, AudioPage()),
                ),
                SpeedDialChild(
                  child: Icon(
                    Icons.quiz_outlined,
                    color: Colors.white,
                  ),
                  label: "Quize",
                  backgroundColor: HexColor("#e8885b"),
                  onTap: () => navigateTo(context, QuizePage()),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                selectedIconTheme: IconThemeData(color: HexColor("#e8885b")),
                selectedFontSize: 17.0,
                selectedItemColor: HexColor("#e8885b"),
                iconSize: 25.0,
                unselectedItemColor: HexColor("#98b089"),
                unselectedIconTheme: IconThemeData(color: HexColor("#98b089")),
                elevation: 0.0,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                currentIndex: cubit.currentIndex,
                items: cubit.bottomItems),
          );
        },
      ),
    );
  }
}
