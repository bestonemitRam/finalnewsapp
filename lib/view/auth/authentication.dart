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
  TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  bool validation()
                                                                                              {
    if (mobileController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Phone Number');
      return false;
    }
    return true;
  }

  Future<void> saveUserDetails(BuildContext context) async {
    var fcm = await FirebaseMessaging.instance.getToken();
    User? user = _auth.currentUser;

    if (user != null) {
      await _firestore.collection('users').doc(user?.uid).set({
        'name': nameController.text,
        'address': addressController.text,
        'city': cityController.text,
        'state': stateController.text,
        'phone': user?.phoneNumber,
        'user_id': user?.uid
      });
      isLoading.value = false;

      Preferences preferences = Preferences();
      var userdata = UserData(
          user_id: user?.uid,
          user_name: nameController.text,
          user_mobile: user?.phoneNumber,
          user_token: fcm);
      AppStringFile.USER_ID = user!.uid.toString();
   
     preferences.saveUser(userdata);
      Fluttertoast.showToast(
          msg: "Register successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      Navigator.pop(context);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 700),
          child: DashBoardScreenActivity(type: '',notification: '',),
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
