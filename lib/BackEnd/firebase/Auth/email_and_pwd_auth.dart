import 'package:firebase_auth/firebase_auth.dart';
import 'package:saci/Global_Uses/enum_generation.dart';

class EmailAndPasswordAuth{

  Future<EmailSignUpResults> signUpAuth({required String email, required String pwd}) async {
    try{
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pwd);
      if(userCredential.user!.email != null){
        await userCredential.user!.sendEmailVerification();
        return EmailSignUpResults.SignUpCompleted;
      }
      return EmailSignUpResults.SignUpNotCompleted;
    } catch(e){
      print("Error in Email and Password Sign Up : ${e.toString()}");
      return EmailSignUpResults.EmailAlreadyPresent;
    }
  }

  Future<EmailSignInResults> signInWithEmailAndPassword({required String email, required String pwd}) async{
    try{
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pwd);
      if(userCredential.user!.emailVerified){
        return EmailSignInResults.SignInCompleted;
      }else{
        final logOutResponse = await logOut();
        if(logOutResponse){
          return EmailSignInResults.EmailNotVerified;
        }
        return EmailSignInResults.UnexpectedError;
      }
    }catch(e){
      print('Error in Sign In with email and password Authentication: ${e.toString()}');
      return EmailSignInResults.EmailOrPasswordInvalid;
    }
  }

  Future<bool> logOut() async {
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    }catch(e){
      return false;
    }
  }

}