import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproj1/api/local_auth_api.dart';
import 'package:graduationproj1/localization/demo_localization.dart';
import 'package:graduationproj1/main.dart';
import 'package:graduationproj1/modules/auth_service.dart';
import 'package:graduationproj1/modules/home_page.dart';
import 'package:graduationproj1/modules/registration.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:graduationproj1/shared/cubit/langcubit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:local_auth/local_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FingerprintPage extends StatefulWidget {
  @override
  State<FingerprintPage> createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> {
  //for validation
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoggedIn = false;
  //sharedpref login
  SharedPreferences logindata;
  bool NewUser;
  String email;
  //firebase
  final _auth = FirebaseAuth.instance;
  ///

  //for the invisible and visible
  bool isPassword = true;

  //form key to submit only if user put name and pass.
  var formKey = GlobalKey<FormState>();

  //login shared pref
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfAlreadyLogin();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              MyApp.title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: Image(
                          image: AssetImage('assets/Logo.png'),
                          fit: BoxFit.contain,
                        ),
                        radius: 60.0,
                        backgroundColor: HexColor("#ede5d5"),
                      ),
                      Text(DemoLocalization.of(context).translate('login'),
                          style: Theme.of(context).textTheme.headline2),
                      SizedBox(height: 40),
                      //already made in the component as widget
                      defaultFormField(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return DemoLocalization.of(context)
                                  .translate('emailmustnotbeempty');
                            }

                            return null;
                          },
                          label:
                              DemoLocalization.of(context).translate('email'),
                          prefix: Icons.email_outlined),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          context: context,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return DemoLocalization.of(context)
                                  .translate('passmustnotbeempty2');
                              ;
                            }

                            return null;
                          },
                          isPassword: isPassword,
                          label: DemoLocalization.of(context)
                              .translate('password'),
                          prefix: Icons.lock_outline,
                          suffix: isPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          suffixPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                              print("clicked me to view");
                            });
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function: () async{
                            String email = emailController.text;
                            String pass = passwordController.text;
                            if (formKey.currentState.validate()) {
                              // try{
                              //   UserCredential user=await FirebaseAuth.instance.signInWithEmailAndPassword(
                              //       email: emailController.text, password: passwordController.text);
                              //   print(user);
                              //
                              // }on FirebaseAuthException catch (e){
                              //   if(e.code=='user-not-found'){
                              //     print("no user with this data");
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           title: const Text("no user with this data"),
                              //           content: const Text("no user with this data"),
                              //           actions: <Widget>[
                              //             new FlatButton(
                              //               child: const Text("OK"),
                              //               onPressed: () {
                              //                 Navigator.of(context).pop();
                              //               },
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //     );
                              //   }else if(e.code=='wrong-password'){
                              //     print("wrong pass");
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           title: const Text("wrong pass"),
                              //           content: const Text("User was successfully created!"),
                              //           actions: <Widget>[
                              //             new FlatButton(
                              //               child: const Text("OK"),
                              //               onPressed: () {
                              //                 Navigator.of(context).pop();
                              //               },
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //     );
                              //
                              //
                              //   }
                              // }catch(e){print(e);
                              //
                              //
                              // }
                              AuthServices().signIn(emailController.text, passwordController.text
                              );
                              navigateReplace(context, HomePage());
                              logindata.setBool('login', false);
                              logindata.setString('email', email);
                              print(emailController.text);
                              print(passwordController.text);

                              doUserLogin();





                            }
                          },
                          text:
                              DemoLocalization.of(context).translate('submit'),
                          style: Theme.of(context).textTheme.button,
                          background: HexColor("#e8885b"),
                          isUpperCase: true),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DemoLocalization.of(context)
                                .translate('donthaveacc'),
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, Registration());
                            },
                            child: Text(
                              DemoLocalization.of(context)
                                  .translate('register'),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ],
                      ),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DemoLocalization.of(context)
                                  .translate('fingerprint'),
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            // Image.asset(
                            //   'assets/5-2-fingerprint-png.png',
                            //   width: 30.0,
                            // ),
                            // SizedBox(height: 24),
                            // buildAvailability(context),
                            SizedBox(height: 24),
                            buildAuthenticate(context),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  // Widget buildAvailability(BuildContext context) => TextButton(
  //       text: 'Check Availability',
  //       icon: Icons.event_available,
  //       onClicked: () async {
  //         final isAvailable = await LocalAuthApi.hasBiometrics();
  //         final biometrics = await LocalAuthApi.getBiometrics();
  //
  //         final hasFingerprint = biometrics.contains(BiometricType.fingerprint);
  //
  //         showDialog(
  //           context: context,
  //           builder: (context) => AlertDialog(
  //             title: Text('Availability'),
  //             content: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 buildText('Biometrics', isAvailable),
  //                 buildText('Fingerprint', hasFingerprint),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );

  // Widget buildText(String text, bool checked) => Container(
  //       margin: EdgeInsets.symmetric(vertical: 8),
  //       child: Row(
  //         children: [
  //           checked
  //               ? Icon(Icons.check, color: Colors.green, size: 24)
  //               : Icon(Icons.close, color: Colors.red, size: 24),
  //           const SizedBox(width: 12),
  //           Text(text, style: TextStyle(fontSize: 24)),
  //         ],
  //       ),
  //     );

  Widget buildAuthenticate(BuildContext context) => Gest(
        // text: 'Authenticate',
        // icon: Icons.lock_open,

        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate(context);
          logindata.setString('email', '');

          if (isAuthenticated) {
            navigateReplace(context, HomePage());
          }
        },
      );

  Widget TextButton3({
    @required String text,
    @required IconData icon,
    @required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );

  Widget Gest({@required VoidCallback onClicked}) => GestureDetector(
      child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/5-2-fingerprint-png.png"),
                fit: BoxFit.contain),
          )),
      onTap: onClicked);

  //sharedpref login
  void checkIfAlreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    NewUser = (logindata.getBool('login') ?? true);
    print(NewUser);
    if (NewUser == false) {
      navigateReplace(context, HomePage());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(DemoLocalization.of(context).translate('title')),
    );
  }
  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final user = ParseUser(email, password, null);

    var response = await user.login();

    if (response.success) {
      // showSuccess("User was successfully login!");
      setState(() {
        isLoggedIn = true;
        navigateToUser();
      });
    } else {
      showError(response.error.message);
    }

  }
  void navigateToUser() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => UserPage()),
          (Route<dynamic> route) => false,
    );
  }

}
class UserPage extends StatelessWidget {
  ParseUser currentUser;

  Future<ParseUser> getUser() async {
  }

  @override
  Widget build(BuildContext context) {
    void doUserLogout() async {
      var response = await currentUser.logout();
      if (response.success) {
        Message.showSuccess(
            context: context,
            message: 'User was successfully logout!',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => FingerprintPage()),
                    (Route<dynamic> route) => false,
              );
            });
      } else {
        Message.showError(context: context, message: response.error.message);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('User logged in - Current User'),
        ),
        body: FutureBuilder<ParseUser>(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  );
                default:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text('Hello, ${snapshot.data.username}')),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 50,
                          child: ElevatedButton(
                            child: const Text('Logout'),
                            onPressed: () => doUserLogout(),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }));
  }
}
class Message {
  static Future<void> showSuccess({ BuildContext context,
    String message,
    VoidCallback onPressed}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static void showError({ BuildContext context,
    String message,
    VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(message),
          actions: <Widget>[
            new ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
