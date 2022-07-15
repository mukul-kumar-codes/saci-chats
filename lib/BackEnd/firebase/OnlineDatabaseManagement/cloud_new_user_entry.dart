import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../sqlite_management/local_database_management.dart';


class CloudStoreDataManagement{

  final _collectionName = 'saci_users';

  Future<bool> checkThisUserAlreadyPresentOrNot({required String userName}) async{
    try{
      final QuerySnapshot<Map<String, dynamic>> findResults = await FirebaseFirestore.instance
          .collection(_collectionName)
          .where('user_name', isEqualTo: userName)
          .get();

      print('Debug 1 ${findResults.docs}');


      return findResults.docs.isEmpty ? true : false;
    } catch(e){
      print("Error in check. This user already present or not: ${e.toString()}");
      return false;
    }


  }

  Future<bool> registerNewUser({required String userName, required String userAbout, required String userEmail}) async{
    try{

      final String? _getToken = await FirebaseMessaging.instance.getToken();

      final String currDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

      final String currTime = "${DateFormat('hh:mm a').format(DateTime.now())}";


      FirebaseFirestore.instance.doc('$_collectionName/$userEmail').set({
        "about": userAbout,
        "activity": [],
        "connection_request": [],
        "connections": [],
        "creation_date": currDate,
        "creation_time": currTime,
        "phone_number": "",
        "profile_pic": "",
        "token": _getToken,
        "total_connections": "",
        "user_name": userName,
      });

      return true;
    } catch(e){
      print('Error in register new user: ${e.toString()}');

      return false;
    }
  }

  Future<bool> userRecordPresentOrNot({required String email}) async{
    try{

      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.doc('${this._collectionName}/$email').get();
      return documentSnapshot.exists;
    } catch (e){
      print('Error in user record present or not: ${e.toString()}');
      return false;
    }
  }

  Future<Map<String, dynamic>> getTokenFromCloudStore({required String userMail}) async{
    try{
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.doc('${this._collectionName}/$userMail').get();

      print('DocumentSnapshot is: ${documentSnapshot.data()}');

      final Map<String, dynamic> importantData = Map<String, dynamic>();

      importantData["token"] = documentSnapshot.data()!["token"];
      importantData["date"] = documentSnapshot.data()!["creation_date"];
      importantData["time"] = documentSnapshot.data()!["creation_time"];

      return importantData;

    } catch (e){
      print('Error in get Token from Cloud Store: ${e.toString()}');
      return {};
    }
  }

}