import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:saci/BackEnd/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
import 'package:saci/BackEnd/sqlite_management/local_database_management.dart';
import 'package:saci/widgets.dart';

import '../MainScreen/home_page.dart';
import '../MainScreen/main_screen.dart';

class TakePrimaryUserData extends StatefulWidget {
  const TakePrimaryUserData({Key? key}) : super(key: key);

  @override
  State<TakePrimaryUserData> createState() => _TakePrimaryUserDataState();
}

class _TakePrimaryUserDataState extends State<TakePrimaryUserData> {

  bool _isLoading = false;

  final GlobalKey<FormState> _takeUserPrimaryInformationKey = GlobalKey<FormState>();

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userAbout = TextEditingController();

  final CloudStoreDataManagement _cloudStoreDataManagement =
    CloudStoreDataManagement();

  final LocalDatabase _localDatabase = LocalDatabase();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: LoadingOverlay(
            isLoading: this._isLoading,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: this._takeUserPrimaryInformationKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _upperHeading(),
                    commonTextFormField( bottomPadding: 30.0,
                        hintText: 'User Name',
                        validator: (inputUserName){
                        // Regular Expression
                          final RegExp _messageRegex = RegExp(r'[a-zA-Z0-9]');

                        if(inputUserName!.length < 6){
                          return 'User Name must have six character';
                        } else if(inputUserName.contains(' ') || inputUserName.contains('@')){
                          return "Space and '@' Not allowed... Use '_' instead of space";
                        } else if(inputUserName.contains('__')){
                          return "'__' not allowed...Use '_' instead of '__'";
                        } else if(!_messageRegex.hasMatch(inputUserName)){
                          return "Sorry, Only emoji not supported";
                        }
                        return null;
                      }, textEditingController: this._userName),

                    commonTextFormField(hintText: 'About User', validator: (inputVal){
                      if(inputVal!.length < 1){
                        return 'User About must have to fill';
                      }
                      return null;
                    }, textEditingController: this._userAbout),
                    _saveUserPrimaryInformation(),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  Widget _upperHeading() {
    return const Padding(
        padding: EdgeInsets.only(top:  30.0, bottom: 50.0),
        child: Center(
          child: Text(
            'Set Up your Account',
            style: TextStyle(
            color: Colors.black,
            fontSize: 23.0,
          ),),
        ),
    );
  }

  Widget _saveUserPrimaryInformation() {
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
          'Save',
          style: const TextStyle(
            fontSize: 25.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () async {
          if(this._takeUserPrimaryInformationKey.currentState!.validate()){
            print('Validated');

            SystemChannels.textInput.invokeMethod('TextInput.hide');

            if(mounted){
              setState((){
                this._isLoading = true;
              });
            }

            final bool canRegisterNewUser = await _cloudStoreDataManagement.checkThisUserAlreadyPresentOrNot(userName: this._userName.text);

            String msg = '';

            if(!canRegisterNewUser){
              msg ='User name already present';
            } else{


              final bool _userEntryRespose = await _cloudStoreDataManagement.registerNewUser(userName: this._userName.text, userAbout: this._userAbout.text, userEmail: FirebaseAuth.instance.currentUser!.email.toString());

              if(_userEntryRespose){
                msg = 'User data entry successful';

                /// Calling Local Databases Methods to Initialize Local Database with required method

                await this._localDatabase.createTableToStoreImportantData();

                final Map<String, dynamic> _importantFetchData = await _cloudStoreDataManagement.getTokenFromCloudStore(userMail: FirebaseAuth.instance.currentUser!.email.toString());

                await this._localDatabase.insertOrUpdateDataForThisAccount(
                    userName: this._userName.text,
                    userMail: FirebaseAuth.instance.currentUser!.email.toString(),
                    userToken: _importantFetchData["token"],
                    userAbout: this._userAbout.text,
                    userAccCreationDate: _importantFetchData["date"],
                    userAccCreationTime: _importantFetchData["time"]);

                await _localDatabase.createTableForUserActivity(tableName: this._userName.text);

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainScreen()), (route) => false);
              } else {
                msg = 'User data entry unsuccessful';
              }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            }


            if(mounted){
              setState((){
                this._isLoading = false;
              });
            }

          } else {
            print('Not Validated');
          }
        },
      ),
    );
  }
}
