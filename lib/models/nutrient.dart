// To parse this JSON data, do
//
//     final nutrient = nutrientFromJson(jsonString);

import 'dart:convert';
import 'package:whats4dinner/utils/double_convert.dart';

class Nutrient {
  String title;
  double min;
  double max;
  double amount;
  String unit;
  double percentOfDailyNeeds;

  Nutrient({
    this.title,
    this.min,
    this.max,
    this.amount,
    this.unit,
    this.percentOfDailyNeeds,
  });

  factory Nutrient.newUser(String t, String u) => new Nutrient(
    title:  t,
    unit: u,
    min: null,
    max: null,
    amount: null,
    percentOfDailyNeeds: null,
  );

  factory Nutrient.fromJson(String str) => Nutrient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nutrient.fromMap(Map<String, dynamic> json) => new Nutrient(
    title: json["title"] == null ? null : json["title"],
    min: json["min"] == null ? null : Converter.dynamicToDouble(json["min"]),
    max: json["max"] == null ? null : Converter.dynamicToDouble(json["max"]),
    amount: json["amount"] == null ? null : Converter.dynamicToDouble(json["amount"]),
    unit: json["unit"] == null ? null : json["unit"],
    percentOfDailyNeeds: json["percentOfDailyNeeds"] == null ? null : Converter.dynamicToDouble(json["percentOfDailyNeeds"]),
  );

  Map<String, dynamic> toMap() => {
    "title": title == null ? null : title,
    "min": min == null ? null : min,
    "max": max == null ? null : max,
    "amount": amount == null ? null : amount,
    "unit": unit == null ? null : unit,
    "percentOfDailyNeeds": percentOfDailyNeeds == null ? null : percentOfDailyNeeds,
  };
}
