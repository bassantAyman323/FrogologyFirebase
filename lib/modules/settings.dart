import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduationproj1/main.dart';
import 'package:graduationproj1/modules/home_page.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File file;
  var formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;

  var emailController = TextEditingController();
  var nameController = TextEditingController();



  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/Frogmuscles.png")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
  @override
  Widget build(BuildContext context) {
    nameController.text ="Arwa khaled";
    emailController.text ="arwa@gmail.com";

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
                              SizedBox(height: 40),
                              imageProfile(),
                              //       CircleAvatar(
                              //       radius: 70,
                              //       child: Image.network("https://www.publicdomainpictures.net/pictures/270000/velka/avatar-people-person-business-.jpg"),
                              //   backgroundColor: HexColor("#ede5d5"),
                              // ),
                              //          SizedBox(height: 5.0),
                              //          Column(
                              //             children: [
                              //               RaisedButton(
                              //                 onPressed: getImage,
                              //                 child: Text(
                              //                   'change image',
                              //                   style: Theme.of(context).textTheme.subtitle1,
                              //                 ),
                              //               ),
                              //               Center(
                              //                 child: file == null
                              //                     ? Text(
                              //                 'Failedtopickimage',
                              //                   style: Theme.of(context).textTheme.subtitle2,
                              //                 )
                              //                     : Image.file(
                              //                   file,
                              //                   width: 100,
                              //                   height: 100,
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              SizedBox(height: 40),

                              defaultFormField(
                                  context: context,
                                  controller: nameController,

                                  type: TextInputType.name,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'name must not be empty';
                                    }
                                    return null;
                                  },

                                  hint: 'Arwa kahled',
                                  prefix: Icons.person),
                              SizedBox(height: 15),
                              //already made in the component as widget
                              defaultFormField(
                                  controller: emailController,
                                  context: context,
                                  type: TextInputType.emailAddress,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'email must not be empty';

                                    }else if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                        return 'Please, enter a valid Email';
                                      }


                                    return null;
                                  },

                                  hint: ('arwa.khaled@gmail.com'),
                                  prefix: Icons.email_outlined),

                              SizedBox(height: 18.0),

                              defaultButton(

                                  function: () {
                                      if (formKey.currentState.validate()) {
                                    navigateTo(context, HomePage());}
                                  },
                                  text: ('Save'),
                                  style: Theme.of(context).textTheme.button,
                                  background: HexColor("#e8885b"),
                                  isUpperCase: true
                              ),

                            ] )

                    )
                )
            )
        )
    );
  }
}

class SavePage extends StatefulWidget {
  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  PickedFile pickedFile;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload File'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            GestureDetector(
              child: pickedFile != null
                  ? Container(
                  width: 250,
                  height: 250,
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.blue)),
                  child: kIsWeb
                      ? Image.network(pickedFile.path)
                      : Image.file(File(pickedFile.path)))
                  : Container(
                width: 250,
                height: 250,
                decoration:
                BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Center(
                  child: Text('Click here to pick image from Gallery'),
                ),
              ),
              onTap: () async {
                PickedFile image =
                await ImagePicker().getImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    pickedFile = image;
                  });
                }
              },
            ),
            SizedBox(height: 16),
            Container(
                height: 50,
                child: ElevatedButton(
                  child: Text('Upload file'),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: isLoading || pickedFile == null
                      ? null
                      : () async {
                    setState(() {
                      isLoading = true;
                    });
                    ParseFileBase parseFile;

                    if (kIsWeb) {
                      //Flutter Web
                      parseFile = ParseWebFile(
                          await pickedFile.readAsBytes(),
                          name: 'image.jpg'); //Name for file is required
                    } else {
                      //Flutter Mobile/Desktop
                      parseFile = ParseFile(File(pickedFile.path));
                    }
                    await parseFile.save();

                    final gallery = ParseObject('Gallery')
                      ..set('file', parseFile);
                    await gallery.save();

                    setState(() {
                      isLoading = false;
                      pickedFile = null;
                    });

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text(
                          'Save file with success on Back4app',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.blue,
                      ));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
