import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:saci/BackEnd/firebase/OnlineDatabaseManagement/new_user_entry.dart';
import 'package:saci/FrontEnd/AuthUI/log_in.dart';
import 'package:saci/FrontEnd/MainScreen/home_page.dart';
import 'package:saci/FrontEnd/MainScreen/main_screen.dart';
import 'package:saci/FrontEnd/NewUserEntry/new_user_entry.dart';
import 'FrontEnd/AuthUI/sign_up.dart';

import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MaterialApp(
        title: "SACI Chats",
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home: await differentContextDecisionTake(),
      )
  );
}

Future<Widget> differentContextDecisionTake() async{
  if(FirebaseAuth.instance.currentUser == null){
    return LogInScreen();
  } else {
    final CloudStoreDataManagement _cloudStoreDataManagement =
      CloudStoreDataManagement();
    final bool _dataPresentResponse = await _cloudStoreDataManagement.userRecordPresentOrNot(
        email: FirebaseAuth.instance.currentUser!.email.toString());

    return _dataPresentResponse ? MainScreen() : TakePrimaryUserData();

  }
}