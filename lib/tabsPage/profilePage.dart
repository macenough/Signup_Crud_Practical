import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login_demo/database/repository.dart';
import 'package:signup_login_demo/model/signup_model.dart';
import 'package:signup_login_demo/pages/loginPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textName = TextEditingController();
  TextEditingController textEmail = TextEditingController(text: "");
  TextEditingController textOccupation = TextEditingController(text: "");

  File? imageFile;
  final picker = ImagePicker();

  Repository _repository = new Repository();
  int id = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => showOptionsDialog(context),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 60.0,
                  child: Center(
                    child: imageFile == null
                        ? new Icon(Icons.camera)
                        : Center(
                            child: new CircleAvatar(
                              radius: 58.0,
                              backgroundImage: FileImage(imageFile!),
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    controller: textName,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Name'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: textEmail,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.always,
                  enabled: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: textOccupation,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Occupation',
                      hintText: 'Enter Occupation'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: MaterialButton(
                  height: 58,
                  minWidth: 300,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15)),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int? userId = await prefs.getInt('userId');
                    _repository.update(
                        userId!, textName.text, textOccupation.text);
                    await prefs.setString('name', textName.text);
                    await prefs.setString('occupation', textOccupation.text);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Profile Updated Successfully"),
                    ));
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
              MaterialButton(
                height: 58,
                minWidth: 300,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Choose Option")),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Card(
                      elevation: 5,
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.camera, color: Colors.white),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Camera",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      _getFromCamera();
                    },
                  ),
                  GestureDetector(
                    child: Card(
                      elevation: 5,
                      color: Colors.black,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.photo,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Gallery",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      _getFromGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> setProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = await prefs.getInt('userId');
    String? name = await prefs.getString('name');
    String? occu = await prefs.getString('occupation');
    String? email = await prefs.getString('email');

    setState(() {
      textName.text = name!;
      textEmail.text = email!;
      textOccupation.text = occu!;
    });
  }
}
