import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/layout/cubit/cubit.dart';
import 'package:network_app/layout/cubit/states.dart';
import 'package:network_app/models/message_model.dart';
import 'package:network_app/models/social_user_models.dart';

class ChatPageScreen extends StatelessWidget {

  SocialUserModel? userModel;

  ChatPageScreen({Key? key,
    this.userModel,
}) : super(key: key);

  var messageController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMesssage(receiverId: userModel!.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state){},
          builder: (context, state){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                titleSpacing: 0,
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
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                          userModel!.image
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      userModel!.name,
                      style: const TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
              body:  ConditionalBuilder(
                condition: true,
                builder:(context) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                     Expanded(
                       child: ListView.separated(
                           itemBuilder: (context, index){
                             var message= SocialCubit.get(context).messages[index];
                             if(SocialCubit.get(context).userModel!.uId == message.senderId ) {
                               return buildOtherMessage(message);
                             }
                             return buildMessage(message);
                           },
                           separatorBuilder: (context, state){
                             return const SizedBox(height: 15.0,);
                           },
                           itemCount: SocialCubit.get(context).messages.length,
                       ),
                     ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey[300]!
                          ),
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,

                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message text..',
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(onPressed: ()
                            {
                              SocialCubit.get(context).sendMessage(
                                receiverId: userModel!.uId,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                              );
                            },
                              elevation: 0,
                              minWidth: 1.0,
                              height: 50,
                              color: Colors.blue,
                              child: const Icon(
                                Icons.send_outlined,
                                color: Colors.white,
                                size: 20,

                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback:(context) => const Center(child: CircularProgressIndicator()),

              ),

            );
          },

        );
      },
      
    );
  }

  Widget buildMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:  BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(20),
            bottomStart: Radius.circular(20),
            topEnd: Radius.circular(20),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15
      ),
      child:  Text(
        model.text!,
        style: const TextStyle(
            fontSize: 16
        ),
      ),
    ),
  );
  Widget buildOtherMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration:  BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(20),
            bottomStart: Radius.circular(20),
            topStart: Radius.circular(20),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15
      ),
      child:  Text(
         model.text!,
        style: const TextStyle(
            fontSize: 16
        ),
      ),
    ),
  );
}
