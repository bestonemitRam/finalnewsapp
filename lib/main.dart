import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortnews/DefaultFirebaseOptions.dart';
import 'package:shortnews/datastore/preferences.dart';
import 'package:shortnews/localization/locale_constants.dart';
import 'package:shortnews/localization/localizations_delegate.dart';
import 'package:shortnews/view/dashboard_screeen.dart';

import 'package:shortnews/view/page_routes/route_generate.dart';
import 'package:shortnews/view/page_routes/routes.dart';
import 'package:shortnews/view/uitl/app_string.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/navigationservice.dart';
import 'package:shortnews/view/uitl/service/FirebaseNotification.dart';
import 'package:shortnews/view/uitl/service/notification_controller.dart';

import 'package:shortnews/view/uitl/theme/dark_theme.dart';
import 'package:shortnews/view/uitl/theme/light_theme.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';
import 'package:shortnews/view_model/provider/ThemeProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:translator/translator.dart';
import 'package:permission_handler/permission_handler.dart';

late SharedPreferences sharedPref;
List<String> bookmarkList = sharedPref?.getStringList('bookmark') ?? [];
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
}

final FlutterTts flutterTts = FlutterTts();

void _initializeTts() {
  flutterTts.setLanguage("hi-IN");
  flutterTts.setPitch(1.0);
  flutterTts.setSpeechRate(0.5);
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  _initializeTts();
  sharedPref = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    name: 'shortnews',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _firebaseMessaging.subscribeToTopic('shotnews');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  var status = await Permission.ignoreBatteryOptimizations.status;
  if (!status.isGranted) {
    var status = await Permission.ignoreBatteryOptimizations.request();
    if (status.isGranted) {
      debugPrint("Good, all your permission are granted, do some stuff");
    } else {
      debugPrint("Do stuff according to this permission was rejected");
    }
  }

  var fcm = await FirebaseMessaging.instance.getToken();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });

  allFunctions();
}

Future<void> allFunctions() async {
  sharedPref = await SharedPreferences.getInstance();

  AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'shotNews',
            channelKey: 'shotNews',
            channelName: 'shotNews notifications',
            channelDescription: 'shotNews Alert',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'shotNews', channelGroupName: 'shotNews group')
      ],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  FirebaseMessaging.onMessage.listen((event) {
    try {
      InAppNotification.show(
        child: Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            leading: Container(
                height: double.infinity, child: Icon(Icons.notifications)),
            iconColor: HexColor("#011754"),
            textColor: HexColor("#011754"),
            minVerticalPadding: 10,
            minLeadingWidth: 0,
            tileColor: Colors.white,
            title: Text(
              event.notification!.title!,
            ),
            subtitle: Text(
              event.notification!.body!,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        context: NavigationService.navigatorKey.currentState!.context,
      );
    } catch (e) {
      print(e);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _bundleId = 'Loading...';

  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      _locale = locale;
    });

    Preferences preferences = Preferences();
    AppStringFile.USER_ID = await preferences.getUserId();

    super.didChangeDependencies();
  }

  Future<void> _getPackageInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _bundleId = packageInfo.packageName;
        print("kfghkljfgh  ${_bundleId}");
      });
    } catch (e) {
      print('Error getting package info: $e');
    }
  }

  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return StreamProvider<InternetConnectionStatus>(
        initialData: InternetConnectionStatus.connected,
        create: (_) {
          return InternetConnectionChecker().onStatusChange;
        },
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<DarkThemeProvider>(
                create: (_) => DarkThemeProvider()),
          ],
          child: Consumer<DarkThemeProvider>(builder: (context, value, child) {
            return MaterialApp(
                navigatorKey: navigatorKey,
                builder: (context, child) {
                  AppHelper.themelight = !value.darkTheme;
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
                title: 'ShoTnews',
                debugShowCheckedModeBanner: false,
                locale: _locale,
                initialRoute: Routes.splashScreen,
                onGenerateRoute: RouteGenerator.generateRoute,
                theme: value.darkTheme ? lighttheme : darktheme,
                supportedLocales: [
                  Locale('en', ''), // english
                  Locale('hi', ''), //
                ],
                localizationsDelegates: [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode &&
                        supportedLocale.countryCode == locale?.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                });
          }),
        ),
      );
    });
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
