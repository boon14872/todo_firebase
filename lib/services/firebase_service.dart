import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateData(
    String collection,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collection).doc(id).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteData(String collection, String id) async {
    try {
      await _firestore.collection(collection).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> getData<T>(
    String collection, {
    required T Function(DocumentSnapshot doc) fromJson,
    String? uid,
  }) async {
    final List<T> data = <T>[];
    if (uid != null) {
      await _firestore
          .collection(collection)
          .where('uid', isEqualTo: uid)
          .get()
          .then((snapshot) {
            for (final doc in snapshot.docs) {
              data.add(fromJson(doc));
            }
          });
      return data;
    }
    await _firestore.collection(collection).get().then((snapshot) {
      for (final doc in snapshot.docs) {
        data.add(fromJson(doc));
      }
    });
    return data;
  }
}
