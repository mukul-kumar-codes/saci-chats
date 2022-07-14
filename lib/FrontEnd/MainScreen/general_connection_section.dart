import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:circle_list/circle_list.dart';
import 'package:fluttericon/entypo_icons.dart';

class GeneralMessagingSection extends StatefulWidget {
  const GeneralMessagingSection({Key? key}) : super(key: key);

  @override
  State<GeneralMessagingSection> createState() => _GeneralMessagingSectionState();
}

class _GeneralMessagingSectionState extends State<GeneralMessagingSection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(34, 48, 60, 1),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: CircleList(
                initialAngle: 55,
                outerRadius: MediaQuery.of(context).size.width/2.2,
                innerRadius: MediaQuery.of(context).size.width/4.0,
                showInitialAnimation: true,
                innerCircleColor: Color.fromRGBO(34, 48, 60, 1),
                outerCircleColor: Color.fromRGBO(0, 0, 0, 0.1),
                origin: Offset(0,0),
                rotateMode: RotateMode.allRotate,
                centerWidget: Center(
                  child: Text(
                    'SACI',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 48,
                      fontFamily: 'Lora'
                    ),
                  ),
                ),

                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.blue,
                        width: 3,
                      )
                    ),
                    child: GestureDetector(
                      onTap: () async {

                      },
                      onLongPress: () async {

                      },
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.greenAccent,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        )
                    ),
                    child: GestureDetector(
                      onTap: () async {

                      },
                      onLongPress: () async {

                      },
                      child: Icon(
                        Icons.video_collection,
                        color: Colors.greenAccent,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        )
                    ),
                    child: GestureDetector(
                      onTap: () async {

                      },
                      onLongPress: () async {

                      },
                      child: Icon(
                        Icons.text_fields,
                        color: Colors.greenAccent,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        )
                    ),
                    child: GestureDetector(
                      onTap: () async {

                      },
                      onLongPress: () async {

                      },
                      child: Icon(
                        Icons.document_scanner,
                        color: Colors.greenAccent,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        )
                    ),
                    child: GestureDetector(
                      onTap: () async {

                      },
                      onLongPress: () async {

                      },
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.greenAccent,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        )
                    ),
                    child: GestureDetector(
                      onTap: () async {

                      },
                      onLongPress: () async {

                      },
                      child: Icon(
                        Icons.music_note,
                        color: Colors.greenAccent,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
