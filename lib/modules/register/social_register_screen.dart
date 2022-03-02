import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/components/components.dart';
import 'package:network_app/layout/social_layout.dart';
import 'package:network_app/style/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class SocialRegisterScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController=TextEditingController();
  var phoneController = TextEditingController();
  var passwordAgainController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener:(context, state){
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(
                context,
                const SocialLayout());
          }
        } ,
        builder: (context, state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Colors.blueAccent,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              // Lottie.network('https://assets4.lottiefiles.com/packages/lf20_mmrchvy0.json'
                              //   ,
                              //   width: 80,
                              //   height: 80,
                              // ),
                              Text(
                                'Let\'s get started !',
                                style: Theme.of(context).textTheme.headline4!.copyWith(
                                  color: defaultColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Create an account to communicate with friends',
                                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color:Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your user name';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person_outline,
                        ),

                        const SizedBox(
                          height: 15.0 ,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),

                        const SizedBox(
                          height: 15.0 ,
                        ),

                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your phone number';
                            }
                          },
                          label: 'Phone number ',
                          prefix: Icons.phone_outlined,
                        ),

                        const SizedBox(
                          height: 15.0 ,
                        ),

                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          isPassword: SocialRegisterCubit.get(context).isPassword,
                          suffixPressed: (){

                            SocialRegisterCubit.get(context).changePasswordVisibility();

                          },

                          onSubmit:(value){
                            if(formKey.currentState!.validate())
                            {
                              // SocialRegisterCubit.get(context).userRegister(
                              //   name: nameController.text,
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              //   phone: phoneController.text,
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
                          height: 15.0 ,
                        ),
                        defaultFormField(
                          controller: passwordAgainController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          isPassword: SocialRegisterCubit.get(context).isPassword,
                          suffixPressed: (){

                            SocialRegisterCubit.get(context).changePasswordVisibility();

                          },

                          onSubmit:(value){
                            if(formKey.currentState!.validate())
                            {
                              // SocialRegisterCubit.get(context).userRegister(
                              //   name: nameController.text,
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              //   phone: phoneController.text,
                              // );
                            }
                          } ,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'This field must not be empty';
                            }else if(value != passwordController.text){
                              return "The password is not the same";
                            }
                          },
                          label: 'Confirm Password',
                          prefix: Icons.lock_outline,
                        ),



                        const SizedBox(
                          height: 30.0 ,
                        ),


                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState ,
                          builder:(context)=>defaultButton(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'SING UP',
                            isUpperCase: true,
                          ),
                          fallback:(context)=>const Center(child: CircularProgressIndicator()),
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
