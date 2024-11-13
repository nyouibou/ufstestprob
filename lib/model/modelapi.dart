// To parse this JSON data, do
//
//     final sampleApiModel = sampleApiModelFromJson(jsonString);

import 'dart:convert';

SampleApiModel sampleApiModelFromJson(String str) =>
    SampleApiModel.fromJson(json.decode(str));

String sampleApiModelToJson(SampleApiModel data) => json.encode(data.toJson());

class SampleApiModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  SampleApiModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory SampleApiModel.fromJson(Map<String, dynamic> json) => SampleApiModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating?.toJson(),
      };
}

class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
