import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTestHelper {
  final String path;
  final FirebaseFirestore database;

  FirebaseTestHelper(this.database, this.path);

  Future<T> get<T>(
      String id,
      T Function(DocumentSnapshot<Object?>, Map<String, dynamic>)
          converter) async {
    final snapshot = await database.collection(path).doc(id).get();
    final data = snapshot.data() as Map<String, dynamic>;
    return converter(snapshot, data);
  }

  Future<List<T>> getAll<T>(
      T Function(DocumentSnapshot<Object?>, Map<String, dynamic>)
          converter) async {
    final query = await database.collection(path).get();
    final result = query.docs.map((DocumentSnapshot snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      return converter(snapshot, data);
    }).toList();

    return result;
  }

  Future<int> count() async {
    final query = await database.collection(path).count().get();
    return query.count;
  }
}
