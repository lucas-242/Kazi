import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTestHelper {

  FirebaseTestHelper(this.database, this.path);
  final String path;
  final FirebaseFirestore database;

  Future<T> add<T>(
    Map<String, dynamic> data,
    T Function(DocumentReference<Map<String, dynamic>>) copyWith,
  ) async {
    final snapshot = await database.collection(path).add(data);
    final result = copyWith(snapshot);
    return result;
  }

  Future<int> count() async {
    final query = await database.collection(path).count().get();
    return query.count ?? 0;
  }

  Future<T?> get<T>(
      String id,
      T Function(DocumentSnapshot<Object?>, Map<String, dynamic>)
          converter,) async {
    final snapshot = await database.collection(path).doc(id).get();
    final data = snapshot.data();
    if (data != null) {
      return converter(snapshot, data);
    }

    return null;
  }

  Future<List<T>> getAll<T>(
      T Function(DocumentSnapshot<Object?>, Map<String, dynamic>)
          converter,) async {
    final query = await database.collection(path).get();
    final result = query.docs.map((DocumentSnapshot snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      return converter(snapshot, data);
    }).toList();

    return result;
  }
}
