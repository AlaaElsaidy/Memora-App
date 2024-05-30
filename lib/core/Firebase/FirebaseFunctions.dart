import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:memora/features/Details/data/models/userDetailsModel.dart';
import 'package:memora/features/signUp/data/models/userModel.dart';

import '../../features/trackingtab/data/model/trackingModel.dart';
@injectable
class FirebaseFunctions{
  Future<UserCredential> signup(String email,String password)async{
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  Future<UserCredential>login(String email,String password)async{
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  }

  Future<void> addUser(UserModel userModel) async {
    var collection=FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
    var docRf = collection.doc();
    userModel.id = docRf.id;
    docRf.set(userModel);
  }
  Future<void> addDetails(UserDetailsModel userDetailsModel) async {
    var collection=FirebaseFirestore.instance
        .collection(UserDetailsModel.collecionName)
        .withConverter<UserDetailsModel>(
      fromFirestore: (snapshot, _) {
        return UserDetailsModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
    var docRf = collection.doc();
    userDetailsModel.id = docRf.id;
    docRf.set(userDetailsModel);
  }

}
Future<void> saveLocation(TrackingModel trackingModel) async {
  var collection=FirebaseFirestore.instance
      .collection(TrackingModel.collecionName)
      .withConverter<TrackingModel>(
    fromFirestore: (snapshot, _) {
      return TrackingModel.fromJson(snapshot.data()!);
    },
    toFirestore: (value, _) {
      return value.toJson();
    },
  );
  var docRf = collection.doc();
  trackingModel.id = docRf.id;
  docRf.set(trackingModel);
}



