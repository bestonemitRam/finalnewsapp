import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shortnews/datastore/preferences.dart';
import 'package:shortnews/localization/Language/languages.dart';
import 'package:shortnews/main.dart';
import 'package:shortnews/model/dashboard_model.dart';
import 'package:shortnews/view/SingleImageView.dart';
import 'package:shortnews/view/drower.dart';
import 'package:shortnews/view/screens/login_screen.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/app_string.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';
import 'package:shortnews/view_model/provider/ThemeProvider.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:timeago/timeago.dart' as timeago;

class DashBoardScreenActivity extends StatefulWidget {
  String? type;
  String? notification;
  DashBoardScreenActivity({super.key, this.type, this.notification});

  @override
  State<DashBoardScreenActivity> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreenActivity> {
  DarkThemeProvider foodcategoriesProvider = DarkThemeProvider();
  final _advancedDrawerController = AdvancedDrawerController();
  final MyController myController = Get.put(MyController());
  String _topModalData = "";

  GlobalKey<State<StatefulWidget>> widget1RenderKey =
      GlobalKey<State<StatefulWidget>>();

  void showSimpleSnackbar(BuildContext context, DashBoardModel item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 3.h,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      List<String> imagePaths = [];
                      final RenderBox box =
                          context.findRenderObject() as RenderBox;
                      return Future.delayed(Duration(milliseconds: 20),
                          () async {
                        RenderRepaintBoundary? boundary =
                            widget1RenderKey.currentContext!.findRenderObject()
                                as RenderRepaintBoundary?;
                        ui.Image image = await boundary!.toImage();
                        final directory =
                            (await getApplicationDocumentsDirectory()).path;
                        ByteData? byteData = await image.toByteData(
                            format: ui.ImageByteFormat.png);
                        Uint8List pngBytes = byteData!.buffer.asUint8List();
                        File imgFile = File('$directory/screenshot.png');
                        imagePaths.add(imgFile.path);
                        imgFile.writeAsBytes(pngBytes).then((value) async {
                          //FirebaseDynamicLinkService.buildDynamicLinks();

                          await Share.shareFiles(imagePaths,
                              subject: 'Share',
                              text:
                                  'https://play.google.com/store/apps/details?id=com.app.shotNews',
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
                        }).catchError((onError) {
                          print(onError);
                        });
                      });
                    },
                    child: Icon(Icons.share_outlined,
                        size: 10.w, color: AppColors.blackColor),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    onTap: () async {
                      print("dsfgdsfgdfg  ${AppStringFile.USER_ID}");
                      if (AppStringFile.USER_ID == " ") {
                        final jsonString = jsonEncode(item.toJson());
                        bookmarkList.add(jsonString);
                        await sharedPref.setStringList(
                            'bookmark', bookmarkList);
                        Fluttertoast.showToast(
                            msg: "Successfully added!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 700),
                            child: LoginScreen(),
                          ),
                        );
                      }
                    },
                    child: Icon(Icons.bookmark_add,
                        size: 10.w, color: AppColors.blackColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    myController.getData(widget.type!, widget.notification!);
    setupRemoteConfig();
    super.initState();
  }

  bool isplay = false;

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
    flutterTts.setCompletionHandler(() {
      setState(() {
        isplay = false;
      });
    });
  }

  Future<void> _stop() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
        builder: (context, darkThemeProvider, child) {
      return AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.transparent, Colors.blueGrey.withOpacity(0.2)],
              ),
            ),
          ),
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          // openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: MenuBarScreen(),
          child: RepaintBoundary(
            key: widget1RenderKey,
            child: Scaffold(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              drawer: Container(),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(right: 15, left: 15),
                child: Container(
                    height: 9.6.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: myController.list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(3.0),
                          child: InkWell(
                            onTap: () {
                              myController.fetchParticularData(
                                  myController.list[index]['type'].toString());
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Column(
                                  children: [
                                    Icon(
                                      myController.list[index]['icon'],
                                      size: 7.w,
                                      color: AppHelper.themelight
                                          ? AppColors.primarycolorYellow
                                          : AppColors.blackColor,
                                    ),
                                    Center(
                                        child: Text(
                                      textAlign: TextAlign.center,
                                      myController.list[index]['type']
                                          .toString(),
                                      style: AppHelper.themelight
                                          ? AppStyle.bodytext_white
                                              .copyWith(fontSize: 10)
                                          : AppStyle.bodytext_black
                                              .copyWith(fontSize: 10),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ),
              appBar: AppBar(
                toolbarHeight: 3.5.h,
                backgroundColor: Colors.transparent,
                actions: [
                  InkWell(
                    onTap: () async {
                      List<String> imagePaths = [];
                      final RenderBox box =
                          context.findRenderObject() as RenderBox;
                      return Future.delayed(Duration(milliseconds: 20),
                          () async {
                        RenderRepaintBoundary? boundary =
                            widget1RenderKey.currentContext!.findRenderObject()
                                as RenderRepaintBoundary?;
                        ui.Image image = await boundary!.toImage();
                        final directory =
                            (await getApplicationDocumentsDirectory()).path;
                        ByteData? byteData = await image.toByteData(
                            format: ui.ImageByteFormat.png);
                        Uint8List pngBytes = byteData!.buffer.asUint8List();
                        File imgFile = File('$directory/screenshot.png');
                        imagePaths.add(imgFile.path);
                        imgFile.writeAsBytes(pngBytes).then((value) async {
                          //FirebaseDynamicLinkService.buildDynamicLinks();

                          await Share.shareFiles(imagePaths,
                              subject: 'Share',
                              text:
                                  'https://play.google.com/store/apps/details?id=com.app.shotNews',
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
                        }).catchError((onError) {
                          print(onError);
                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.share_outlined,
                        size: 5.w,
                        color:
                            AppHelper.themelight ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
                leading: IconButton(
                    onPressed: _handleMenuButtonPressed,
                    icon: ValueListenableBuilder<AdvancedDrawerValue>(
                      valueListenable: _advancedDrawerController,
                      builder: (_, value, __) {
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 250),
                          child: Icon(
                            value.visible
                                ? Icons.clear
                                : Icons.arrow_back_ios_sharp,
                            size: 5.w,
                            color: AppHelper.themelight
                                ? Colors.white
                                : Colors.black,
                            key: ValueKey<bool>(value.visible),
                          ),
                        );
                      },
                    )),
              ),
              body: Obx(() {
                return myController.myData.value.isNotEmpty
                    ? Skeletonizer(
                        enabled: !myController.datafound.value,
                        enableSwitchAnimation: true,
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, bottom: 6),
                            child: Swiper(
                              duration: 100,
                              allowImplicitScrolling: true,
                              axisDirection: AxisDirection.up,
                              layout: SwiperLayout.STACK,

                              customLayoutOption: CustomLayoutOption(
                                  startIndex: -1, stateCount: 3)
                                ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                                ..addTranslate([
                                  Offset(-370.0, -40.0),
                                  Offset(0.0, 0.0),
                                  Offset(370.0, -40.0)
                                ]),
                              itemWidth: MediaQuery.of(context).size.width,
                              itemHeight: MediaQuery.of(context).size.height,
                              itemBuilder: (context, index) {
                                var item = myController.myData[index];
                                myController.isclick.value = false;

                                return InkWell(
                                  onTap: () {
                                    showSimpleSnackbar(context, item);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 1, right: 1, bottom: 0),
                                    child: Card(
                                      elevation: 5,
                                      color: AppHelper.themelight
                                          ? Colors.black
                                          : Colors.white,
                                      child: Stack(
                                        children: [
                                          if (myController.internet.value)
                                            item.img != ''
                                                ? InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SingleImageView(item
                                                                    .img
                                                                    .toString())),
                                                      );
                                                    },
                                                    child: Container(
                                                        width: double.infinity,
                                                        height: 28.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    12.0),
                                                          ),
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: item.img,
                                                            fit: BoxFit.fill,
                                                            placeholder: (context,
                                                                    url) =>
                                                                SkeletonLoader(
                                                              builder:
                                                                  Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 28.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                              ),
                                                            ),
                                                            // placeholder: (context,
                                                            //         url) =>
                                                            //     Center(
                                                            //         child:
                                                            //             new CircularProgressIndicator(
                                                            //   color: AppColors
                                                            //       .primarycolor,
                                                            // )
                                                            //),

                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),
                                                        )),
                                                  )
                                                : Container(
                                                    width: double.infinity,
                                                    height: 25.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                12.0),
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                      color: Colors.transparent,
                                                    ),
                                                    child: FlickVideoPlayer(
                                                        flickManager:
                                                            FlickManager(
                                                      videoPlayerController:
                                                          VideoPlayerController
                                                              .network(
                                                        item.video,
                                                      ),
                                                    )),
                                                  ),
                                          Positioned(
                                            top: myController.internet.value
                                                ? 28.h
                                                : 5.h,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                padding: EdgeInsets.only(
                                                    top: 1.h,
                                                    left: 2.w,
                                                    right: 2.w,
                                                    bottom: 1),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(item.title,
                                                        maxLines: 10,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppHelper
                                                                .themelight
                                                            ? AppStyle
                                                                .heading_white
                                                            : AppStyle
                                                                .heading_black),
                                                    SizedBox(
                                                      height: 0.5.h,
                                                    ),
                                                    Container(
                                                      //  height: 35.h,
                                                      child: Text(
                                                          item.description,
                                                          style: AppHelper
                                                                  .themelight
                                                              ? AppStyle
                                                                  .bodytext_white
                                                              : AppStyle
                                                                  .bodytext_black),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                      "Crips from ${item.from} / ${timeago.format(DateTime.parse(item.created_date.split(" ").first))} by ${item.takenby} " ??
                                                          "",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: AppHelper
                                                                  .themelight
                                                              ? Colors.white38
                                                              : Colors.black
                                                                  .withOpacity(
                                                                  0.3,
                                                                ),
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Positioned(
                                            top: myController.internet.value
                                                ? 22.h
                                                : 2.h,
                                            right: 0,
                                            // top: 25.h,
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: !isplay
                                                    ? InkWell(
                                                        onTap: () {
                                                          _speak(item.title +
                                                              item.description);
                                                          setState(() {
                                                            isplay = true;
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .play_circle_fill_outlined,
                                                          color: Colors.white,
                                                        ))
                                                    : InkWell(
                                                        onTap: () {
                                                          _stop();
                                                          setState(() {
                                                            isplay = false;
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .play_circle_outline_outlined,
                                                          color: Colors.green,
                                                        )),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                                height: 2.5.h,
                                                width: 20.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(7.0),
                                                    topRight:
                                                        Radius.circular(1.0),
                                                    bottomRight:
                                                        Radius.circular(7.0),
                                                  ),
                                                ),
                                                padding: EdgeInsets.all(1),
                                                child: Text(
                                                  // "ShorTnews",
                                                  Languages.of(context)!
                                                      .appName,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 15,
                                            bottom: 0,
                                            child: InkWell(
                                              onTap: () {
                                                _launchUrl(
                                                    Uri.parse(item.news_link));
                                              },
                                              child: item.img != ""
                                                  ? ClipPath(
                                                      clipper:
                                                          BottomRoundedClipper(
                                                              radius: 12.0),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaX: 1000.0,
                                                                sigmaY: 1000.0),
                                                        child: Container(
                                                          height: 6.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      12.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      12.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          12.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      12.0),
                                                            ),
                                                            image:
                                                                DecorationImage(
                                                              image: item.img !=
                                                                      ""
                                                                  ? NetworkImage(
                                                                      item.img)
                                                                  : NetworkImage(
                                                                      ""),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX:
                                                                        20.0,
                                                                    sigmaY:
                                                                        20.0),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 80.w,
                                                                  child: Text(
                                                                      "${item.title}",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: AppHelper.themelight
                                                                          ? AppStyle
                                                                              .bodytext_white
                                                                          : AppStyle
                                                                              .bodytext_black),
                                                                ),
                                                                Spacer(),
                                                                Image.asset(
                                                                  "assets/images/Animation.gif",
                                                                  height: 10.0,
                                                                  width: 20.0,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    12.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    12.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    12.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    12.0),
                                                          ),
                                                          color:
                                                              Colors.black26),
                                                      padding:
                                                          EdgeInsets.all(20.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 80.w,
                                                            child: Text(
                                                              "${item.title}",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: AppHelper
                                                                      .themelight
                                                                  ? AppStyle
                                                                      .bodytext_black
                                                                  : AppStyle
                                                                      .bodytext_white,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Image.asset(
                                                            "assets/images/Animation.gif",
                                                            height: 20.0,
                                                            width: 20.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              // autoplay: false,
                              itemCount: myController.myData.length,
                              scrollDirection: Axis.vertical,

                              onIndexChanged: (int index) {
                                _stop();
                                setState(() {
                                  isplay = false;
                                });

                                if (index == myController.myData.length - 1) {
                                  myController.loadmoredatas();
                                }
                              },

                              //control: const SwiperControl(),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          'Data not found',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
              }
                  // }
                  ),
            ),
          ));
    });
  }

  setupRemoteConfig() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    final remoteConfig = FirebaseRemoteConfig.instance;

    remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration.zero));
    await remoteConfig.fetch();
    await remoteConfig.activate();
    print(
        "kjdhgfkbkdfg  ${remoteConfig.getValue(AppStringFile.appUpdate).asBool()}  ${remoteConfig.getValue(AppStringFile.Version).asString()}");
    if (remoteConfig.getValue(AppStringFile.appUpdate).asBool()) {
      if (version != remoteConfig.getValue(AppStringFile.Version).asString() &&
          remoteConfig.getValue(AppStringFile.forceFully).asBool()) {
        _forceFullyupdate(remoteConfig.getString(AppStringFile.updateUrl),
            remoteConfig.getString(AppStringFile.updateMessage));
        return;
      }
      if (version != remoteConfig.getValue(AppStringFile.Version).asString()) {
        _update(remoteConfig.getString(AppStringFile.updateUrl),
            remoteConfig.getString(AppStringFile.updateMessage));
        return;
      }
    }
  }

  void _update(String url, String Message) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Update ! '),
            content: Text(Message),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                  //  Get.back();
                },
                child: const Text('May be later'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              CupertinoDialogAction(
                onPressed: () {
                  _lunchInBrowser(url);
                },
                child: const Text('Update'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  void _forceFullyupdate(
    String url,
    String Message,
  ) {
    showCupertinoDialog(
        context: context!,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: CupertinoAlertDialog(
              insetAnimationCurve: Curves.easeInOutCubic,
              insetAnimationDuration: Duration(milliseconds: 600),
              title: const Text(
                'Update required !',
              ),
              content: Text(Message),
              actions: [
                // The "Yes" button

                // The "No" button
                CupertinoDialogAction(
                  onPressed: () {
                    _lunchInBrowser(url);
                  },
                  child: const Text('Update'),
                  isDefaultAction: false,
                  isDestructiveAction: false,
                )
              ],
            ),
          );
        });
  }

  Future<void> _lunchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{"headesr_key": "headers_value"});
    } else {
      throw "url not lunched $url";
    }
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

class BottomRoundedClipper extends CustomClipper<Path> {
  final double radius;

  BottomRoundedClipper({required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Move to the top-left corner
    path.lineTo(
        0, size.height - radius); // Draw a line to the bottom-left corner
    path.quadraticBezierTo(
        0, size.height, radius, size.height); // Bottom-left corner curve
    path.lineTo(size.width - radius,
        size.height); // Draw a line to the bottom-right corner
    path.quadraticBezierTo(size.width, size.height, size.width,
        size.height - radius); // Bottom-right corner curve
    path.lineTo(size.width, 0); // Draw a line to the top-right corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
