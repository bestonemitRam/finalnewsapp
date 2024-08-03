import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/model/dashboard_model.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appstyle.dart';

class ListUi extends StatelessWidget {
  DashBoardModel item;
  ListUi(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 700),
            child: DashBoardScreenActivity(
              notification: 'notification',
              type: '',
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Container(
          color: AppHelper.themelight ? Colors.white : Colors.black,
          // color: Colors.white12,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20.w,
                height: 11.h,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: item.img.toString(),
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: new CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        item.title.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_black
                            : AppStyle.bodytext_white,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        item.description.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: AppHelper.themelight
                            ? AppStyle.bodytext_black.copyWith(fontSize: 12)
                            : AppStyle.bodytext_white.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
