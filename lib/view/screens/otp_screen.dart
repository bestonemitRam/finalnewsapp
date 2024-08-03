import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shortnews/view/auth/sign_up.dart';
import 'package:shortnews/view/createpost/addnewpost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/screens/otp_screen.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view/uitl/my_progress_bar.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {super.key, required this.verificationId, required this.mobileNo});
  final String verificationId;
  final String mobileNo;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  //final otpController = TextEditingController();

  bool isLoading = false;
  String _finalotp = '';

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
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: AppHelper.themelight ? Colors.white : Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
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
                SizedBox(height: 4.h),
                Text(
                  "Verify",
                  style: AppHelper.themelight
                      ? AppStyle.heading_white
                      : AppStyle.heading_black,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Please enter 6-digit code sent to you at\n +91 ${widget.mobileNo}",
                  style: AppHelper.themelight
                      ? AppStyle.bodytext_white
                      : AppStyle.bodytext_black,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 3.h),
                      Image.asset(
                        AppImages.welcomescreenillimage,
                        fit: BoxFit.cover,
                        width: 33.w,
                        height: 16.h,
                      ),
                      SizedBox(height: 2.h),
                      // Container(
                      //   width: size.width * 0.60,
                      //   height: 55,
                      //   padding: const EdgeInsets.only(left: 20),
                      //   decoration: BoxDecoration(
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(28)),
                      //       border: Border.all(
                      //           color: AppHelper.themelight
                      //               ? Colors.white
                      //               : Colors.black)),
                      //   child: TextField(
                      //     keyboardType: TextInputType.phone,
                      //     maxLength: 10,
                      //     controller: otpController,
                      //     style: AppHelper.themelight
                      //         ? AppStyle.bodytext_white
                      //         : AppStyle.bodytext_black,
                      //     decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       counterText: '',
                      //       fillColor: Colors.transparent,
                      //       filled: true,
                      //       hintText: "Enter OTP",
                      //     ),
                      //   ),
                      // ),

                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        cursorColor: AppColors.blackColor,
                        //animationType: AnimationType.fade,

                        pastedTextStyle: TextStyle(
                          color: AppColors.primarycolor,
                          fontWeight: FontWeight.bold,
                        ),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          disabledColor: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(1.h),
                          fieldHeight: 100.w / 8,
                          fieldWidth: 100.w / 8,
                          activeFillColor: AppColors.primarycolor,
                          // Theme.of(context).colorScheme.primary,12

                          inactiveColor: AppColors.secondprimarycolor,
                          inactiveFillColor: AppColors.whiteColor,
                          selectedFillColor: AppColors.whiteColor,
                          selectedColor: AppColors.primarycolor,
                          activeColor:
                              Theme.of(context).appBarTheme.backgroundColor,
                        ),

                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onCompleted: (v) {
                          _finalotp = v;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),

                      SizedBox(height: 20),
                      isLoading
                          ? myProgressBar()
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.primarycolor)),
                              onPressed: () async {
                                if (_finalotp != '') {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    final cred = PhoneAuthProvider.credential(
                                        verificationId: widget.verificationId,
                                        smsCode: _finalotp);
                                    print("djkffjkfghgfdg  ${cred}   ");

                                    var iin = await FirebaseAuth.instance
                                        .signInWithCredential(cred);
                                    Navigator.pop(context);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginByConatact(
                                              mobileNumber: widget.mobileNo),
                                        ));
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please Etter otp ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: AppColors.primarycolor,
                                      fontSize: 16.0);
                                }
                              },
                              child: SizedBox(
                                height: 50,
                                width: size.width * 0.68,
                                child: Center(
                                  child: Text(
                                    "Verify",
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

    // Scaffold(
    //     body: Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 30),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       const Text(
    //         "We have sent an OTP to your phone. Plz verify",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontSize: 18),
    //       ),
    //       const SizedBox(height: 40),
    //       TextField(
    //         controller: otpController,
    //         keyboardType: TextInputType.phone,
    //         decoration: InputDecoration(
    //             fillColor: Colors.grey.withOpacity(0.25),
    //             filled: true,
    //             hintText: "Enter OTP",
    //             border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(30),
    //                 borderSide: BorderSide.none)),
    //       ),
    //       const SizedBox(height: 20),
    //       isLoading
    //           ? const CircularProgressIndicator()
    //           : ElevatedButton(
    //               onPressed: () async {
    //                 setState(() {
    //                   isLoading = true;
    //                 });

    //                 try {
    //                   final cred = PhoneAuthProvider.credential(
    //                       verificationId: widget.verificationId,
    //                       smsCode: otpController.text);

    //                   await FirebaseAuth.instance.signInWithCredential(cred);

    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => HomeScreen(),
    //                       ));
    //                 } catch (e) {
    //                   log(e.toString());
    //                 }
    //                 setState(() {
    //                   isLoading = false;
    //                 });
    //               },
    //               child: const Text(
    //                 "Verify",
    //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    //               ))
    //     ],
    //   ),
    // ));
  }
}
