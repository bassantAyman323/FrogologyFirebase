import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduationproj1/localization/demo_localization.dart';
import 'package:graduationproj1/localization/demo_localization_setup.dart';
import 'package:graduationproj1/routes/custome_router.dart';
import 'package:graduationproj1/routes/route_names.dart';
import 'package:graduationproj1/shared/cubit/langcubit.dart';
import 'package:graduationproj1/shared/cubit/langstates.dart';
import 'package:graduationproj1/shared/cubit/providers.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:graduationproj1/modules/fingerprint_page.dart';
import 'package:graduationproj1/network/local/cache_helper.dart';
import 'package:graduationproj1/shared/cubit/cubit.dart';
import 'package:graduationproj1/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'models/onBoarding.dart';

//zety HexColor("#819b6d")
//navigation HexColor("#f7cc72")
//buttons HexColor("#"e8885b"")
void main() async {
  //firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ///////
  final keyApplicationId = 'WMhAOccz2tiIyj9AtUpnKtIlBFSIiORDXAxLbRlz';
  final keyClientKey = '7wbInTRliVWZnERIurHY35hHTO7OEkoG5XXVjKDy';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  // var firstObject = ParseObject('FirstClass')
  //   ..set(
  //       'message', 'Hey ! First message from Flutter. Parse is now connected');
  // await firstObject.save();
  //
  // print('done');
  //shared pref start
  // var myAcl = new ParseACL();
  // myAcl.setPublicReadAccess(allowed: true);
  // myAcl.setPublicWriteAccess(allowed: true);
// so we van add our unity preparation now................................
  //lets push
  await CacheHelper.init();
  //onboarding

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //darkmode
  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  if (onBoarding != null) {
    widget = FingerprintPage();
  } else {
    widget = OnBoardingScreen();
  }
  //need constructor
  runApp(MyApp(isDark, widget));
}

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;
  final Widget startWidget;

  MyApp(
    this.isDark,
    this.startWidget,
  );

  // Locale _locale;
  // static void setLocale(BuildContext context,Locale locale){
  //   _MyAppState state=context.findAncestorStateOfType<_MyAppState>();
  //   state.setLocale(locale);
  // }

  static String title = "Frogology";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //bloc provider for cubit
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context) => LocaleCubit()
              ..toArabic()
              ..toEnglish()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            buildWhen: (previousState, currentState) =>
                previousState != currentState,
            builder: (_, localState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "title",

                //light mood
                theme: ThemeData(
                  backgroundColor: HexColor("#ede5d5"),
                  textTheme: TextTheme(
                    headline1: TextStyle(color: Colors.black),
                    headline2: TextStyle(color: HexColor("#819b6d")),
                    headline5: TextStyle(color: HexColor("#7f996c")),
                    headline6: TextStyle(color: Colors.black87),
                    headline3: TextStyle(color: Colors.black),
                    subtitle1: TextStyle(color: Colors.white),
                    subtitle2: TextStyle(color: Colors.black),
                    button: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  buttonColor: HexColor("#e8885b"),
                  primaryColor: HexColor("#ede5d5"),
                  scaffoldBackgroundColor: HexColor("#ede5d5"),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor("#ede5d5"),
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: HexColor("#ede5d5"),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(color: Colors.black, size: 30),
                    brightness: Brightness.dark,
                    actionsIconTheme:
                        IconThemeData(color: Colors.black, size: 30),
                  ),
                ),
                //dark mood
                darkTheme: ThemeData(
                  backgroundColor: HexColor("#000000"),
                  textTheme: TextTheme(
                    headline1: TextStyle(color: Colors.white),
                    headline2: TextStyle(color: HexColor("#819b6d")),
                    headline5: TextStyle(color: HexColor("#819b6d")),
                    headline6: TextStyle(color: Colors.white),
                    headline4: TextStyle(color: HexColor("##f7cc72")),
                    headline3: TextStyle(color: Colors.white),
                    subtitle1: TextStyle(color: Colors.white),
                    subtitle2: TextStyle(color: Colors.white),
                    button: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  buttonColor: HexColor("#e8885b"),
                  primaryColor: HexColor("#000000"),
                  scaffoldBackgroundColor: HexColor("#000000"),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,
                    brightness: Brightness.light,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor("#000000"),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: HexColor("#000000"),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(color: Colors.white, size: 30.0),
                    actionsIconTheme:
                        IconThemeData(color: Colors.white, size: 30),
                  ),
                ),
                themeMode: AppCubit.get(context).isDark
                    ? ThemeMode.light
                    : ThemeMode.dark,
                onGenerateRoute: CustomRoute.allRoutes,
                // onUnknownRoute: CustomRoute.,
                initialRoute: homeRoute,

                //  localization multi lang
                supportedLocales: DemoLocaliztionSetUp.supportedLocals,
                localizationsDelegates:
                    DemoLocaliztionSetUp.localizationDelegtes,
                localeResolutionCallback:
                    DemoLocaliztionSetUp.localeResolutionCallback,
                locale: localState.locale,

                home: startWidget,
              );
            },
          );
        },
      ),
    );
  }
}

// class AppView extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LocaleCubit, LocaleState>(
//       buildWhen: (previousState, currentState) => previousState != currentState,
//       builder: (_, localState) {
//         return  MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: "title",
//
//           //light mood
//           theme: ThemeData(
//             textTheme: TextTheme(
//               headline1: TextStyle(color: Colors.black),
//               headline2:TextStyle(
//                   color: Colors.black
//               ) ,
//               subtitle1:TextStyle(
//                   color: Colors.black
//               ),
//               button: TextStyle(color: Colors.black,
//
//                   fontSize: 20.0),
//             ),
//
//             primarySwatch: Colors.green,
//             scaffoldBackgroundColor: Colors.white,
//             appBarTheme: AppBarTheme(
//               titleSpacing: 20.0,
//               backwardsCompatibility: false,
//               systemOverlayStyle: SystemUiOverlayStyle(
//                 statusBarColor: Colors.white,
//                 statusBarIconBrightness: Brightness.dark,
//               ),
//               backgroundColor: Colors.white,
//               elevation: 0.0,
//               titleTextStyle: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//               iconTheme: IconThemeData(
//                 color: Colors.black,
//               ),
//
//             ),
//
//           ),
//           //dark mood
//           darkTheme: ThemeData(
//
//             textTheme:TextTheme(
//               headline1: TextStyle(
//                   color: Colors.white
//               ),
//               subtitle1:TextStyle(
//                   color: Colors.white
//               )  ,
//               headline2:TextStyle(
//                   color: Colors.white
//               ) ,
//               button: TextStyle(
//                   color: Colors.white,fontSize: 20.0),
//             ),
//             primarySwatch: Colors.green,
//             //hexa color its library
//             scaffoldBackgroundColor:HexColor("#073642"),
//             appBarTheme: AppBarTheme(
//               titleSpacing: 20.0,
//               backwardsCompatibility: false,
//               systemOverlayStyle: SystemUiOverlayStyle(
//                 statusBarColor:HexColor("#073642"),
//                 statusBarIconBrightness: Brightness.light,
//               ),
//               backgroundColor: HexColor("#073642"),
//               elevation: 0.0,
//               titleTextStyle: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//               iconTheme: IconThemeData(
//                 color: Colors.white,
//               ),
//
//             ),
//           ),
//           themeMode:
//           AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
//           onGenerateRoute: CustomRoute.allRoutes,
//           // onUnknownRoute: CustomRoute.,
//           initialRoute:homeRoute ,
//
//           //  localization multi lang
//           supportedLocales:DemoLocaliztionSetUp.supportedLocals,
//           localizationsDelegates: DemoLocaliztionSetUp.localizationDelegtes,
//           localeResolutionCallback: DemoLocaliztionSetUp.localeResolutionCallback,
//           locale: localState.locale,
//
//
//           home: startWidget,
//         );
//       },
//     );
//   }
// }
