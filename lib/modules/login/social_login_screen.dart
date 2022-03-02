import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:network_app/components/components.dart';
import 'package:network_app/layout/social_layout.dart';
import 'package:network_app/modules/register/social_register_screen.dart';
import 'package:network_app/network/local/cache_helper.dart';
import 'package:network_app/style/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class SocialLoginScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController=TextEditingController();

  SocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context,state)
        {
          if(state is SocialLoginErrorState)
          {
            showToast(
              text: state.error,
              state:ToastStates.ERROR,
            );
          }
          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value)
            {
              navigateAndFinish(
                context,
                const SocialLayout(),
              );
            });
          }
        },
        builder: (context,state){
          return  Scaffold(
            // backgroundColor: Colors.white,
            //
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //
            // ),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Welcome Back!',
                                style: Theme.of(context).textTheme.headline4!.copyWith(
                                  color: defaultColor,
                                ),
                              ),
                              Text(
                                ' Login now to communicate with friends ',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color:Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email address',
                          prefix: Icons.email_outlined,
                        ),

                        const SizedBox(
                          height: 15.0 ,
                        ),

                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: (){

                            SocialLoginCubit.get(context).changePasswordVisibility();

                          },

                          onSubmit:(value){
                            if(formKey.currentState!.validate())
                            {
                              // SocialLoginCubit.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
                            }
                          } ,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),



                        const SizedBox(
                          height: 30.0 ,
                        ),


                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState ,
                          builder:(context)=>Center(
                            child: defaultButton(
                              function: (){
                                if(formKey.currentState!.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'LOGIN',
                              // isUpperCase: true,
                            ),
                          ),
                          fallback:(context)=>const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0 ,
                        ),
                        Center(
                          child: Text(
                            'Or connect using',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0 ,
                        ),

                        // Center(
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         // width: double.infinity,
                        //         child: MaterialButton(
                        //           onPressed: (){},
                        //           child: Padding(
                        //             padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        //             child: Row(
                        //               children: [
                        //
                        //                 Image.asset('assets/images/search.png',),
                        //                 const SizedBox(
                        //                   width: 10,
                        //                 ),
                        //                 const Text(
                        //                   'Google',
                        //                   style: TextStyle(
                        //                       color: Colors.black54,
                        //                       fontSize: 15
                        //                   ),
                        //                 ),
                        //
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(18),
                        //             color: Colors.grey[200]
                        //         ),
                        //
                        //       ),
                        //       const SizedBox(
                        //         width: 15,
                        //       ),
                        //       Container(
                        //         // width: double.infinity,
                        //         child: MaterialButton(
                        //           onPressed: (){},
                        //           child: Padding(
                        //             padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        //             child: Row(
                        //               children: [
                        //                 Image.asset('assets/images/facebook.png',),
                        //                 const SizedBox(
                        //                   width: 10,
                        //                 ),
                        //                 const Text(
                        //                   'Facebook',
                        //                   style: TextStyle(
                        //                     color: Colors.black54,
                        //                     fontSize: 15,
                        //
                        //                   ),
                        //                 ),
                        //
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(18),
                        //             color: Colors.grey[200]
                        //         ),
                        //
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10.0 ,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Center(
                              child: Text(
                                'Don\'t have an account?',
                              ),
                            ),


                            defaultTextButtom(
                                function: ()
                                {
                                  navigateTo(
                                    context,
                                    SocialRegisterScreen(),
                                  );
                                },
                                text: 'Sign Up'
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

