import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/components/components.dart';
import 'package:network_app/layout/cubit/cubit.dart';
import 'package:network_app/layout/cubit/states.dart';
import 'package:network_app/modules/edit_profile/edit_profile_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){

        },
      builder: (context,state)
      {
        var userModel =SocialCubit.get(context).userModel!;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [

                    Align(
                      child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration:   BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            ),
                            image:DecorationImage(
                              image: NetworkImage(
                               userModel.cover,
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                      CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child:  CircleAvatar(
                        radius: 60,
                        backgroundImage:NetworkImage(
                          userModel.image
                        ),

                      ),
                    )


                  ],
                ),
              ),
              Text(
                userModel.name,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                  userModel.bio,
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '45',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Post',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '150',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'photo',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '20k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '250',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],

                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                        onPressed: (){},
                        child: const Text(
                            'Add Photo'
                        ),
                      )
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OutlinedButton(
                      onPressed: (){
                        navigateTo(context,  const EditProfileScreen());
                      },
                      child:const Icon(Icons.edit_outlined)
                  ),
                ],
              ),



            ],
          ),
        );
      },
    );
  }
}
