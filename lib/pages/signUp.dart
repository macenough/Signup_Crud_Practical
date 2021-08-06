import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:signup_login_demo/database/repository.dart';
import 'package:signup_login_demo/model/signup_model.dart';
import 'package:signup_login_demo/pages/loginPage.dart';

import 'homePage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController textName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPhone = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  Repository _repository = new Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            autovalidate: true,
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
                      controller: textName,
                      keyboardType: TextInputType.text,
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
                      controller: textPhone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone',
                          hintText: 'Enter Phone Number'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        MinLengthValidator(10,
                            errorText:
                                "Password should be atleast 10 characters"),
                        MaxLengthValidator(10,
                            errorText:
                                "Password should not be greater than 10 characters")
                      ])
                      //validatePassword,        //Function to check validation
                      ),
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
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        _repository
                            .isAlreadyEmailCheck(textEmail.text)
                            .then((value) {
                          var isEmailAlready = value;
                          if (isEmailAlready == true) {
                            print("akskansaks");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Already Email Exist"),
                            ));
                          } else {
                            UserModel _userModel = new UserModel(
                                0,
                                textName.text,
                                textEmail.text,
                                textPhone.text,
                                textPassword.text,
                                "");
                            _repository.add(_userModel);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Registration Successfully"),
                            ));
                            Future.delayed(Duration(seconds: 2)).then((_) {
                              // this code is executed after the future ends.
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                            } );

                          }
                        });

                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));*/
                      } else {
                        print("Not Validated");
                      }
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()));*/
                    },
                    child: Text(
                      "SignUp",
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
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      Text(
                        "Login Here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
