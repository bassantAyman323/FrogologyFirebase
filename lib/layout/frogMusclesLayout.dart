import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:graduationproj1/modules/frogMuscles/mediaMuscles/audioMuscles.dart';
import 'package:graduationproj1/modules/frogMuscles/mediaMuscles/pdfMuscles.dart';
import 'package:graduationproj1/modules/frogMuscles/mediaMuscles/quizePageMuscles.dart';
import 'package:graduationproj1/modules/frogMuscles/mediaMuscles/videoMuscles.dart';

import 'package:graduationproj1/shared/components/components.dart';
import 'package:graduationproj1/shared/cubit/navBarCubit.dart';
import 'package:graduationproj1/shared/cubit/navBarState.dart';
import 'package:hexcolor/hexcolor.dart';

class FrogMusclesLayout extends StatelessWidget {
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
              title: Text(
                cubit.titlesMuscles[cubit.currentIndex],
                style: TextStyle(color: HexColor("#819b6d")),
              ),
            ),
            body: cubit.screensMuscles[cubit.currentIndex],
            floatingActionButton: SpeedDial(
              icon: Icons.perm_media,
              heroTag: "one",
              backgroundColor: HexColor("#819b6d"),
              animatedIcon: AnimatedIcons.menu_close,
              overlayColor: HexColor("#efe8d8"),
              overlayOpacity: 0.0,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.picture_as_pdf),
                  label: "Pdfs",
                  backgroundColor: HexColor("#efe8d8"),
                  onTap: () => navigateTo(context, PdfPage()),
                ),
                SpeedDialChild(
                  child: Icon(Icons.video_collection),
                  label: "Videos",
                  backgroundColor: HexColor("#efe8d8"),
                  onTap: () => navigateTo(context, VideoPage()),
                ),
                SpeedDialChild(
                  child: Icon(Icons.audiotrack),
                  label: "Audios",
                  backgroundColor: HexColor("#efe8d8"),
                  onTap: () => navigateTo(context, AudioPage()),
                ),
                SpeedDialChild(
                  child: Icon(Icons.quiz_outlined),
                  label: "Quize",
                  backgroundColor: HexColor("#efe8d8"),
                  onTap: () => navigateTo(context, QuizePage()),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: HexColor("#f7cc72"),
                selectedIconTheme: IconThemeData(color: HexColor("#e8885b")),
                selectedFontSize: 17.0,
                selectedItemColor: HexColor("#e8885b"),
                iconSize: 25.0,
                unselectedItemColor: Colors.white,
                unselectedIconTheme: IconThemeData(color: Colors.white),
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
