import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/layout/cubit/cubit.dart';
import 'package:network_app/layout/cubit/states.dart';
import 'package:network_app/models/post_model.dart';


class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
            condition: SocialCubit.get(context).post.length > 0  ,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, int index)=>storyCard(context),
                      itemCount: 5,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=> buildPostItem(SocialCubit.get(context).post[index],context, index),
                    separatorBuilder: (context,index)=>const SizedBox(
                      height: 8,
                    ),
                    itemCount: SocialCubit.get(context).post.length,
                  ),
                ],
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget storyCard(context)
  {
    return
      Padding(
        padding: const EdgeInsets.all(5),
      child: Container(
        width: 100,
        decoration:BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(SocialCubit.get(context).userModel!.image),
            fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: [
          Container(
            height: 180,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors:[
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                ],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
              ),
            ),
          ),
            const Positioned(
              top: 8,
                left: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 22,
                  child: CircleAvatar(
              backgroundImage: NetworkImage('https://image.freepik.com/free-photo/unaware-clueless-bearded-handsome-man-shrugs-shoulders-with-uncertainty_273609-18625.jpg'),
                  ),
                ),
            ),
            Positioned(
              bottom: 8,
                left: 2,
                child: Text(
                  SocialCubit.get(context).userModel!.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
  Widget buildPostItem(PostModel model, context, index) =>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 8.0,),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children:  [
               CircleAvatar(
                radius: 25,
                backgroundImage:NetworkImage(
                  model.image!
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Row(
                      children:  [
                        Text(
                          '${model.name}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.check_circle_sharp,
                          color: Colors.blue,
                          size: 14,
                        )
                      ],
                    ),
                     Text(
                      '${model.dateTime}',
                      style:const TextStyle(
                          color: Colors.grey,
                          fontSize: 12
                      ) ,
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz,size: 16,))
            ],
          ),
          const Divider(),

          Text(
                '${model.text}'
            ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 5.0,),
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         SizedBox(
          //           height:20.0,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 0.1,
          //             padding: EdgeInsets.zero,
          //             child: const Text(
          //               '#Software',
          //               style: TextStyle(
          //                   color: Colors.blueAccent
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           height:20.0,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 0.1,
          //             padding: EdgeInsets.zero,
          //             child: const Text(
          //               ' #Software',
          //               style: TextStyle(
          //                   color: Colors.blueAccent
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           height:20.0,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 0.1,
          //             padding: EdgeInsets.zero,
          //             child: const Text(
          //               ' #Software',
          //               style: TextStyle(
          //                   color: Colors.blueAccent
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           height:20.0,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 0.1,
          //             padding: EdgeInsets.zero,
          //             child: const Text(
          //               ' #Software',
          //               style: TextStyle(
          //                   color: Colors.blueAccent
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           height:20.0,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 0.1,
          //             padding: EdgeInsets.zero,
          //             child: const Text(
          //               '#Software',
          //               style: TextStyle(
          //                   color: Colors.blueAccent
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           height:20.0,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 0.1,
          //             padding: EdgeInsets.zero,
          //             child: const Text(
          //               ' #Software',
          //               style: TextStyle(
          //                   color: Colors.blueAccent
          //               ),
          //             ),
          //           ),
          //         ),
          //
          //
          //       ],
          //     ),
          //   ),
          // ),

          if(model.postImage != '')
            Padding(
            padding: const EdgeInsetsDirectional.only(top: 15),
            child: Container(
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image:  DecorationImage(
                    image: NetworkImage(
                       model.postImage!
                    ),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children:  [
                          const Icon(
                            Icons.favorite_outline,
                            color: Colors.red,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.amber,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0 comment',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          const Divider(),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children:   [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage:NetworkImage(
                          SocialCubit.get(context).userModel!.image
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        'write a comment ..... ',
                        style:TextStyle(
                            color: Colors.grey,
                            fontSize: 12
                        ) ,
                      ),


                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                onTap: ()
                {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                  SocialCubit.get(context).getPost();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'LIKE',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.share,
                        color: Colors.amber,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Share',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    ),
  );
}
