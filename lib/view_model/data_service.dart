import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shortnews/main.dart';
import 'package:shortnews/model/dashboard_model.dart';
import 'package:shortnews/model/language_model.dart';
import 'package:shortnews/model/video_model.dart';
import 'package:shortnews/view/uitl/apphelper.dart';

class DataService {
  DocumentSnapshot? _lastDocument;
  List<DashBoardModel> data = [];
  Future<List<DashBoardModel>> fetchData() async {
    data.clear();
    try {
      print("fkdghkfdhgk  ${AppHelper.language}");
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection('shortnews');
      QuerySnapshot snapshot = await myCollection
          .where("language", isEqualTo: AppHelper.language)
          .orderBy('created_date', descending: true)
          .limit(15)
          .get();
      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;

        data = snapshot.docs
            .map((doc) => DashBoardModel(
                id: doc.id,
                description: doc['description'],
                img: doc['img'],
                news_id: doc['news_id'],
                news_link: doc['news_link'],
                title: doc['title'],
                video: doc['video'],
                from: doc['from'],
                takenby: doc['takenby'],
                created_date: doc['created_date'].toDate().toString()))
            .toList();
      }

      final jsonString =
          jsonEncode(data.map((model) => model.toJson()).toList());
      await sharedPref.setString('dashboardModels', jsonString);

      return data;
    } catch (e) {
      throw e;
    }
  }

  Future<List<DashBoardModel>> loadMoreData() async {
    try {
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection('shortnews');

      QuerySnapshot snapshot = await myCollection
          .startAfterDocument(_lastDocument!)
          .where("language", isEqualTo: AppHelper.language)
          .limit(15)
          .get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;

        List<DashBoardModel> fetchedData = snapshot.docs
            .map((doc) => DashBoardModel(
                id: doc.id,
                description: doc['description'],
                img: doc['img'],
                news_id: doc['news_id'],
                news_link: doc['news_link'],
                title: doc['title'],
                video: doc['video'],
                from: doc['from'],
                takenby: doc['takenby'],
                created_date: doc['created_date'].toDate().toString()))
            .toList();
        data.addAll(fetchedData);
      }

      final jsonString =
          jsonEncode(data.map((model) => model.toJson()).toList());
      await sharedPref.setString('dashboardModels', jsonString);

      return data;
    } catch (e) {
      throw e;
    }
  }

  Future<List<DashBoardModel>> fetchDataType(String newsType) async {
    CollectionReference myCollection =
        FirebaseFirestore.instance.collection('shortnews');
    QuerySnapshot snapshot = await myCollection
        .where("newsType", isEqualTo: newsType)
        .where("language", isEqualTo: AppHelper.language)
        .orderBy('created_date', descending: true)
        .limit(15)
        .get();

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
      data = snapshot.docs
          .map((doc) => DashBoardModel(
              id: doc.id,
              description: doc['description'],
              img: doc['img'],
              news_id: doc['news_id'],
              news_link: doc['news_link'],
              title: doc['title'],
              video: doc['video'],
              from: doc['from'],
              takenby: doc['takenby'],
              created_date: doc['created_date'].toDate().toString()))
          .toList();
      return data;
    } else {
      return data;
    }
  }

  Future<List<DashBoardModel>> fetchnotification() async {
    data.clear();
    try {
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection('notification');

      QuerySnapshot snapshot = await myCollection.limit(15).get();

      if (snapshot.docs.isNotEmpty) {
        data = snapshot.docs
            .map((doc) => DashBoardModel(
                id: doc.id,
                description: doc['description'],
                img: doc['img'],
                news_id: doc['news_id'],
                news_link: doc['news_link'],
                title: doc['title'],
                video: doc['video'],
                from: doc['from'],
                takenby: doc['takenby'],
                created_date: doc['created_date'].toDate().toString()))
            .toList();
      }

      return data;
    } catch (e) {
      throw e;
    }
  }


  Future<List<DashBoardModel>> loadPushNotificationData(String doc_id) async 
  {
   
   List<DashBoardModel> data = [];
    try {
      print("Fetching data for doc_id: $doc_id");
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection('shortnews');
      QuerySnapshot snapshot =
          await myCollection.where("news_id", isEqualTo:  doc_id.toString().trim()).get();
      if (snapshot.docs.isNotEmpty)
       {
        data = snapshot.docs
            .map((doc) => DashBoardModel(
                  id: doc.id,
                  description: doc['description'],
                  img: doc['img'],
                  news_id: doc['news_id'],
                  news_link: doc['news_link'],
                  title: doc['title'],
                  video: doc['video'],
                  from: doc['from'],
                  takenby: doc['takenby'],
                  created_date: doc['created_date'].toDate().toString(),
                ))
            .toList();
         }
       else 
      {
        print("No documents found for doc_id: $doc_id");
      }

      return data;
    } catch (e) 
    {
      print("Error fetching data: $e");
      throw e;
    }
  }

  List<VideoModel> videodata = [];
  DocumentSnapshot? _lastVideo;
  Future<List<VideoModel>> loadVideo() async {
    try {
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection('short_video');

      QuerySnapshot snapshot = await myCollection.limit(10).get();

      if (snapshot.docs.isNotEmpty) {
        _lastVideo = snapshot.docs.last;

        videodata = snapshot.docs
            .map((doc) => VideoModel(
                  video_id: doc['video_id'],
                  video_url: doc['video_url'],
                  title: doc['title'],
                ))
            .toList();

        print("lfjdghkfhkgdjkfg  ${videodata.length}");
      }

      return videodata;
    } catch (e) {
      throw e;
    }
  }

  Future<List<VideoModel>> loadMoreVideo() async {
    try {
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection('short_video');

      QuerySnapshot snapshot =
          await myCollection.startAfterDocument(_lastVideo!).limit(10).get();

      if (snapshot.docs.isNotEmpty) {
        _lastVideo = snapshot.docs.last;
        videodata = snapshot.docs
            .map((doc) => VideoModel(
                  video_id: doc['video_id'],
                  video_url: doc['video_url'],
                  title: doc['title'],
                ))
            .toList();

        print("lfjdghkfhkgdjkfg  ${videodata.length}");
      }

      return videodata;
    } catch (e) {
      throw e;
    }
  }
}
