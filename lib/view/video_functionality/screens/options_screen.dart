import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';

class OptionsScreen extends StatelessWidget {
  String? title;

  OptionsScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 110),
                  Row(
                    children: [
                      CircleAvatar(
                        child: Container(
                            width: 10.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            padding: EdgeInsets.all(1),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  AppImages.welcomescreenillimage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )),
                        radius: 16,
                      ),
                      SizedBox(width: 6),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          '${title},',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppHelper.themelight
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
                      // Icon(Icons.verified, size: 15),
                      // SizedBox(width: 6),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     'Follow',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // SizedBox(width: 6),
                  // Text('            Beautiful and fast 💙❤💛 ..'),
                  // SizedBox(height: 10),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.music_note,
                  //       size: 15,
                  //     ),
                  //     Text('Original Audio - some music track--'),
                  //   ],
                  // ),
                ],
              ),
              // Column(
              //   children: [
              //     Icon(Icons.favorite_outline),
              //     Text('601k'),
              //     SizedBox(height: 20),
              //     Icon(Icons.comment_rounded),
              //     Text('1123'),
              //     SizedBox(height: 20),
              //     Transform(
              //       transform: Matrix4.rotationZ(5.8),
              //       child: Icon(Icons.send),
              //     ),
              //     SizedBox(height: 50),
              //     Icon(Icons.more_vert),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
