
import 'dart:convert';

import 'package:newsapp/data/network/network_api_service.dart';
import 'package:newsapp/models/all_news_model.dart';
import 'package:newsapp/models/category_news_model.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/res/apiurl.dart';
import 'package:newsapp/utils/utils.dart';


class NewsRepository{
  dynamic response;
  List sourceList=[];
  List sourceListnotfiltered=[];
  NetworkApiService _networkApiService=NetworkApiService();

  Future<NewsApiModel> fetchNewsApi(String selectedValue)async{

      response=await _networkApiService.getApiResponse(selectedValue=="All"? ApiUrl.allHeadLines : ApiUrl.sourceHeadLines+selectedValue+ApiUrl.apiKey);

      return NewsApiModel.fromJson(response);
  }
  Future<CategoryNewsModel> fetchCategoryNews(String category)async{
   var response=await _networkApiService.getApiResponse("${ApiUrl.categoryEverything}${category}${ApiUrl.apiKey}");
   return CategoryNewsModel.fromJson(response);
  }
  Future<List> fetchSourceList()async{
    try {
      sourceListnotfiltered.clear();
      sourceList.clear();
       await fetchNewsApi("All").then((value) {
         for (Map<String, dynamic> maps in response["articles"]) {
          sourceListnotfiltered.add(maps['source']);
         }
         sourceListnotfiltered.removeWhere((map) => map['id']==null);
         for(var existingMap in sourceListnotfiltered){
           if(!sourceList.any((uniqueMap) => uniqueMap['id']==existingMap['id'])){

             sourceList.add(existingMap);
           }
         }

         },);
      return sourceList;
    }
    catch (e){
      throw Exception(e.toString());
    }
  }
  Future<AllNewsModel> fetchEveryThing()async{
    dynamic response=await _networkApiService.getApiResponse(ApiUrl.everything);
    return AllNewsModel.fromJson(response);
  }

}