import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_app/components/components.dart';
import 'package:network_app/layout/cubit/cubit.dart';
import 'package:network_app/layout/cubit/states.dart';


class EditProfileScreen extends StatefulWidget {
   const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  late File image;
  var  picker = ImagePicker();

  Future getImage()async
  {
    
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){

        var userModel=SocialCubit.get(context).userModel;
        late var profileImage =SocialCubit.get(context).profileImage;
        late var coverImage =SocialCubit.get(context).coverImage;

        nameController.text=userModel!.name;
        bioController.text=userModel.bio;
        phoneController.text=userModel.phone;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black87,
            ),
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            titleSpacing: 0.0,
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                  color: Colors.black87
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: ()
                    {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text
                      );
                    },
                    child: const Text(
                        'UPDATE'
                    )
                ),
              )
            ],
          ),
          body:  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                  const LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [

                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                    ),
                                    image:DecorationImage(
                                      image:coverImage == null ? NetworkImage(
                                        userModel.cover,
                                      ):FileImage(coverImage) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                              ),

                              IconButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),

                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                             CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.white,
                              child:  CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null ? NetworkImage(
                                    userModel.image
                                ): FileImage(profileImage) as ImageProvider,

                              ),
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon:  const CircleAvatar(
                                radius: 14,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 13,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)

                  Row(
                    children: [
                      if(SocialCubit.get(context).profileImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            MaterialButton(
                              minWidth: double.infinity,
                              height: 40,
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text
                                  );
                                },
                              color: Colors.blueAccent,
                              child:  const Text(
                                'UPLOAD PROFILE',
                                style: TextStyle(
                                  color: Colors.white
                                ),

                              ),
                                ),
                            if(state is SocialUserUpdateLoadingState)
                              const SizedBox(
                              height: 3,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const LinearProgressIndicator(),

                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            MaterialButton(
                              minWidth: double.infinity,
                              height: 40,
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                  );
                                },
                              color: Colors.blueAccent,
                              child:  const Text(
                                'UPLOAD COVER',
                                style: TextStyle(
                                  color: Colors.white
                                ),

                              ),
                                ),
                            if(state is SocialUserUpdateLoadingState)
                              const SizedBox(
                              height: 3,
                            ),
                            if(state is SocialUserUpdateLoadingState)

                              const LinearProgressIndicator(),


                          ],
                        ),
                      ),
                    ],
                  ),

                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)


                    const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: nameController,
                    validate: (value)
                    {
                      if(value!.isEmpty){
                        return 'please enter your name';
                      }
                    },
                    label: 'name',
                    prefix: Icons.person_outline,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: bioController,
                    validate: (value)
                    {
                      if(value!.isEmpty){
                        return 'please enter your bio';
                      }
                    },
                    label: 'bio',
                    prefix: Icons.info_outline,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  defaultFormField(
                    controller: phoneController,
                    validate: (value)
                    {
                      if(value!.isEmpty){
                        return 'please enter your bio';
                      }
                    },
                    label: 'Phone',
                    prefix: Icons.phone_outlined,
                  ),

                ],
              ),
            ),
          ),

        );
      },

    );
  }
}
