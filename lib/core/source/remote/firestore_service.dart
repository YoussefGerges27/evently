import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16/models/Event.dart';
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

  static CollectionReference<Event> getEventCollection() {
    var collection =
        FirebaseFirestore.instance.collection("Event").withConverter(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return Event.fromFirestore(data);
      },
      toFirestore: (event, options) {
        return event.toFirestore();
      },
    );
    return collection;
  }

  static Future<void> createEvent(Event event) {
    var collection = getEventCollection();
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Future<List<Event>> getAllEvents() async {
    var collection = getEventCollection();
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList.map((document) => document.data()).toList();
    return eventList;
  }

  static Future<List<Event>> getTypeEvents(String type) async {
    var collection = getEventCollection().where("type", isEqualTo: type);
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList.map((document) => document.data()).toList();
    return eventList;
  }
}
