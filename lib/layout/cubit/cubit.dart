import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:network_app/components/constants.dart';
import 'package:network_app/layout/cubit/states.dart';
import 'package:network_app/models/message_model.dart';
import 'package:network_app/models/post_model.dart';
import 'package:network_app/models/social_user_models.dart';
import 'package:network_app/modules/chats/chats_screen.dart';
import 'package:network_app/modules/feeds/feeds_screen.dart';
import 'package:network_app/modules/settings/settings_screen.dart';
import 'package:network_app/modules/users/users_screen.dart';


class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit(): super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;



  void getUserData() async
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {

       userModel= SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });


  }

  int currentIndex =0;
  List<Widget> screen=
  [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String>titles=
  [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index)
  {
    currentIndex =index;
    emit(SocialChangeBottomNavState());
  }

  File? profileImage;
  Future<void> getProfileImage()async
  {
     final pickedFile =await ImagePicker().pickImage(
        source: ImageSource.gallery,
    );

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else
      {
        print('No image selected');
        emit(SocialProfileImagePickedErrorState());
      }
  }


  File? coverImage;
  Future<void> getCoverImage()async
  {
    final pickedFile =await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if(pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else
    {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
})
  {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('userss/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
      //  emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            image: value,
        );
      }).catchError((error){
        emit(SocialUploadProfileImageErrorState());

      });
    })
        .catchError((error){
      emit(SocialUploadProfileImageErrorState());

    });

  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('userss/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
     //   emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: value
        );
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());

      });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorState());

    });

  }

  void updateUser({
  required String name,
  required String phone,
  required String bio,
   String? cover,
   String? image,

})
  {
        // SocialUserModel model=SocialUserModel(
        //   name: name,
        //   phone: phone,
        //   bio: bio,
        //   email: userModel!.email,
        //   cover: userModel!.cover,
        //   image: userModel!.image,
        //   uId: userModel!.uId,
        //   isEmailVerified: false,
        // );
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uId)
            .update({
          'name':name,
          'uId':uId,
          'bio':bio,
          'cover':cover??userModel!.cover,
          'image':image??userModel!.image,
          'email':userModel!.email,
          'phone':phone,

        })
            .then((value)
        {
          getUserData();
        })
            .catchError((error){
              emit(SocialUserUploadErrorState());
        });

   }

  File? postImage;
  Future<void> getPostImage()async
  {
    final pickedFile =await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if(pickedFile != null)
    {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }else
    {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage()
  {
    postImage= null;
    emit(SocialRemovePostImageState());
  }
  void upPostImage({
    required String dateTime,
    required String text,
  })
  {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('post/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        print(value);
        addPost(
            dateTime: dateTime,
            text: text,
          postImage: value,
        );
      }).catchError((error){
        emit(SocialCreatePostErrorState());

      });
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());

    });

  }

  void addPost({
    required String dateTime,
    required String text,
    String? postImage,
  })
  {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('post')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());

    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });

  }

  List<PostModel> post =[];
  List<String?> postId =[];
  List<int> likes =[];

  void getPost(){
    FirebaseFirestore.instance
        .collection('post')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
        element.reference
        .collection('likes')
        .get()
        .then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          post.add(PostModel.fromJson(element.data()));
        })
        .catchError((error){});

      });
      emit(SocialGetPostsSuccessState());
    })
        .catchError((error){
          emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String? postId){
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true,
    })
        .then((value){

          emit(SocialLikePostSuccessState());
    })
        .catchError((error){
          emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users= [];

  void getUsers(){
    if(users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value)
     {
      value.docs.forEach((element)
      {
          users.add(SocialUserModel.fromJson(element.data()));

        emit(SocialGetAllUserSuccessState());});
    })
        .catchError((error){
      emit(SocialGetAllUserErrorState(error.toString()));
    });
    }
  }

  void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
  }){
    MessageModel model =MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value) => emit(SocialSendMessageSuccessState()))
    .catchError((error)=> emit(SocialSendMessageErrorState()));


    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) => emit(SocialSendMessageSuccessState()))
        .catchError((error)=> emit(SocialSendMessageErrorState()));
  }

  List<MessageModel> messages =[];

  void getMesssage
  ({
  required String receiverId
  }){

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages =[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
       emit(SocialGetMessagesSuccessState());
    });
  }
}


