class SocialUserModel{
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late String cover;
  late String bio;
  late bool isEmailVerified;


  SocialUserModel({
   required  this.name,
    required  this.email,
    required this.phone,
    required this.uId,
    required  this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return {
        'name':name,
        'email':email,
        'phone':phone,
        'uId':uId,
        'image':image,
        'cover':cover,
        'bio':bio,
        'isEmailVerified':isEmailVerified,
      };

    // final Map<String, dynamic> data =new Map<String,dynamic>();
    //
    // data['name']= this.name;
    // data['email']= this.email;
    // data['phone']= this.phone;
    // data['uId']= this.uId;
    // data['image']= this.image;
    // data['cover']= this.cover;
    // data['bio']= this.bio;
    // data['isEmailVerified']= this.isEmailVerified;
    //
    // return data;
    //
    //

  }

}