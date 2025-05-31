import 'dart:convert';

import 'package:git_app/appToDoListComplete/models/imageModel.dart';
import 'package:http/http.dart';



Future <ImageModel> getData() async {
try {
    final response = await get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  
  
  if (response.statusCode == 200) {
    
    return ImageModel.fromJson(jsonDecode(response.body));
  }

  else {
    throw Exception('Failed to load image');
  }
} catch (e) {
   print('Error: $e');
      throw Exception('Failed to load image');
}


}


Future <T> getData2 <T>() async {
try {
    final response = await get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  
  
  if (response.statusCode == 200) {
    
    return (jsonDecode(response.body));
  }

  else {
    throw Exception('Failed to load image');
  }
} catch (e) {
   print('Error: $e');
      throw Exception('Failed to load image');
}


}