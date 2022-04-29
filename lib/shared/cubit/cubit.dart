import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproj1/network/local/cache_helper.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:graduationproj1/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //darkmode and put in sharedpref
  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    //already have value
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else
    //not have value
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  Locale _locale;
}
