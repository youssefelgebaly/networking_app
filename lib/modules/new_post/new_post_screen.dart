import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/components/components.dart';
import 'package:network_app/layout/cubit/cubit.dart';
import 'package:network_app/layout/cubit/states.dart';


class NewPostScreen extends StatelessWidget {

  var textController=TextEditingController();

  NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black87,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            titleSpacing: 0.0,
            title: const Text(
              'Add post',
              style: TextStyle(
                  color: Colors.black87
              ),
            ),
            actions: [
              defaultTextButtom(
                  function: () {
                    var now = DateTime.now();
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).addPost(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                      SocialCubit.get(context).getPost();
                    } else {
                      SocialCubit.get(context).upPostImage(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                      SocialCubit.get(context).getPost();

                    }
                  },
                  text: 'Post'
              )

            ],

          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  const SizedBox(
                    height: 5,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                          SocialCubit
                              .get(context)
                              .userModel!
                              .image
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SocialCubit
                                .get(context)
                                .userModel!
                                .name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 120,
                              height: 25,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      'Public',
                                      style: TextStyle(
                                          color: Colors.blueAccent
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                      size: 20,
                                      color: Colors.blueAccent,
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'What\'s on your mind?',
                        border: InputBorder.none
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image:DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        )
                    ),

                    IconButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                defaultTextButtom(function: () {}, text: '# Add hashtag'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.image_outlined),
                            Text('Add Image'),
                          ],
                        )
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.camera_alt_outlined,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.location_on_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz,
                        color: Colors.blue,
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
