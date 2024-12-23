import 'package:flutter/material.dart';
import 'package:newsapp/data/response/api_response.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/repository/news_repository.dart';

class HomeViewViewModel with ChangeNotifier{

  NewsRepository _newsRepository=NewsRepository();

  ApiResponse<NewsApiModel> _responseStatus=ApiResponse.loading();
  ApiResponse<NewsApiModel> get responseStatus => _responseStatus;

  setResponse(ApiResponse<NewsApiModel> responseStatus){
    _responseStatus=responseStatus;
    notifyListeners();
  }

  Future<void> fetchNewsApi(String selectedValue)async{

    setResponse(ApiResponse.loading());

    await _newsRepository.fetchNewsApi(selectedValue).then((value) {
      setResponse(ApiResponse.completed(value));
    },).onError((error, stackTrace) {
      setResponse(ApiResponse.error(error.toString()));
    },);

  }

}