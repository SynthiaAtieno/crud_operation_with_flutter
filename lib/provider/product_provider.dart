import 'dart:convert';

import 'package:crud_operation_spring/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProductProvider extends ChangeNotifier{
  static const endpoint = 'http://192.168.3.1:8080/api/getProducts';

  String error = '';
  bool isLoading = true;

  List <Products> products = [];

  getProducts() async{

    try{
      final uri = Uri.parse(endpoint);
      Response response = await http.get(uri);
      if(response.statusCode == 200){

         products = productsFromJson(response.body);
      }else{
        error = response.statusCode.toString();
      }
    }
    catch(e){
      //print(e);
      return e.toString();
    }
    isLoading = false;
    notifyListeners();
    }



}