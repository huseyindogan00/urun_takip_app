// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ConstantsModel {
  double? kdv;
  ConstantsModel({
    this.kdv = 0.18,
  });

  ConstantsModel copyWith({
    double? kdv,
  }) {
    return ConstantsModel(
      kdv: kdv ?? this.kdv,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kdv': kdv,
    };
  }

  factory ConstantsModel.fromMap(Map<String, dynamic> map) {
    return ConstantsModel(
      kdv: map['kdv'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConstantsModel.fromJson(String source) => ConstantsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ConstantsModel(kdv: $kdv)';

  @override
  bool operator ==(covariant ConstantsModel other) {
    if (identical(this, other)) return true;

    return other.kdv == kdv;
  }

  @override
  int get hashCode => kdv.hashCode;
}
