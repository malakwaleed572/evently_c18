import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/common/models/custom_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vexana/vexana.dart';

class AuthService {
  static Future<String?> login(String emailAddress, String password) async {
    try {
      UserCredential credintials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      //throw"x";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email ";
      } else if (e.code == 'wrong password') {
        return "Wrong password provided for that user.";
      } else if (e.code == "invalid-icredintial") {
        return "wrong email and password";
      }
      print("CODE->${e.code}");
      return "${e.code.replaceAll("-", " ")}";
    } catch (e) {
      print("ERROR:->$e");
      return "something went wrong!!";
    }
  }

  static Future<String?> register(CustomUserModel user, String password) async {
    try {
      UserCredential credintials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );
      String? errorMessage = await createUser(user);
      if (errorMessage != null) {
        throw errorMessage;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak password') {
        return "the password provided is too weak ";
      } else if (e.code == 'email-already-in-use') {
        return "the account already exists for that email.";
      }
      print("CODE:->${e.code}");
      return "${e.code}";
    } catch (e) {
      print("ERROR:-$e");
      return "$e";
    }
  }

  static Future<CustomUserModel?> getUser() async {
    CollectionReference<CustomUserModel> collection = _getUserCollection();
    DocumentReference<CustomUserModel> doc = collection.doc(
      FirebaseAuth.instance.currentUser?.uid,
    );
    DocumentSnapshot<CustomUserModel> docSnapshot = await doc.get();
    print("done${docSnapshot.data()}");
    return docSnapshot.data();
  }

  static Future createUser(CustomUserModel user) async {
    //CollectionReference users = FirebaseFirestore.instance.collection("users");

    CollectionReference<CustomUserModel> collection = _getUserCollection();
    DocumentReference doc = collection.doc(user.uid);
    await doc.set(user);
  }

  static CollectionReference<CustomUserModel> _getUserCollection() {
    CollectionReference<CustomUserModel> collection = FirebaseFirestore.instance
        .collection("users")
        .withConverter<CustomUserModel>(
          fromFirestore: (snapshot, options) =>
              CustomUserModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        );
    return collection;
  }

  forgotPassword() {}
}
