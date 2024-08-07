import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shortnews/datastore/preferences.dart';
import 'package:shortnews/model/user_data_model.dart';
import 'package:shortnews/view/createpost/addnewpost.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/uitl/app_string.dart';
import 'package:shortnews/view/uitl/custom_alertDialog.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  bool validation() {
    if (emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Phone Number');
      return false;
    }
    return true;
  }

  Future<void> saveUserDetails(BuildContext context) async {
    var fcm = await FirebaseMessaging.instance.getToken();
    // User? user = _auth.currentUser;
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user?.email != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': nameController.text,
          'address': addressController.text,
          'city': cityController.text,
          'state': stateController.text,
          'email': userCredential.user!.email,
          'password': passwordController.text,
          'user_id': userCredential.user?.uid
        });
        isLoading.value = false;

        Preferences preferences = Preferences();
        var userdata = UserData(
            user_id: userCredential.user?.uid,
            user_name: nameController.text,
            user_email: userCredential.user?.email,
            user_token: fcm);
        AppStringFile.USER_ID = userCredential.user!.uid.toString();

        preferences.saveUser(userdata);

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
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
          msg: "This E-mail already register",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  Future<void> createDetails(BuildContext context) async {
    var fcm = await FirebaseMessaging.instance.getToken();
    User? user = _auth.currentUser;
    try {
      if (user != null) {
        await _firestore.collection('users').doc(user?.uid).set({
          'name': nameController.text,
          'address': addressController.text,
          'city': cityController.text,
          'state': stateController.text,
          'email': user?.email,
          'password': passwordController.text,
          'user_id': user?.uid
        });
        isLoading.value = false;

        Preferences preferences = Preferences();
        var userdata = UserData(
            user_id: user?.uid,
            user_name: nameController.text,
            user_email: user?.email,
            user_token: fcm);
        AppStringFile.USER_ID = user!.uid.toString();

        preferences.saveUser(userdata);

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
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
          msg: "This E-mail already register",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    super.dispose();
  }
}
