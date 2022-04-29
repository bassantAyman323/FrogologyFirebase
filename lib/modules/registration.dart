import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduationproj1/localization/demo_localization.dart';
import 'package:graduationproj1/main.dart';
import 'package:graduationproj1/modules/auth_service.dart';
import 'package:graduationproj1/modules/db_service.dart';
import 'package:graduationproj1/modules/fingerprint_page.dart';
import 'package:graduationproj1/modules/users.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'home_page.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  //form key to submit only if user put name and pass.
  var formKey = GlobalKey<FormState>();
  PickedFile pickedFile;
  bool isLoading = false;
//image picker
  //firebase
  final _auth = FirebaseAuth.instance;
  ////

  //for validation
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var jobController = TextEditingController();

//DropDown menu
//   final items = ['student', 'lecturer assistent'];
  String value;
  bool isPassword = true;
  String password = '';

  //sharedpref login
  SharedPreferences registerdata;

//image
  File file;

  var name;
  final numericRegix = RegExp(r'[0-9]');
  var email;

//this is temparary save
  Future pickImage() async {
    try {
      PickedFile myfile = await ImagePicker().getImage(source: ImageSource.gallery);
      if (myfile == null) return;
      if (myfile != null) {
        setState(() {
          pickedFile = myfile;
        });
      }


      final file = File(myfile.path);
      setState(() => this.file = file);
    } on PlatformException catch (e) {
      print(DemoLocalization.of(context).translate('Failedtopickimage') + '$e');
    }
  }

  //for permantly save

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title, style: Theme.of(context).textTheme.headline5),
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
                      fit: BoxFit.cover,
                    ),
                    radius: 60.0,
                    backgroundColor: HexColor("#ede5d5"),
                  ),
                  Text(DemoLocalization.of(context).translate('register'),
                      style: Theme.of(context).textTheme.headline2),
                  SizedBox(height: 40),

                  defaultFormField(
                      context: context,
                      controller: nameController,
                      type: TextInputType.name,
                      onsave: (value){
                        name = value;
                      },
                      validate: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .translate('namemustnotbeempty');
                        }
                        return null;
                      },
                      label: DemoLocalization.of(context).translate('name'),
                      prefix: Icons.person),
                  SizedBox(height: 15),
                  //already made in the component as widget
                  defaultFormField(
                      controller: emailController,
                      context: context,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .translate('emailmustnotbeempty');

                        }else if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                          return 'Please, enter a valid Email';
                        }

                        return null;
                      },
                      onsave: ( value){
                        email = value;
                      },
                      label: DemoLocalization.of(context).translate('email'),
                      prefix: Icons.email_outlined),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      context: context,
                      controller: passwordController,
                      onsave: ( value){
                        password = value;
                      },
                      type: TextInputType.visiblePassword,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .translate('passmustnotbeempty');
                        }else if(!numericRegix.hasMatch(value)){
                          return 'Please, enter a valid password ';
                        }

                        return null;
                      },
                      isPassword: isPassword,
                      label: DemoLocalization.of(context).translate('password'),
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
                  // SizedBox(
                  //   height: 20.0,
                  // ), 
                  //
                  // FormBuilderDropdown(
                  //   dropdownColor: HexColor("#e8885b"),
                  //   validator: (String value) {
                  //     if (value?.isEmpty ?? true) {
                  //       return DemoLocalization.of(context)
                  //           .translate('pleaseenterjob');
                  //       ;
                  //     }
                  //   },
                  //   decoration: InputDecoration(
                  //     prefixIcon: Icon(Icons.work, color: HexColor("#f1c771")),
                  //     labelText: DemoLocalization.of(context).translate('job'),
                  //     labelStyle: TextStyle(color: HexColor("#f1c771")),
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.black, width: 0.4),
                  //       borderRadius: BorderRadius.circular(25.0),
                  //     ),
                  //
                  //   ),
                  //
                  //   // initialValue: 'Male',
                  //
                  //   items: [
                  //     DemoLocalization.of(context).translate('Student'),
                  //     DemoLocalization.of(context)
                  //         .translate('Lecturerassistant')
                  //   ]
                  //       .map((gender) => DropdownMenuItem(
                  //     value: gender,
                  //     onTap: (){
                  //       jobController.text=gender;
                  //       print(jobController.text);
                  //     },
                  //
                  //
                  //     child: Text('$gender'),
                  //   ))
                  //       .toList(),
                  // ),
                  // old drobdown
                  // Center(
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton<String>(
                  //
                  //       value: value,
                  //       hint: Text(DemoLocalization.of(context).translate('job'),style:TextStyle(color:  HexColor("##f7cc72"))),
                  //       // disabledHint: Text("Job",style: Theme.of(context).textTheme.subtitle2,),
                  //       iconSize: 36,
                  //       icon: Icon(Icons.arrow_drop_down),
                  //       isExpanded: true,
                  //       items: items.map(buildMenueItem).toList(),
                  //       onChanged: (value) =>
                  //           setState(() => this.value = value),
                  //     ),
                  //   ),
                  // ),

                  // SizedBox(
                  //   height: 5.0,
                  // ),
                  // Column(
                  //   children: [
                  //     RaisedButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => SavePage()),
                  //         );
                  //       },
                  //
                  //       child: Text(
                  //         DemoLocalization.of(context).translate('uploadimage'),
                  //         style: Theme.of(context).textTheme.subtitle1,
                  //       ),
                  //     ),
                  //     Center(
                  //       child: file == null
                  //           ? Text(
                  //         DemoLocalization.of(context)
                  //             .translate('Failedtopickimage'),
                  //         style: Theme.of(context).textTheme.subtitle2,
                  //       )
                  //           : Image.file(
                  //         file,
                  //         width: 100,
                  //         height: 100,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // RaisedButton(onPressed:getImage() ;),
                  SizedBox(
                    height: 18.0,
                  ),

                  defaultButton(
                      function: ()async {

                        // String email = emailController.text;
                        // String pass = passwordController.text;
                        if (formKey.currentState.validate()) {
                          // try{
                          //   UserCredential user=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text,
                          //       password: passwordController.text);
                          //
                          //   print(user);
                          // }on FirebaseAuthException catch (e){
                          //   if(e.code=='weak-password'){
                          //     print("too weak pass");
                          //   }else if(e.code=='email-already-in-use'){
                          //     print("in use email");
                          //   }
                          // }catch(e){print(e);}
                          // _auth.createUserWithEmailAndPassword(
                          //     email: email, password: password);
                          await AuthServices().signUp(nameController.text, emailController.text, passwordController.text);

                          doUserRegistration();
                          registerdata.setBool('register', false);
                          registerdata.setString('email', email);
                          print(emailController.text);
                          print(passwordController.text);
                          navigateTo(context, HomePage());
                          navigateReplace(context, FingerprintPage());}

                      },
                      text: DemoLocalization.of(context).translate('submit'),
                      style: Theme.of(context).textTheme.button,
                      background: HexColor("#e8885b"),
                      isUpperCase: true),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // RaisedButton(child: Text("upload Image"),onPressed: pickercamera),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          DemoLocalization.of(context)
                              .translate('alreadyhaveacc'),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          doUserRegistration();
                          // navigateTo(context, FingerprintPage());

                        },
                        // child: Text(
                        //     DemoLocalization.of(context).translate('login'),
                        //     style: Theme.of(context).textTheme.headline5),
                      ),

                      TextButton(
                          onPressed: (){
                            navigateTo(context, FingerprintPage());
                          },
                        child: Text(
                            DemoLocalization.of(context).translate('login'),
                            style: Theme.of(context).textTheme.headline5),

                      // // Expanded(
                      // //   child: Text(
                      // //     DemoLocalization.of(context).translate('gotologin'),
                      // //     style: Theme.of(context).textTheme.subtitle1,
                      // //   ),
                      // // ),
                      ),

      ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Registeration Successfully!"),
          content: const Text("User was successfully created!"),
          actions: <Widget>[
            new FlatButton(
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
            new FlatButton(
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

  void doUserRegistration() async {
    final username = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    // final job = jobController.text.trim();

    final user = ParseUser.createUser(username, password, email);
    // user.set('job', jobController.text);
    // await user.save();


    var response = await user.signUp();

    if (response.success) {
      showSuccess();}
    //  else if(response.error != null) {
    //   showError(response.error.message);
    // }
  }
}


