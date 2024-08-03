import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/auth/authentication.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view/uitl/my_progress_bar.dart';

class LoginByConatact extends StatefulWidget {
  final String mobileNumber;
  const LoginByConatact({super.key, required this.mobileNumber});

  @override
  State<LoginByConatact> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginByConatact> {
  final AuthController controller = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.mobileController.text = widget.mobileNumber;
  }

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
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 700),
                  child: DashBoardScreenActivity(type: '',notification: '',),
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
              padding: EdgeInsets.only(left: 5.h, right: 5.h, top: 5.h),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign up here! ",
                      style: AppHelper.themelight
                          ? AppStyle.bodytext_white
                          : AppStyle.bodytext_black,
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.welcomescreenillimage,
                            fit: BoxFit.cover,
                            width: 33.w,
                            height: 16.h,
                          ),
                          SizedBox(height: 0.h),
                          TextFormField(
                            controller: controller.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Name';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'Enter Name'),
                          ),
                          TextFormField(
                            controller: controller.mobileController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Enter Mobile number'),
                          ),
                          TextFormField(
                            controller: controller.addressController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Address'),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                            },
                            controller: controller.cityController,
                            decoration: InputDecoration(labelText: 'City'),
                          ),
                          TextFormField(
                            controller: controller.stateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'State'),
                          ),
                          SizedBox(height: 4.h),
                          controller.isLoading.value
                              ? myProgressBar()
                              : ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.primarycolor)),
                                  onPressed: () {
                                    if (controller.formKey.currentState!
                                        .validate()) 
                                        {
                                      controller.isLoading.value = true;
                                      controller.saveUserDetails(context);
                                    }
                                  },
                                  child: SizedBox(
                                      height: 50,
                                      width: size.width * 0.68,
                                      child: const Center(
                                          child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )))),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
