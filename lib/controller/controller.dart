import 'package:flutter/material.dart';
import 'package:riverpod_flutter_using/model/model.dart';
import 'package:riverpod_flutter_using/service/service.dart';

class Controller extends ChangeNotifier{
  PageController pageController = PageController(initialPage: 0);
  bool? isLoading;
  List <Data?> users=[];
  List <Data?> saved=[];


  void getData(){
    Service.fetch().then((value) {
      if(value!= null){
        users = value.data!;
        isLoading = true;
        // değişikliği algılaması için notifyListeners koyuyoruz
        notifyListeners();
      }
      else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  // users'taki veriyi alıp saved'e atan bir fonk yazalım

  void  addSaved (Data model){
    saved.add(model);
    users.remove(model);
    notifyListeners();
  }
  
  void removeUsers(Data model){
    saved.remove(model);
    users.add(model);
    notifyListeners();
  }

  notSavedButton(){
    pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

   savedButton(){
    pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.linear);
  }
}