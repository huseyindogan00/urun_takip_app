// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CategoryModel {
  String? categoryId;
  Map<String, List<String>> category;
  CategoryModel({
    this.categoryId,
    required this.category,
  });

  CategoryModel copyWith({
    String? categoryId,
    Map<String, List<String>>? category,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'category': category,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        categoryId:
            map['categoryId'] != null ? map['categoryId'] as String : null,
        category: Map<String, List<String>>.from(
          (map['category'] as Map<String, List<String>>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(categoryId: $categoryId, category: $category)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.categoryId == categoryId &&
        mapEquals(other.category, category);
  }

  @override
  int get hashCode => categoryId.hashCode ^ category.hashCode;
}
