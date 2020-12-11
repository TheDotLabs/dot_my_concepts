import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Category extends Equatable {
  String imageUrl;
  String title;

  Category({this.imageUrl, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [title];
}
