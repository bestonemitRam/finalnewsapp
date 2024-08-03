import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/auth/sign_up.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/screens/otp_screen.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view/uitl/my_progress_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  bool _validate = false;
  String message = 'Please Enter your phone number';

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
          //  backgroundColor: Colors.transparent,
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
                  child:  DashBoardScreenActivity(
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
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5.h),
                      Image.asset(
                        AppImages.welcomescreenillimage,
                        fit: BoxFit.cover,
                        width: 33.w,
                        height: 16.h,
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 7.h,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          maxLength: 10,

                          controller: phoneController,
                          style: AppHelper.themelight
                              ? AppStyle.bodytext_white
                              : AppStyle.bodytext_black,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            counterText: '',
                            prefixIcon: Icon(Icons.phone, color: Colors.black),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            hintText: "Enter phone number ",
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

                          // decoration: InputDecoration(
                          //   border: InputBorder.none,
                          //   counterText: '',
                          //   fillColor: Colors.transparent,
                          //   filled: true,
                          //   hintText: "Enter phone number ",
                          //   errorText: _validate ? message : null,
                          // ),
                        ),
                      ),
                      SizedBox(height: 20),
                      isloading
                          ? myProgressBar()
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.primarycolor)),
                              onPressed: () async {
                                if (!phoneController.text.isEmpty) {
                                  setState(() {
                                    isloading = true;
                                  });

                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: "+91 " + phoneController.text,
                                    verificationCompleted:
                                        (phoneAuthCredential) {},
                                    verificationFailed: (error) {
                                      setState(() {
                                        isloading = false;
                                        _validate = true;
                                        message = "Please Enter Valid Number";
                                      });
                                      log(error.toString());
                                    },
                                    codeSent:
                                        (verificationId, forceResendingToken) {
                                      setState(() {
                                        isloading = false;
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OTPScreen(
                                                  verificationId:
                                                      verificationId,
                                                  mobileNo:
                                                      phoneController.text)));
                                    },
                                    codeAutoRetrievalTimeout: (verificationId) {
                                      log("Auto Retireval timeout");
                                    },
                                  );
                                } else {
                                  setState(() {
                                    _validate = phoneController.text.isEmpty;
                                  });
                                }
                              },
                              child: SizedBox(
                                height: 50,
                                width: size.width * 0.68,
                                child: Center(
                                  child: Text(
                                    "CONTINUE",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ))
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
