
import 'package:crud_operation_spring/model/pets.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PetsProvider extends ChangeNotifier{
  static const endpoint = 'https://jatinderji.github.io/users_pets_api/users_pets.json';

  String error = '';
  bool isLoading = true;
  Pets pets = Pets(data : []);

  getPets() async{
    try{
      var uri = Uri.parse(endpoint);
      Response response = await http.get(uri);

      if(response.statusCode == 200){
        pets = petsFromJson(response.body);

      }else
        {
          error = response.statusCode.toString();
        }

    }
    catch (e){
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}