import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16/models/my_user_model.dart';

class FirestoreService {
  static CollectionReference<MyUser> getUsersCollection() {
    var collection =
        FirebaseFirestore.instance.collection('Users').withConverter(
              fromFirestore: (snapshot, options) {
                return MyUser.fromFirestore(snapshot.data());
              },
              toFirestore: (user, options) => user.toFirestore(),
            );
    return collection;
  }

  static addUser(MyUser user) {
    var collection = getUsersCollection();
    var doc = collection.doc(user.id);
    return doc.set(user);
  }

  static Future<MyUser?> getUser(String userId) async {
    var collection = getUsersCollection();
    var doc = collection.doc(userId);
    var snapshot = await doc.get();
    return snapshot.data();
  }
}
