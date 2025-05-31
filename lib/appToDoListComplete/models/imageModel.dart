import 'package:flutter/foundation.dart';

class ImageModel {
  ImageModel({required this.img, required this.status});

  String img;
  String status;

  factory ImageModel.fromJson(Map<String, dynamic> json){
  return ImageModel(
    img: json['message'] as String,
    status: json['status'] as String,
  );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': img,
      'status': status,
    };
  }
}
