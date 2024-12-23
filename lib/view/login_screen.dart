import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/res/colors.dart';
import 'package:newsapp/res/components/round_button.dart';
import 'package:newsapp/utils/routes/routes.dart';
import 'package:newsapp/utils/routes/routes_name.dart';
import 'package:newsapp/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  FocusNode firstFocus=FocusNode();
  FocusNode secondFocus=FocusNode();
  FocusNode thirdFocus=FocusNode();
  ValueNotifier<bool> _obsecureText=ValueNotifier<bool>(true);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstFocus.dispose();
    secondFocus.dispose();
    thirdFocus.dispose();
    _obsecureText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HeightX=MediaQuery.of(context).size.height;
    final WidthY=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 250, 15, 15),
            child: TextFormField(
              controller: nameController,
              focusNode: firstFocus,
              decoration: InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(fontSize: 19,color: Colors.black),
                label: Text("Name"),
                labelStyle: TextStyle(fontSize: 19,color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(0, 75, 255, 1),
                    width: 2,
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(0, 75, 255, 1),
                    width: 2
                  )
                )
              ),
              onFieldSubmitted: (value) {
                Utils.focusChanger(context, firstFocus, secondFocus);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              controller: emailController,
              focusNode: secondFocus,
              decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(fontSize: 19,color: Colors.black),
                  label: Text("Email"),
                  labelStyle: TextStyle(fontSize: 19,color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 75, 255, 1),
                        width: 2,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 75, 255, 1),
                          width: 2
                      )
                  )
              ),
              onFieldSubmitted: (value) {
                Utils.focusChanger(context, secondFocus, thirdFocus);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ValueListenableBuilder(valueListenable: _obsecureText,
            builder: (context, value, child) {
              return TextFormField(
              controller: passwordController,
              focusNode: thirdFocus,
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(fontSize: 19,color: Colors.black),
                  label: Text("Password"),
                  labelStyle: TextStyle(fontSize: 19,color: Colors.black),
                  suffixIcon: InkWell(onTap: () {
                    _obsecureText.value=!_obsecureText.value;
                  },
                      child: _obsecureText.value? Icon(CupertinoIcons.eye_fill) : Icon(CupertinoIcons.eye_slash_fill)),
                  prefixIcon: Icon(CupertinoIcons.lock),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 75, 255, 1),
                        width: 2,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 75, 255, 1),
                          width: 2
                      )
                  )
              ),
                obscureText: _obsecureText.value,

            );
            },)
          ),
          Padding(
            padding: EdgeInsets.only(top: HeightX*0.1),
            child: RoundButton(text: "Login", height: HeightX*0.09, width: WidthY*0.49,
            color: AppColor.blue,
              onPress: () {
                if(nameController.text.isEmpty){
                  Utils.flushBar("Please Enter Name", context);
                }
                else if(emailController.text.isEmpty){
                  Utils.flushBar("Please Enter Email", context);
                }
                else if(passwordController.text.isEmpty){
                  Utils.flushBar("Please Enter Password", context);
                }
                else{
                  Navigator.pushReplacementNamed(context, RoutesName.home);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
