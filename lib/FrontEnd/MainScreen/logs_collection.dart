import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LogsCollection extends StatefulWidget {
  const LogsCollection({Key? key}) : super(key: key);

  @override
  State<LogsCollection> createState() => _LogsCollectionState();
}

class _LogsCollectionState extends State<LogsCollection> {

  bool _isLoading = false;
  final List<String> _callingConnection = ['Mukul', 'Shashank', 'Shivani'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(34, 48, 60, 1),
        body: LoadingOverlay(
          isLoading: this._isLoading,
          color: const Color.fromRGBO(0, 0, 0, 0.5),
          progressIndicator: const CircularProgressIndicator(
            backgroundColor: Colors.black87,
          ),
          child: Container(
            margin: const EdgeInsets.all(6.0),
            width: double.maxFinite,
            height: double.maxFinite,
            child: ListView.builder(
              itemCount: this._callingConnection.length,
              itemBuilder: (upperContext, index) => _everyConnectionHistory(index),
            ),
          ),
          ),
        ),
      );
  }

  Widget _everyConnectionHistory(int index){
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: const Color.fromRGBO(31, 51, 71, 1),
            backgroundImage:
            ExactAssetImage('assets/images/google.png'),
            //getProperImageProviderForConnectionsCollection(
            //    _userName),
          ),
          Text(
            this._callingConnection[index],
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
            ),
          ),
          IconButton(
            icon: Icon(Icons.call, size: 30.0,color: Colors.green,),
            onPressed: (){

            },
          ),
        ],
      ),
    );
  }
}
