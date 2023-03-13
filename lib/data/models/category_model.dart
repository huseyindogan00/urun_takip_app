// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  String? categoryId;
  String? categoryName;
  String? categorySubName;
  CategoryModel({
    this.categoryId,
    this.categoryName,
    this.categorySubName,
  });

  CategoryModel copyWith({
    String? categoryId,
    String? categoryName,
    String? categorySubName,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categorySubName: categorySubName ?? this.categorySubName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categorySubName': categorySubName,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId:
          map['categoryId'] != null ? map['categoryId'] as String : null,
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
      'CategoryModel(categoryId: $categoryId, categoryName: $categoryName, categorySubName: $categorySubName)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.categorySubName == categorySubName;
  }

  @override
  int get hashCode =>
      categoryId.hashCode ^ categoryName.hashCode ^ categorySubName.hashCode;
}
