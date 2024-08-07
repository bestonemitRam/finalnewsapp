import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortnews/datastore/preferences.dart';
import 'package:shortnews/main.dart';
import 'package:shortnews/model/dashboard_model.dart';
import 'package:shortnews/model/video_model.dart';
import 'package:shortnews/view/uitl/app_string.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/service/FirebaseServices.dart';
import 'package:shortnews/view_model/data_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MyController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final DataService _dataService = DataService();
  var myData = <DashBoardModel>[].obs;
  var videoModel = <VideoModel>[].obs;

  var internet = false.obs;
  var light = true.obs;
  var notification = true.obs;
  var showpop = false.obs;
  List<Map<String, dynamic>> list = [
    {"icon": Icons.ac_unit_sharp, "type": "My Feed"},
    {"icon": Icons.account_balance_outlined, "type": "All News"},
    {"icon": Icons.star, "type": "Top Stories"},
    {"icon": Icons.trending_up_outlined, "type": "Trending"},
    {"icon": Icons.bookmark, "type": "Book Mark"},
    {"icon": Icons.timer_10_select_sharp, "type": "Technology"},
    {"icon": Icons.real_estate_agent_rounded, "type": "Entertainment"},
    {"icon": Icons.sports_baseball_outlined, "type": "Sports"},
  ];
  var isclick = false.obs;
  var datafound = false.obs;
  var pageload = false.obs;

  @override
  void onInit() {
    AppHelper.language = sharedPref.getString("SelectedLanguageCode");

    super.onInit();
  }

  void fetchData() async {
    myData.value = await _dataService.fetchData();
  }

  void loadmoredatas() async {
    try {
      myData.value = await _dataService.loadMoreData();
    } catch (e) {}
  }

  void fetchVideo() async {
    videoModel.value = await _dataService.loadVideo();
  }

  void loadMoreVideo() async {
    videoModel.value = await _dataService.loadMoreVideo();
  }

  void fetchParticularData(String newsType) async {
    try {
      datafound.value = false;
      if (newsType == "Book Mark") {
        List<String>? dataList = sharedPref.getStringList('bookmark');
        if (dataList != null) {
          myData.value = dataList
              .map((jsonString) =>
                  DashBoardModel.fromJson(json.decode(jsonString)))
              .toList();
        }
      } else if (newsType == "notification") {
        myData.value = await _dataService.fetchnotification();
      } else {
        myData.value = await _dataService.fetchDataType(newsType);
      }

      datafound.value = true;
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  getData(String type, String notification) async {
    bool result = await InternetConnectionChecker().hasConnection;
    internet.value = result;

    if (result == true) {
      if (type.isEmpty) {
        if (notification.isNotEmpty) {
          if (notification == 'notification') {
            myData.value = await _dataService.fetchnotification();
          } else {
            myData.value =
                await _dataService.loadPushNotificationData(notification);
          }
        } else {
          fetchData();
          loadModelsFromPrefs();
        }
      } else {
        fetchParticularData(type);
      }
    } else {
      loadModelsFromPrefs();
    }

    datafound.value = true;
  }

//-------------------------load data from local--------------------------//
  loadModelsFromPrefs() async {
    final jsonString = sharedPref.getString('dashboardModels');
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      myData.value =
          jsonList.map((json) => DashBoardModel.fromJson(json)).toList();
    }
  }

  var islogOut = false.obs;

  Future<void> logOut() async {
    islogOut.value = true;
    await FirebaseServices().googleSignOut();

    Preferences preferences = Preferences();
    preferences.clearPrefs();
    AppStringFile.USER_ID = '';

    islogOut.value = false;

    Fluttertoast.showToast(
        msg: "Logout successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
}
