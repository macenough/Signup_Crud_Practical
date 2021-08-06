import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login_demo/database/repository.dart';
import 'package:signup_login_demo/pages/signUp.dart';

import 'homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  Repository _repository = new Repository();

  int id = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAlredyLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formkey,
          autovalidate: true,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "https://opensenselabs.com/sites/default/files/inline-images/flutter%20logo.png",
                  height: 150,
                  width: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: textEmail,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter valid email id as abc@gmail.com'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        EmailValidator(errorText: "Enter valid email id"),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                      controller: textPassword,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        MinLengthValidator(8,
                            errorText:
                                "Password should be atleast 8 characters"),
                        MaxLengthValidator(15,
                            errorText:
                                "Password should not be greater than 15 characters")
                      ])
                      //validatePassword,        //Function to check validation
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
                      if (formkey.currentState!.validate()) {
                        var userData = _repository.getUserInfo(
                            textEmail.text, textPassword.text);

                        userData.then((value) async {
                          if (value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("User Not exits"),
                            ));
                          } else {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setInt('userId', value[0].id);
                            await prefs.setString('name', value[0].name);
                            await prefs.setString(
                                'occupation', value[0].occupation);
                            await prefs.setString('email', value[0].email);
                            await prefs.setString('phone', value[0].phone);
                            await prefs.setString(
                                'password', value[0].password);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Login Successfully"),
                            ));
                            Future.delayed(Duration(seconds: 2)).then((_) {
                              // this code is executed after the future ends.
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } );

                          }
                        });

                        /*if (isEmailAlready == true) {

                        } else {
                          print("Validated");
                        }*/
                      } else {
                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));*/
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Register Here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> checkAlredyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = 0;
    userId = await prefs.getInt('userId');
    print("userid....name" + userId.toString());
    if (userId != null) {
      print(userId);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}
