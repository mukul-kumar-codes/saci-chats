import 'package:flutter/material.dart';

import '../../widgets.dart';
// import 'package:flutter/cupertino.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
                  child: Text('Log-in', style: TextStyle(fontSize: 32.0, color: Colors.black),)
              ),
              Container(
                height: MediaQuery.of(context).size.height/2.5,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 24.0, bottom: 10.0,),
                child: Form(
                  child: ListView(
                    children: [
                      commonTextFormField(hintText: 'Email'),
                      commonTextFormField(hintText: "Password"),
                      authButton(context, 'Log-In'),
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
              switchAnotherAuthScreen(context,"Don't have an account?","Sign-Up"),
            ],
          ),
        ),
      ),
    );
  }
}
