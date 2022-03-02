
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget)
);

void navigateAndFinish(context, widget,) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context)=>widget
  ),
      (route)
  {
    return false;
  },
);


Widget defaultFormField({
  required TextEditingController controller,
  Function (String ?)? onSubmit,
  // Function? onChange,
  required String? Function(String?) validate,
  TextInputType? type,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      // onFieldSubmitted: (s){
      //   onSubmit!(s);
      // },



      validator:(value)
      {
        return validate(value);
      },

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? IconButton(
          onPressed: (){
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        ):null,
        border: OutlineInputBorder(
          borderRadius:BorderRadius.circular(30.0),
        ),
      ),


    );

Widget defaultButton({
  double width =double.infinity ,
  Color background =Colors.blue,
  bool isUpperCase =true,
  double radius= 4.0,
  required Function() function,
  required String text,
})=> Container(
  width: width,
  height: 50.0,
  child: MaterialButton(

    onPressed:function,
    child: Text (
      isUpperCase ? text.toUpperCase():text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius:BorderRadius.circular(50),
    color: background,
  ),

);

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.arrow_back_ios_outlined,
    ),
  ),
  titleSpacing: 5.0,
  title: Text(
    title!,
  ),
  actions: actions,
);

Widget defaultTextButtom({
  required Function() function,
  required String text,
})=>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );


void showToast({
  required String? text,
  required ToastStates state,
})=>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// لما يكون عندك كذا اختيار من الحاجة enum

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}