import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/datastore/preferences.dart';
import 'package:shortnews/model/user_data_model.dart';
import 'package:shortnews/view/auth/sign_up.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/screens/otp_screen.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/app_string.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view/uitl/my_progress_bar.dart';
import 'package:shortnews/view/uitl/service/FirebaseServices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _validate = false;
  String message = 'Please Enter your phone number';
  bool _obscureText = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  var _isLoading = false;
  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          AppImages.loginImage,
        ),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: AppHelper.themelight ? Colors.white : Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 700),
                  child: DashBoardScreenActivity(
                    type: '',
                    notification: '',
                  ),
                ),
              );
            },
          ),
          title: Center(
            child: Text(
              "",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Text(
                  "WELCOME To ShotNews App",
                  style: AppHelper.themelight
                      ? AppStyle.heading_white
                      : AppStyle.heading_black,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Login here ! ",
                  style: AppHelper.themelight
                      ? AppStyle.bodytext_white
                      : AppStyle.bodytext_black,
                ),
                Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.h),
                        Image.asset(
                          AppImages.welcomescreenillimage,
                          fit: BoxFit.cover,
                          width: 18.w,
                          height: 9.h,
                        ),
                        SizedBox(height: 2.h),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          style: AppHelper.themelight
                              ? AppStyle.bodytext_white
                              : AppStyle.bodytext_black,
                          validator: (value) {
                            if (!validateField(value!)) {
                              return "Empty Field";
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            counterText: '',
                            prefixIcon: Icon(Icons.email, color: Colors.black),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            hintText: " E-mail",
                            errorText: _validate ? message : null,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        TextFormField(
                          obscureText: _obscureText,
                          style: AppHelper.themelight
                              ? AppStyle.bodytext_white
                              : AppStyle.bodytext_black,
                          validator: (value) {
                            if (!validateField(value!)) {
                              return "Empty Field";
                            }
                            return null;
                          },
                          controller: passwordController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.black),
                            hintText: "Password",
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            suffixIcon: InkWell(
                              onTap: _toggle,
                              child: Icon(
                                _obscureText
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        isloading
                            ? myProgressBar()
                            : ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.primarycolor)),
                                onPressed: () async {
                                  setState(() {
                                    isloading = true;
                                  });
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      final credential = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );

                                      User? user = credential.user;
                                      if (user != null) {
                                        final CollectionReference users =
                                            FirebaseFirestore.instance
                                                .collection('users');

                                        final QuerySnapshot querySnapshot =
                                            await users
                                                .where('user_id',
                                                    isEqualTo: user.uid)
                                                .get();

                                        final List<QueryDocumentSnapshot>
                                            documents = querySnapshot.docs;
                                        for (var doc in documents) {
                                          Preferences preferences =
                                              Preferences();
                                          final data = doc.data()
                                              as Map<String, dynamic>;
                                          AppStringFile.USER_ID =
                                              data['user_id'];
                                          var userdata = UserData(
                                              user_id: data['user_id'],
                                              user_name: data['name'],
                                              user_email: data['email'],
                                              user_token: '');
                                          preferences.saveUser(userdata);

                                          setState(() {
                                            isloading = true;
                                          });

                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              duration:
                                                  Duration(milliseconds: 700),
                                              child: DashBoardScreenActivity(
                                                type: '',
                                                notification: '',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        isloading = false;
                                      });
                                      if (e.code == 'user-not-found') {
                                        Fluttertoast.showToast(
                                            msg:
                                                "No user found for that email.!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                      } else if (e.code == 'wrong-password') {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Wrong password provided for that user!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                      }
                                      setState(() {
                                        isloading = false;
                                      });
                                    }
                                  }
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: size.width * 0.68,
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )),
                        SizedBox(height: 2.h),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  UserCredential userCredential =
                                      await FirebaseServices()
                                          .signInWithGooglewithFirebase();
                                  if (userCredential != null) {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LoginByConatact(
                                                    email: userCredential
                                                        .user!.email!,
                                                    name: userCredential
                                                        .user!.displayName!,
                                                    type: 1),
                                          ));
                                    });
                                  }
                                },
                                child: Container(
                                  child: Image.asset(
                                    "assets/images/google.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginByConatact(
                                            email: '', name: '', type: 0),
                                      ));
                                },
                                child: Text("SignUp here!",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 10)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
