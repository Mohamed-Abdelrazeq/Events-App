import 'package:events_app/Views/Component/MyButton.dart';
import 'package:events_app/Views/Component/MyFlushBar.dart';
import 'package:events_app/Views/Component/MyTextFieldAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Controllers/UserInfoController.dart';
import '../../Services/Authentication.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {

  void dispose() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    phoneController.clear();
  }
  //Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  //Functions
  Future<void> submissionFunction(var context) async {
    //Close Keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    MyFlushBar().show(context, 'Please Wait');
    //Check TextFields
    if (emailController.text == '') {
      MyFlushBar().show(context, 'Enter your email');
    } else if (passwordController.text == '') {
      MyFlushBar().show(context, 'Enter your email');
    } else if (usernameController.text == '') {
      MyFlushBar().show(context, 'Enter your email');
    }else if (phoneController.text == '') {
      MyFlushBar().show(context, 'Enter your email');
    }
    //Make Request
    else {
      //Get Credentials
      UserCredential userCredential = await Authentication().registration(emailController.text, passwordController.text);
      //Check Credentials
      if (userCredential != null) {
        Provider.of<UserInfoController>(context,listen: false).userCredentialSetter(userCredential);
        await Authentication().addUser(usernameController.text, emailController.text, phoneController.text);
        Navigator.pushNamed(context, '/MyHomePage');
      }else{
        MyFlushBar().show(context, 'The email is already used or the password is too weak');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return  GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .1),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              //Logo
              SizedBox(height: height*.1,),
              Hero(
                tag: 'Logo',
                child: Container(
                  height: height*.2,
                  width: width*.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/Logo.png')
                      )
                  ),
                ),
              ),
              //UserName
              SizedBox(height: height * .04),
              MyTextField(
                myColor: Colors.blue,
                myController: usernameController,
                height: height,
                width: width,
                myWidth: .8,
                myHeight: .1,
                hint: 'Username',
                myIcon: Icons.account_circle,),
              //Email
              SizedBox(height: height * .02),
              MyTextField(
                  myColor: Colors.blue,
                  myController: emailController,
                  height: height,
                  width: width,
                  myWidth: .8,
                  myHeight: .1,
                  hint: 'E-Mail',
                  myIcon: Icons.email),
              //Password
              SizedBox(height: height * .02),
              MyTextField(
                  myColor: Colors.blue,
                  myController: passwordController,
                  height: height,
                  width: width,
                  myWidth: .8,
                  myHeight: .1,
                  hint: 'Password',
                  myIcon: Icons.lock),
              //Phone Number
              SizedBox(height: height * .02),
              MyTextField(
                myColor: Colors.blue,
                  myController: phoneController,
                  height: height,
                  width: width,
                  myWidth: .8,
                  myHeight: .1,
                  hint: 'Phone',
                  myIcon: Icons.phone),
              SizedBox(height: height * .04),
              MyButton(
                myButtonColor: Colors.blue,
                width: width,
                height: height,
                myText: 'Register',
                horizontalPadding: width*.2,
                verticalPadding: height*.02,
                myTextColor: Colors.white,
                myFunc: ()async {
                  await submissionFunction(context);
                  dispose();
                },
              ),
              SizedBox(height: height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Already a User ?'
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text(
                      ' Login',
                      style: TextStyle(
                          color: Colors.blue
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: height * .1),
            ],
          ),
        ),
      ),
    );
  }
}

