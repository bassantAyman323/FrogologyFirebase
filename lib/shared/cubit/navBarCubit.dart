import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproj1/modules/frogMuscles/arFrogMuscles.dart';
import 'package:graduationproj1/modules/frogMuscles/detailsFrogMuscles.dart';
import 'package:graduationproj1/modules/frogSkin/FrogSkinHome.dart';
import '../../modules/frogMuscles/FrogMusclesHome.dart';
import '../../modules/frogSkin/arFrogSkin.dart';
import '../../modules/frogSkin/detailsFrogSkin.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../layout/frogSkinLayout.dart';
import 'package:graduationproj1/shared/cubit/navBarState.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(AppInitialState());

  static NavBarCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    DetailsFrogSkin(),
    FrogSkinHome(),
    ARFrogSkin(),
  ];
  List<String> titles = [
    'Frog Skin',
    'Frog Skin',
    'Using AR',
  ];
  List<Widget> screensMuscles = [
    DetailsFrogMuscles(),
    FrogMusclesHome(),
    ARFrogMuscles(),
  ];
  List<String> titlesMuscles = [
    'Frog Muscles',
    'Frog Muscles',
    'Using AR',
  ];
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.auto_awesome_motion,
      ),
      label: 'Details',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.camera,
      ),
      label: 'Open Camera',
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) DetailsFrogSkin();
    if (index == 2) ARFrogSkin();
    emit(NewsBottomNavState());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }
}
