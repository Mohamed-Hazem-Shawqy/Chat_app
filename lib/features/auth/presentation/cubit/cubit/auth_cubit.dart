import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool visible = true;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  //
  TextEditingController userNameUp = TextEditingController();
  TextEditingController passUp = TextEditingController();
  TextEditingController emailUp = TextEditingController();

  Future<void> signUp() async {
    try {
      emit(SignUpLoading());

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailUp.text,
        password: passUp.text,
      );
      addUser();
      emit(SignUpSuccess());
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailuer(errMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailuer(
            errMessage: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(SignUpFailuer(errMessage: e.toString()));
    }
  }

  Future<void> signIn() async {
    try {
      emit(SigninLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );
      emit(SigninSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {
        emit(SigninFailuer(
            errMessage: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(SigninFailuer(errMessage: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      emit(GoogleSigninLoading());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(GoogleSigninSuccess());
    } catch (e) {
      emit(GoogleSigninFailuer(errMessage: e.toString()));
    }
  }

  CollectionReference<Map<String, dynamic>> adduser = FirebaseFirestore.instance
      .collection("user"); // to create collection name "user" (like entity)
  addUser() async {
    // to add user to firestore
    await adduser.add({
      // to add document to collection
      "name": userNameUp.text,
      "email": emailUp.text,
      "pass": passUp.text,
      

      // name,email.pass are collection field  (like attribute)
    });
  }
}
