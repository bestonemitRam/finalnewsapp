import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/notifications/notification_list.dart';
import 'package:shortnews/view/page_routes/routes.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationScreen extends StatefulWidget {
  final String notification;
  const NotificationScreen({super.key, required this.notification});

  @override
  State<NotificationScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NotificationScreen> {
  final MyController myController = Get.put(MyController());

  @override
  void initState() 
  {
    myController.fetchParticularData(widget.notification);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: AppHelper.themelight ? Colors.white : Colors.black,
            ),
            onTap: ()
             {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 700),
                  child: DashBoardScreenActivity(notification: '',type: '',),
                ),
              );
            },
          ),
          title: Center(
            child: Text(
              "Top Notifications",
              style: TextStyle(
                color: AppHelper.themelight ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        body: Obx(() {
         
          
            return 
            Skeletonizer(
            enabled: !myController.datafound.value,
            enableSwitchAnimation: true,
               child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: myController.myData.length,
                  itemBuilder: (ctx, index) {
                    var item = myController.myData[index];
               
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListUi(item),
                    );
                  }),
             );
          
        }
        )
        );
  
  }
}
