import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'chatAndActivityScreen.dart';
import 'general_connection_section.dart';
import 'logs_collection.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: WillPopScope(
          onWillPop: () async {
            if(_currIndex > 0){
              return false;
            } else {
              print('Tata');
              return true;
            }
          },
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(34, 48, 60, 1),
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(25, 39, 52, 1),
              brightness: Brightness.dark,
              elevation: 0.5,
              shadowColor: Colors.white70,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                  side: BorderSide(
                    width:  0.7,
                  ),
                ),
                title: const Text(
                  "SACI Chats",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Lora',
                    letterSpacing: 1.0,
                  ),
                ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.search_outlined,
                    size: 25.0,
                  ),
                ),

                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    tooltip: 'Refresh',
                    icon: Icon(
                      Icons.refresh_outlined,
                      size: 25.0,
                    ),
                    onPressed: () async {
                      print('Clicked Refresh in MainWindow');

                    },
                  ),
                )
              ],
              bottom: _bottom(),
            ),
            body: TabBarView(
              children: [
                ChatAndActivityScreen(),
                LogsCollection(),
                GeneralMessagingSection(),
              ],
            ),
          ),
        ),
    );
  }

  TabBar _bottom() {
    return TabBar(
      indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.lightBlue
        ),
        insets: EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
      ),
      automaticIndicatorColorAdjustment: true,
      labelStyle: TextStyle(
        fontFamily: 'Lora',
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
      ),
      onTap: (index){
        print('\nIndex is : $index');
        if(mounted){
          setState((){
            _currIndex = index;
          });
        }
      },
      tabs: [
        Tab(
          child: Text(
            "Chats",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
          ),
        ),

        Tab(
          child: Text(
            "Logs",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
          ),
        ),

        Tab(
          icon: Icon(
            Icons.store,
            size: 25.0,
          ),
        ),
      ],
    );
  }
}
