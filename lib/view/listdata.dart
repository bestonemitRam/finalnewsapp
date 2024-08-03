import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shortnews/model/dashboard_model.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('shortnews').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data Found'));
          }

          // Map the snapshot data to your model
          final newsList = snapshot.data!.docs
              .map((doc) =>
                  DashBoardModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
              .toList();

          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return ListTile(
                title: Text(news.title),
                subtitle: Text(news.description),
                leading: news.img.isNotEmpty
                    ? Image.network(news.img,width: 50, height: 50,
                     fit: BoxFit.cover)
                    : null,
                onTap: () 
                {
                  // Handle tap, e.g., navigate to a detail page
                },
              );
            },
          );
        },
      ),
    );
  }
}
