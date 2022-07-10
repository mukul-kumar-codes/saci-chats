import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'FrontEnd/AuthUI/log_in.dart';
import 'FrontEnd/AuthUI/sign_up.dart';

Widget commonTextFormField({required String hintText, required String? Function(String?)? validator, required TextEditingController textEditingController}){
  return Container(
    padding: const EdgeInsets.only(right: 32.0, left: 32.0, bottom: 24.0),
    child: TextFormField(
      validator: validator,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}

// Widget authButton(BuildContext context, String buttonName) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0),
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//           minimumSize: Size(
//             MediaQuery.of(context).size.width - 60, 30.0,
//           ),
//           elevation: 5.0,
//           primary: const Color.fromRGBO(57, 60, 88, 1),
//           padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 7.0, bottom: 7.0),
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0))
//           )
//       ),
//       child: Text(
//         buttonName,
//         style: const TextStyle(
//           fontSize: 25.0,
//           letterSpacing: 1.0,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//       onPressed: () async{
//
//       },
//     ),
//   );
// }

Widget socialMediaIntegrationButtons() {
  return Container(
    width: double.maxFinite,
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
            onTap: (){
              print("Google Pressed.");
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

Widget switchAnotherAuthScreen(BuildContext context, String buttonNameFirst, String buttonNameLast){
  return ElevatedButton(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          buttonNameFirst,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            letterSpacing: 1.0,
          ),
        ),
        Text(
          buttonNameLast,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 16.0,
            letterSpacing: 1.0,
          ),
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(
        elevation: 0.0,
        primary: const Color.fromRGBO(255, 255, 255, 1)
    ),
    onPressed: () async {
      if(buttonNameLast == 'Log-In') {
        Navigator.push(context, MaterialPageRoute(builder:(_) => const LogInScreen()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
      }
    },
  );
}