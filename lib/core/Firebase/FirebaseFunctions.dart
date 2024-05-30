import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:memora/features/Details/data/models/userDetailsModel.dart';
import 'package:memora/features/signUp/data/models/userModel.dart';
@injectable
class FirebaseFunctions {
  String userUID = "";
  FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<UserCredential> signup(String email, String password) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    userUID = credential.user!.uid;
    return credential;
  }

  Future<UserCredential> login(String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email,
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
    userModel.id = userUID;
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
    userDetailsModel.id = userUID;
    docRf.set(userDetailsModel);
  }

  Future<void> getData(collectionName) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(collectionName);
    users.doc(userUID).get();
  }
}