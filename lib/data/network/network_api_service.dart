import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:newsapp/data/app_exceptions.dart';
import 'package:newsapp/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService{
  @override
  Future getApiResponse(String Url) async{
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(Url)).timeout(
          Duration(seconds: 10));
      responseJson=returnResponse(response);

    }on SocketException {
      throw SocketException("Internet Error");
    }
    on TimeoutException{
      throw TimeoutException("TimeOut Exception");
    }
    return responseJson;

  }
  @override
  Future postApiResponse(String Url,dynamic data) async{
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(Url),
          body: data
      ).timeout(Duration(seconds: 10));
      responseJson=returnResponse(response);
    }on SocketException{
      throw CommunicationException(message: "Error in Internet Connection");
    }
    return responseJson;
  }
  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson=jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        throw BadException(message: "Unable to get request from the server with status code: ${response.statusCode}");
      case 500:
      case 404:
        throw InvalidInputException(message:response.body.toString());
      default:
        CommunicationException(message: "Unable to connect with server with status code: ${response.statusCode.toString()}");
    }

  }

}