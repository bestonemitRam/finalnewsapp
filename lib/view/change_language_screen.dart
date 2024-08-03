import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortnews/localization/Language/languages.dart';
import 'package:shortnews/localization/locale_constants.dart';
import 'package:shortnews/model/language_model.dart';
import 'package:shortnews/view/page_routes/routes.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appstyle.dart';

import '../view_model/dashboard_contoller.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  List<bool> checklanguage = [true, false];
  final MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
   
    if (AppHelper.language.toString() == "hi") {
      checklanguage = [false, true];
    } else {
      checklanguage = [true, false];
    }
    return SingleChildScrollView(
      child: Container(
        height: 30.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 1.h,
            ),
            RichText(
              text: TextSpan(
                text: Languages.of(context)!.labelSelectLanguage,
                children: <TextSpan>[
                  TextSpan(
                    text: Languages.of(context)!.labelChangeLanguage,
                  ),
                ],
              ),
            ),
            ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      for (int i = 0;
                          i < LanguageModel.languageList().length;
                          i++)
                        InkWell(
                          onTap: () async {
                            for (int j = 0; j < checklanguage.length; j++) {
                              setState(() {
                                checklanguage[j] = false;
                              });
                            }

                            changeLanguage(context,
                                LanguageModel.languageList()[i].languageCode);

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String languageCode =
                                prefs.getString(prefSelectedLanguageCode) ??
                                    "en";
                            setState(() {
                              AppHelper.language =
                                  LanguageModel.languageList()[i].languageCode;
                            });

                            await prefs.setString(prefSelectedLanguageCode,
                                LanguageModel.languageList()[i].languageCode);
                            if (languageCode ==
                                LanguageModel.languageList()[i].languageCode) {
                              setState(() {
                                checklanguage[i] = true;
                              });
                            }

                            myController.fetchData();
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Container(
                              width: 80.w,
                              height: 9.h,
                              decoration: BoxDecoration(
                                  color: AppColors.backgroundColorgrey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.h)),
                                  // border: Border.all(
                                  //     color: AppColors.blackColor,
                                  //     width: 1),

                                  border: checklanguage[i]
                                      ? Border.all(
                                          color: AppColors.blackColor, width: 1)
                                      : Border.all(
                                          color: AppColors.primarycolor,
                                          width: 1)),
                              child: Padding(
                                padding: EdgeInsets.all(1.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LanguageModel.languageList()[i].flag,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              LanguageModel.languageList()[i]
                                                  .name,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        if (checklanguage[i])
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primarycolor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2.h)),
                                              border: Border.all(
                                                  color: AppColors.primarycolor,
                                                  width: 1),
                                            ),
                                            child: Icon(
                                              Icons.done,
                                              color: Colors.black,
                                            ),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  _createLanguageDropDown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.h),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 2.h, right: 2.h),
        child: DropdownButton<LanguageModel>(
          iconSize: 30,
          underline: SizedBox(),
          hint: Text(Languages.of(context)!.labelSelectLanguage),
          onChanged: (LanguageModel? language) {
            changeLanguage(context, language!.languageCode);
          },
          items: LanguageModel.languageList()
              .map<DropdownMenuItem<LanguageModel>>(
                (e) => DropdownMenuItem<LanguageModel>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(e.name)
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
