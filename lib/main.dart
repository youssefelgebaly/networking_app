import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/components/constants.dart';
import 'bloc_observer.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/social_layout.dart';
import 'modules/login/social_login_screen.dart';
import 'network/local/cache_helper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  // dynamic onBoardingFinish = false;
  // onBoardingFinish = CacheHelper.getData(key: 'onBoarding');

  uId = CacheHelper.getData(key: 'uId', );

  Bloc.observer = MyBlocObserver();

  late Widget start;

    if(uId != null)
    {
      start =const SocialLayout();
    }else{
      start = SocialLoginScreen();
    }


  runApp(MyApp(start));
}

class MyApp extends StatelessWidget {
  final Widget startApp;
  const MyApp(this.startApp, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context) => SocialCubit()..getUserData()..getPost()..getUsers(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return(
              MaterialApp(
                debugShowCheckedModeBanner: false,
                home: startApp,
              )
          );
        },
      ),
    );
  }

}
class Themes
{
  static final  light=ThemeData(

    primaryColor: Colors.blue,
    brightness: Brightness.light,
  );

  static final dark=ThemeData(

    primaryColor:  Colors.yellow,
    brightness: Brightness.dark,
  );
}
