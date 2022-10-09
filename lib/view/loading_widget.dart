
import 'package:flutter/material.dart';

class loadingWidget extends StatelessWidget {
  bool? isLoading;
  Widget child;

  loadingWidget({this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    if(isLoading == null){
      return Center(child: CircularProgressIndicator());
    }else if(isLoading == false){
      return Center(child: Text('Bir sorun olustu'),);
    }else{
      return child;
    }
  }
}