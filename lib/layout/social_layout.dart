import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/components/components.dart';
import 'package:network_app/layout/cubit/cubit.dart';
import 'package:network_app/layout/cubit/states.dart';
import 'package:network_app/modules/new_post/new_post_screen.dart';


class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state){},
        builder: (context, state){

          var cubit= SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Colors.black87,
              ),
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: const TextStyle(
                  color: Colors.black87

                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon:const Icon(Icons.search)),
                IconButton(onPressed: (){}, icon:const Icon(Icons.notifications_outlined)),
              ],
            ),
            body: cubit.screen[cubit.currentIndex],

            bottomNavigationBar: AnimatedBottomNavigationBar(
              icons: const [
                Icons.home_outlined,
                Icons.chat_bubble_outline,
                Icons.person_outline,
                Icons.settings_outlined,
              ],
              activeIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              activeColor: Colors.blue,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              // leftCornerRadius: 32,
              // rightCornerRadius: 32,
              height: 50,


            ),

            floatingActionButton: SizedBox(
              height: 55.0,
              width: 55.0,
              child: FloatingActionButton(
                child: const Icon(Icons.add,
                  size: 25,
                ),
                backgroundColor: Colors.blueAccent,
                 foregroundColor: Colors.white,
                onPressed: ()
                {
                  navigateTo(context,  NewPostScreen());
                },


              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


          );
        }
    );
  }
}
