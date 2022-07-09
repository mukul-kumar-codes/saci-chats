import 'package:flutter/material.dart';

import '../../widgets.dart';
// import 'package:flutter/cupertino.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/10.0,
              ),
              const Center(
                  child: Text('Sign-Up', style: TextStyle(fontSize: 32.0, color: Colors.black),)
              ),
              Container(
                height: MediaQuery.of(context).size.height/1.75,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 24.0, bottom: 10.0,),
                child: Form(
                  child: ListView(
                    children: [
                      commonTextFormField(hintText: 'Email'),
                      commonTextFormField(hintText: "Password"),
                      commonTextFormField(hintText: "Confirm Password"),
                      authButton(context, 'Sign-Up'),
                    ],
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "Or continue with",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                ),
              ),
              socialMediaIntegrationButtons(),
              switchAnotherAuthScreen(context, "Already have an account?", "Log-In"),
            ],
          ),
        ),
      ),
    );
  }



}
