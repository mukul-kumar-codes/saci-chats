import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:saci/BackEnd/firebase/Auth/sign_up_auth.dart';
import 'package:saci/FrontEnd/home_page.dart';
import 'package:saci/Global_Uses/enum_generation.dart';
import 'package:saci/Global_Uses/reg_exp.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../widgets.dart';
// import 'package:flutter/cupertino.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final GlobalKey<FormState> _logInKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();

  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: LoadingOverlay(
          isLoading: this._isLoading,
          child: Container(
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
                    key: this._logInKey,
                    child: ListView(
                      children: [
                        commonTextFormField(hintText: 'Email', validator: (String? inputVal) {
                          if(!emailRegex.hasMatch(inputVal.toString())){
                            return "Email format is not matched.";
                          }
                          return null;
                        }, textEditingController: this._email),
                        commonTextFormField(hintText: "Password", validator: (String? inputVal) {
                          if(inputVal!.length < 6){
                            return "Password must be at least six characters.";
                          }
                          return null;
                        }, textEditingController: this._pwd),
                        logInAuthButton(context, 'Log-In'),
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
      ),
    );
  }

  Widget logInAuthButton(BuildContext context, String buttonName) {
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
        onPressed: () async{
          if(this._logInKey.currentState!.validate()){
            print("Validated");
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            if(mounted){
              setState((){
                this._isLoading = true;
              });
            }

            final EmailSignInResults emailSignInResults = await _emailAndPasswordAuth.signInWithEmailAndPassword(email: this._email.text, pwd: this._pwd.text);

            String msg = '';
            if(emailSignInResults == EmailSignInResults.SignInCompleted){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
            } else if(emailSignInResults == EmailSignInResults.EmailNotVerified){
              msg = "Email not verified.\nPlease verify your email and then log in.";
            }else if(emailSignInResults == EmailSignInResults.EmailOrPasswordInvalid){
              msg = "Email and password invalid";
            } else {
              msg = "Sign In not completed";
            }

            if(msg != ''){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            }


            if(mounted){
              setState((){
                this._isLoading = false;
              });
            }

          }else{
            print("Not Validated");
          }
        },
      ),
    );
  }
}
