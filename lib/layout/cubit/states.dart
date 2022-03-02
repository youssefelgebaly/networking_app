abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

//get_user
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}


class SocialProfileImagePickedSuccessState extends SocialStates {}
class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}
class SocialCoverImagePickedErrorState extends SocialStates {}
//up_profile_image
class SocialUploadProfileImageSuccessState extends SocialStates {}
class SocialUploadProfileImageErrorState extends SocialStates {}
//up_cover
class SocialUploadCoverImageSuccessState extends SocialStates {}
class SocialUploadCoverImageErrorState extends SocialStates {}
//user_update
class SocialUserUpdateLoadingState extends SocialStates {}
class SocialUserUploadErrorState extends SocialStates {}

//post_create
class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostSuccessState extends SocialStates {}
class SocialCreatePostErrorState extends SocialStates {}
//post_image
class SocialPostImagePickedSuccessState extends SocialStates {}
class SocialPostImagePickedErrorState extends SocialStates {}
class SocialRemovePostImageState extends SocialStates {}
//get_post
class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}
//like
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}
//get_all_user
class SocialGetAllUserLoadingState extends SocialStates{}
class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

// chat
class SocialSendMessageSuccessState extends SocialStates {}
class SocialSendMessageErrorState extends SocialStates {}
class SocialGetMessagesSuccessState extends SocialStates {}
class SocialGetMessagesErrorState extends SocialStates {}