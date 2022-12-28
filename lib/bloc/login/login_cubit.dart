import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../data/services/api.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final auth = FirebaseAuth.instance;

  bool isObscure = true;

  bool isLogin = true;

  void toggleLoginRegister() {
    isLogin = !isLogin;
    emit(LoginAndRegister());
  }

  void setObscure(bool value) {
    isObscure = value;
    emit(ChangePasswordVisibility());
  }

  void userRegister({required String email, required String password}) {
    emit(RegisterLoadState());
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value);
      emit(RegisterSuccessState());
      Hive.box('data').put('uid', value.user!.uid);
    }).onError((error, stackTrace) {
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userLogin({required String email, required String password}) {
    emit(LoginLoadState());
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value);
      emit(LoginSuccessState());
      Hive.box('data').put('uid', value.user!.uid);
    }).onError((error, stackTrace) {
      print(error);
      emit(LoginErrorState(error.toString()));
    });
  }

  void userLogout() {
    emit(LogoutLoadState());
    Api().api.post(
      "logout",
      data: {'fcm_token': 'SomeFcmToken'},
    ).then((value) {
      print(value.data);
      emit(LogoutSuccessState());
    }).onError((error, stackTrace) {
      print(error);
      emit(LogoutErrorState(error.toString()));
    });
  }
}
