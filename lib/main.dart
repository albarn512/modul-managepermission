import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
void main() {
  runApp(MaterialApp(home: MyHome()));
}

class MyHome extends StatefulWidget{

  @override
  _MyHomeState creaeteState()  => _MyHomeState();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _MyHomeState extends State<MyHome>{
  late PermissionStatus _status;

  @override
  void initState(){
    super.initState();
    PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse).then(_updateStatus);
  }
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        Text('$_status'),
        RaisedButton(
          child: Text('Ask Permission'),
          onPressed: _askPermission,
        )
      )
    );
  }

  void _updateStatus(PermissionStatus status){
    if(status!= _status){
      setState((){
        _status = status;
      });
    }
  }

  void _askPermission(){
     PermissionHandler().requestPermission(
     [PermissionGroup.locationWhenInUse]).then(_onStatusRequested);
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses){
    final status = statuses[PermissionGroup.locationWhenInUse];
    if (status != PermissionStatus.granted){
      PermissionHandler().openAppSettings();
    }else{
    _updateStatus(status!);
    }
  }
}

