import 'dart:io';

import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/localization/Language/languages.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view/uitl/my_progress_bar.dart';
import 'package:shortnews/view_model/controller/dashboard_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RetailerController controller = Get.put(RetailerController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
            Languages.of(context)!.addNews,
            style: AppHelper.themelight
                ? AppStyle.heading_white
                : AppStyle.heading_black,
          ),
        ),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 2.h, left: 5.w, right: 5.w, bottom: 10.h),
                  child: Obx(() => Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        Icon(
                                          Icons.list,
                                          size: 16.sp,
                                          color: Colors.yellow,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select Language',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.yellow,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: controller.language
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: controller.selectedValue.value,
                                    onChanged: (value) {
                                      setState(() {
                                        controller.selectedValue.value = value!;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      // width: size.width * 0.30,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: AppHelper.themelight
                                              ? Colors.white
                                              : Colors.black26,
                                        ),
                                        color: AppColors.secondprimarycolor,
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.yellow,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: AppColors.secondprimarycolor,
                                      ),
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        Icon(
                                          Icons.list,
                                          size: 16.sp,
                                          color: Colors.yellow,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select ',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.yellow,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: controller.slectNewsType
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: controller.selectedtype.value,
                                    onChanged: (value) {
                                      setState(() {
                                        controller.selectedtype.value = value!;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      //width: size.width * 0.30,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: AppHelper.themelight
                                              ? Colors.white
                                              : Colors.black26,
                                        ),
                                        color: AppColors.secondprimarycolor,
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.yellow,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: AppColors.secondprimarycolor,
                                      ),
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "    Title",
                                  style: TextStyle(
                                      color: AppHelper.themelight
                                          ? Colors.white
                                          : AppHelper.themelight
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 14.sp),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    // width: size.width * 0.80,
                                    // width: 20,

                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(28)),
                                        border: Border.all(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : AppHelper.themelight
                                                    ? Colors.white
                                                    : Colors.black)),
                                    child: TextFormField(
                                      controller: controller.titleController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Enter news title ',
                                          hintStyle: TextStyle(
                                              color: AppHelper.themelight
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 14.sp)),
                                      style: TextStyle(
                                          color: AppHelper.themelight
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 14.sp),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Enter Title ";
                                        }
                                        return null;
                                      },
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "     News Description",
                                  style: TextStyle(
                                      color: AppHelper.themelight
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14.sp),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    //width: size.width * 0.80,
                                    // width: 20,
                                    height: 15.h,
                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(28)),
                                        border: Border.all(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black)),
                                    child: TextFormField(
                                      controller: controller.newsDescription,
                                      maxLines: 50,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Enter News description',
                                          hintStyle: TextStyle(
                                              color: AppHelper.themelight
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 14.sp)),
                                      style: TextStyle(
                                          color: AppHelper.themelight
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 14.sp),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Enter news description ";
                                        }
                                        return null;
                                      },
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "     Taken from",
                                  style: TextStyle(
                                      color: AppHelper.themelight
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14.sp),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    //   width: size.width * 0.80,
                                    // width: 20,

                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(28)),
                                        border: Border.all(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black)),
                                    child: TextFormField(
                                      controller:
                                          controller.referenceController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Enter website name ',
                                          hintStyle: TextStyle(
                                              color: AppHelper.themelight
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 14.sp)),
                                      style: TextStyle(
                                          color: AppHelper.themelight
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 14.sp),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Enter platform name ";
                                        }
                                        return null;
                                      },
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "     News URL",
                                  style: TextStyle(
                                      color: AppHelper.themelight
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                    //  width: size.width * 0.80,
                                    // width: 20,

                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(28)),
                                        border: Border.all(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black)),
                                    child: TextFormField(
                                      controller:
                                          controller.referenceURLController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Enter news url ',
                                          hintStyle: TextStyle(
                                              color: AppHelper.themelight
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 14.sp)),
                                      style: TextStyle(
                                          color: AppHelper.themelight
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 14.sp),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Enter reference url ";
                                        }
                                        return null;
                                      },
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  width: size.width,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          Icon(
                                            Icons.list,
                                            size: 16.sp,
                                            color: Colors.yellow,
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Select video or Image',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.yellow,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.type
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value:
                                          controller.selectvideoOrImage.value,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.selectvideoOrImage.value =
                                              value!;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        // width: size.width * 0.30,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black26,
                                          ),
                                          color: AppColors.secondprimarycolor,
                                        ),
                                        elevation: 2,
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.yellow,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: AppColors.secondprimarycolor,
                                        ),
                                        offset: const Offset(-20, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all(6),
                                          thumbVisibility:
                                              MaterialStateProperty.all(true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              children: [
                                if (controller.selectvideoOrImage.value
                                        .toString() ==
                                    "Image")
                                  ElevatedButton(
                                    onPressed: () => controller.pickImage(),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppHelper.themelight
                                                    ? Colors.white
                                                    : Colors.black)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(size.height * 0.02),
                                      child: Text(
                                        'Browse Image ',
                                        style: TextStyle(
                                            color: AppHelper.themelight
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                    ),
                                  ),
                                if (controller.selectvideoOrImage.value
                                        .toString() ==
                                    "Video")
                                  ElevatedButton(
                                    onPressed: () => controller.selectvideo(),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppHelper.themelight
                                                    ? Colors.white
                                                    : Colors.black)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(size.height * 0.02),
                                      child: Text('Browse video',
                                          style: TextStyle(
                                              color: AppHelper.themelight
                                                  ? Colors.black
                                                  : Colors.white)),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            controller.imageFile.value != null
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: size.height * 0.15,
                                    child: Image(
                                      image: FileImage(
                                        File(
                                          controller.imageFile.value!,
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    ))
                                : SizedBox(),
                            if (controller.fileName.value != '')
                              Container(child: Text(controller.fileName.value)),
                            SizedBox(
                              height: 20,
                            ),
                            if (controller.createNews.value) myProgressBar(),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.primarycolor)),
                                onPressed: () async {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    if (controller.selectedValue.value.trim() ==
                                        "Select Language") {
                                      Fluttertoast.showToast(
                                          msg: "Please select language!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    } else if (controller.selectedtype.value
                                            .trim() ==
                                        "Select Type") {
                                      Fluttertoast.showToast(
                                          msg: "Please select news type!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    } else if (controller
                                            .selectvideoOrImage.value
                                            .trim()
                                            .toString() ==
                                        "Select video or Image") {
                                      Fluttertoast.showToast(
                                          msg: "Please select image or video !",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    } else {
                                      controller.addData(context);
                                    }
                                  }
                                },
                                child: SizedBox(
                                    height: 50,
                                    width: size.width * 0.80,
                                    child: Center(
                                        child: Text(
                                      'Add',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    )))),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ))),
            ),
          )),
    );
  }
}
