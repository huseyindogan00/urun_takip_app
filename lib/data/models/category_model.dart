// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:urun_takip_app/data/models/base/base_model.dart';

class CategoryModel implements BaseModel {
  @override
  String? id;
  String? categoryName;
  String? categorySubName;
  CategoryModel({
    this.id,
    this.categoryName,
    this.categorySubName,
  });

  CategoryModel copyWith({
    String? id,
    String? categoryName,
    String? categorySubName,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      categorySubName: categorySubName ?? this.categorySubName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryName': categoryName,
      'categorySubName': categorySubName,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] != null ? map['id'] as String : null,
      categoryName:
          map['categoryName'] != null ? map['categoryName'] as String : null,
      categorySubName: map['categorySubName'] != null
          ? map['categorySubName'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(id: $id, categoryName: $categoryName, categorySubName: $categorySubName)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.categoryName == categoryName &&
        other.categorySubName == categorySubName;
  }

  @override
  int get hashCode =>
      id.hashCode ^ categoryName.hashCode ^ categorySubName.hashCode;
}
