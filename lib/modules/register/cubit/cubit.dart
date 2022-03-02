import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/models/social_user_models.dart';
import 'package:network_app/modules/register/cubit/states.dart';



class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,

  })
  {

    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value){

      userCreate(
          uId: value.user!.uid,
          email: email,
          name: name,
          phone: phone,
      );


    })
        .catchError((error){
      emit(SocialRegisterErrorState(error.toString()));

    });

  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  })
  {
    SocialUserModel model=SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write you bio ...',
      cover: 'https://image.freepik.com/free-photo/impressed-surprised-man-points-away-blank-space_273609-40694.jpg',
      image: 'https://image.freepik.com/free-photo/displeased-bearded-guy-smirks-face-uses-modern-cellphone-has-sad-expression-wears-transparent-glasses-jumper_273609-34133.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(SocialCreateUserSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }



  IconData suffix=Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix=isPassword ?Icons.visibility_off_outlined:Icons.visibility_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}