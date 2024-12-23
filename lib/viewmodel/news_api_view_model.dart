import 'package:flutter/material.dart';
import 'package:newsapp/models/all_news_model.dart';
import 'package:newsapp/models/category_news_model.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/repository/news_repository.dart';



class NewsApiViewModel with ChangeNotifier{
  bool _isLoading=false;
  bool get isLoading => _isLoading;

  List _sourceList=[];
  List get sourceList => _sourceList;
  var data=[];
  void functionfetch(){
    notifyListeners();
  }
  void colorChange(){
    notifyListeners();
  }







}