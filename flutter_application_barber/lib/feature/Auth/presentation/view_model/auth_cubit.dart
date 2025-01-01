import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_barber/feature/Auth/Data/onwer_model.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view_model/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());

  //////*********************login****///////////////////////////////

  Login(String email, String password) async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(LoginSuccessState(role: credential.user!.photoURL!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(error: 'الحساب غير موجود'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(error: 'الباسورد ضعيف'));
      } else {
        emit(LoginErrorState(error: 'حدث خطأ ما'));
      }
    } catch (e) {
      emit(LoginErrorState(error: 'حدثت مشكله في التسجيل'));
    }
  }

//////create client user in firebase and check the password /////////////////////////////////////
  RegisterClient(String name, String email, String password) async {
    emit(signupLoadingStates());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      await user?.updateDisplayName(name);
      await user?.updatePhotoURL('1');
      FirebaseFirestore.instance.collection('client').doc(user?.uid).set({
        'name': name,
        'email': email,
        'iamge': '',
        'bio': '',
        'city': '',
        'phone': '',
        'age': '',
      }, SetOptions(merge: true));
      emit(signupSuccessStates());
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        emit(signupErorrStates(Erorr: 'كلمه المرور ضعيقه'));
      } else if (e.code == 'email-already-in-use') {
        emit(signupErorrStates(Erorr: 'الحساب موجود بالفعل'));
      } else {
        emit(signupErorrStates(Erorr: 'حدثت مشكله في التسجيل'));
        print(e);
      }
    }
  }
//////create onwer user in firebase and check the password /////////////////////////////////////

  RegisterOnwer(String name, String email, String password) async {
    emit(signupLoadingStates());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;
      user.updateDisplayName(name);
      await user.updatePhotoURL('0');
      //stor in firebase//
      FirebaseFirestore.instance.collection('Owner').doc(user.uid).set({
        'name': name,
        'image': null,
        'rating': null,
        'email': user.email,
        'phone1': null,
        'phone2': null,
        'bio': null,
        'openHour': null,
        'closeHour': null,
        'address': null,
      }, SetOptions(merge: true));

      emit(signupSuccessStates());
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        emit(signupErorrStates(Erorr: 'كلمة السر ضعيفه'));
      } else if (e.code == 'email-already-in-use') {
        emit(signupErorrStates(Erorr: 'الحساب موجود بالفعل'));
      }
    } catch (e) {
      emit(signupErorrStates(Erorr: 'حدثت مشكله فالتسجيل حاول لاحقا'));
    }
  }

  ////////////// this is to complete onwer his info//////////////////////////////////
  UploadOnwerData(OnwerModel onwer) {
    emit(UploaddataLoadingStates());
    try {
      FirebaseFirestore.instance.collection('Owner').doc(onwer.id).set({
        'image': onwer.image,
        'rating': onwer.rating,
        'phone1': onwer.phone1,
        'phone2': onwer.phone2,
        'bio': onwer.bio,
        'openHour': onwer.openHour,
        'closeHour': onwer.closeHour,
        'address': onwer.address,
      }, SetOptions(merge: true));
      emit(UploaddataSuccessStates());
    } catch (e) {
      emit(UploaddataErorrStates(Erorr: 'حدثت مشكله حاول لاحقا'));
    }
  }
}
