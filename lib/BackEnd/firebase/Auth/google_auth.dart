import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Global_Uses/enum_generation.dart';

class GoogleAuthentication{
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInResults> signInWithGoogle() async{
    try{
      if(await this._googleSignIn.isSignedIn()){
        return GoogleSignInResults.AlreadySignIn;
      } else {
        final GoogleSignInAccount? _googleSignInAccount = await this._googleSignIn.signIn();
        if(_googleSignInAccount == null){

          return GoogleSignInResults.SignInNotCompleted;
        } else {
          final GoogleSignInAuthentication _googleSignInAuth = await _googleSignInAccount.authentication;

          final OAuthCredential _oAuthCredential = await GoogleAuthProvider.credential(
            accessToken: _googleSignInAuth.accessToken,
            idToken: _googleSignInAuth.idToken,
          );

          final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(_oAuthCredential);

          if(userCredential.user!.email != null){
            print('Google Sign In completed');
            return GoogleSignInResults.SignInCompleted;
          } else {
            print('Google Sign In problem');
            return GoogleSignInResults.UnexpectedError;
          }
        }
      }
    } catch(e){
      print('Error in Google Sign In ${e.toString()}');
      return GoogleSignInResults.UnexpectedError;
    }
  }

  Future<bool> logOut() async{
    try{
      print('Google Log Out');

      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch(e){
      print('Error in Google Log Out ${e.toString()}');
      return false;
    }
  }
}
