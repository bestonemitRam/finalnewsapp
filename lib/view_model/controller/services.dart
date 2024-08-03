import 'package:cloud_firestore/cloud_firestore.dart';

class DataServiceClase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch data with pagination and descending order
  Future<List<DocumentSnapshot>> fetchData({
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = _firestore
        .collection('your_collection') // Replace with your collection name
        .orderBy('timestamp',
            descending:
                true) // Replace 'timestamp' with your field name for descending order
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs;
  }
}
