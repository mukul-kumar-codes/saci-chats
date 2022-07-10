import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:saci/BackEnd/firebase/Auth/email_and_pwd_auth.dart';
import 'package:saci/BackEnd/firebase/Auth/google_auth.dart';
import 'package:saci/FrontEnd/AuthUI/log_in.dart';
import 'package:saci/Global_Uses/enum_generation.dart';

import '../../Global_Uses/reg_exp.dart';
import '../../widgets.dart';
import '../home_page.dart';
// import 'package:flutter/cupertino.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _confirmPwd = TextEditingController();

  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();
  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: LoadingOverlay(
          isLoading: this._isLoading,
          color: Colors.blue,
          child: Container(
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
                    key: this._signUpKey,
                    child: ListView(
                      children: [
                        commonTextFormField(hintText: 'Email', validator: (inputVal){
                          if(!emailRegex.hasMatch(inputVal.toString())) {
                            return "Email format not matching.";
                          }
                          return null;
                        }, textEditingController: this._email),
                        commonTextFormField(hintText: "Password", validator: (String? inputVal) {
                          if(inputVal!.length < 6) {
                            return "Password must be at least 6 characters.";
                          }
                          return null;
                        }, textEditingController: this._pwd),
                        commonTextFormField(hintText: "Confirm Password", validator: (String? inputVal) {
                          if(inputVal!.length < 6){
                            return "Confirm password must be at least 6 characters.";
                          }
                          if(this._pwd.text != this._confirmPwd.text){
                            return 'Password and Confirm Password not same here.';
                          }
                          return null;
                        }, textEditingController: this._confirmPwd),
                        sigUpAuthButton(context, 'Sign-Up'),
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
                signUpSocialMediaIntegrationButtons(),
                switchAnotherAuthScreen(context, "Already have an account?", "Log-In"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sigUpAuthButton(BuildContext context, String buttonName) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(
              MediaQuery.of(context).size.width - 60, 30.0,
            ),
            elevation: 5.0,
            primary: const Color.fromRGBO(57, 60, 88, 1),
            padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 7.0, bottom: 7.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            )
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 25.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () async {
          if(this._signUpKey.currentState!.validate()){
            print("Validated");
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            if(mounted){
              setState((){
                this._isLoading = true;
              });
            }
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            final EmailSignUpResults response = await this._emailAndPasswordAuth.signUpAuth(email: this._email.text, pwd: this._pwd.text);
            if(response == EmailSignUpResults.SignUpCompleted){
              Navigator.push(context, MaterialPageRoute(builder: (_) => LogInScreen()));
            }else{
              final String msg = response == EmailSignUpResults.EmailAlreadyPresent?'Email already present':'Sign up not completed';
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            }
          }else{
            print("Not Validated");
          }

          if(mounted){
            setState((){
              this._isLoading = false;
            });
          }

        },
      ),
    );
  }

  Widget signUpSocialMediaIntegrationButtons() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () async {
                print("Google Pressed.");
                if(mounted){
                  setState((){
                    this._isLoading = true;
                  });
                }

                final GoogleSignInResults _googleSignInResults = await this._googleAuthentication.signInWithGoogle();

                String msg = '';
                if(_googleSignInResults == GoogleSignInResults.SignInCompleted){
                  msg = 'Sign In completed';
                } else if(_googleSignInResults == GoogleSignInResults.SignInNotCompleted){
                  msg = 'Sign In not completed';
                } else if(_googleSignInResults == GoogleSignInResults.AlreadySignIn){
                  msg = 'Already Sign In';
                } else {
                  msg = 'Unexpected Error happened';
                }

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

                if(_googleSignInResults == GoogleSignInResults.SignInCompleted){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                          (route) => false);
                }

                if(mounted){
                  setState((){
                    this._isLoading = false;
                  });
                }

              },
              child: Image.asset('assets/images/google.png', width: 64.0,)),
          GestureDetector(
              onTap: (){
                print("Facebook Pressed.");
              },
              child: Image.asset('assets/images/fbook.png', width: 64.0,)),
        ],
      ),
    );
  }


}
