import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/components/components.dart';
import 'package:network_app/layout/cubit/cubit.dart';
import 'package:network_app/layout/cubit/states.dart';
import 'package:network_app/models/social_user_models.dart';
import 'package:network_app/modules/chat_page/chat_page_scree.dart';


class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>
      (
        listener: (context, state){},
        builder: (context, state){
          return ConditionalBuilder(
              condition: SocialCubit.get(context).users.length>0 ,
              builder: (context)=>ListView.separated(
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
                  separatorBuilder: (context, index) =>  const Divider(),
                  itemCount: SocialCubit.get(context).users.length
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
          );
        },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) =>InkWell(
    child: Padding(
      padding:  const EdgeInsets.all(15.0),
      child: Row(
        children:   [
          CircleAvatar(
            radius: 30,
            backgroundImage:NetworkImage(
               '${model.image}'
            ),
          ),
           SizedBox(
            width: 15,
          ),
          Text(
            '${model.name}',
            style:  TextStyle(
                fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    ),
    onTap: (){
      navigateTo(
          context,
           ChatPageScreen(
            userModel: model,
          )
      );
    },
  );

}
