// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Drug {
  String title;
  String fullName;
  String id;
  String unit;
  num price;
  String imgUrl;
  String type;
  String ingredients;
  String uses;
  double rating;
  int brought;
  String container;
  Drug({
    required this.title,
    required this.fullName,
    required this.id,
    required this.unit,
    required this.price,
    required this.imgUrl,
    required this.type,
    required this.ingredients,
    required this.uses,
    required this.rating,
    required this.brought,
    required this.container,
  });

  Drug copyWith({
    String? title,
    String? fullName,
    String? id,
    String? unit,
    double? price,
    String? imgUrl,
    String? type,
    String? ingredients,
    String? uses,
    double? rating,
    int? brought,
    String? container,
  }) {
    return Drug(
      title: title ?? this.title,
      fullName: fullName ?? this.fullName,
      id: id ?? this.id,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      type: type ?? this.type,
      ingredients: ingredients ?? this.ingredients,
      uses: uses ?? this.uses,
      rating: rating ?? this.rating,
      brought: brought ?? this.brought,
      container: container ?? this.container,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'fullName': fullName,
      'id': id,
      'unit': unit,
      'price': price,
      'imgUrl': imgUrl,
      'type': type,
      'ingredients': ingredients,
      'uses': uses,
      'rating': rating,
      'brought': brought,
      'container': container,
    };
  }

  factory Drug.fromMap(Map<String, dynamic> map) {
    return Drug(
      title: map['title'] as String,
      fullName: map['fullName'] as String,
      id: map['id'] as String,
      unit: map['unit'] as String,
      price: map['price'] as num,
      imgUrl: map['imgUrl'] as String,
      type: map['type'] as String,
      ingredients: map['ingredients'] as String,
      uses: map['uses'] as String,
      rating: map['rating'] as double,
      brought: map['brought'] as int,
      container: map['container'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Drug.fromJson(String source) =>
      Drug.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Drug(title: $title, fullName: $fullName, id: $id, unit: $unit, price: $price, imgUrl: $imgUrl, type: $type, ingredients: $ingredients, uses: $uses, rating: $rating, brought: $brought, container: $container)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Drug &&
        other.title == title &&
        other.fullName == fullName &&
        other.id == id &&
        other.unit == unit &&
        other.price == price &&
        other.imgUrl == imgUrl &&
        other.type == type &&
        other.ingredients == ingredients &&
        other.uses == uses &&
        other.rating == rating &&
        other.brought == brought &&
        other.container == container;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        fullName.hashCode ^
        id.hashCode ^
        unit.hashCode ^
        price.hashCode ^
        imgUrl.hashCode ^
        type.hashCode ^
        ingredients.hashCode ^
        uses.hashCode ^
        rating.hashCode ^
        brought.hashCode ^
        container.hashCode;
  }
}

final dummyDrug = Drug(
    title: '',
    fullName: '',
    id: '',
    unit: 'Bottle',
    price: 0,
    imgUrl: '',
    type: 'A1',
    ingredients: '',
    uses: '',
    rating: 0,
    brought: 0,
    container: '');
