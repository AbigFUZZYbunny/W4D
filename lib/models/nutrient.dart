// To parse this JSON data, do
//
//     final nutrient = nutrientFromJson(jsonString);
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:whats4dinner/utils/double_convert.dart';
import 'package:whats4dinner/custom_icons.dart' as CustomIcons;

class Nutrient {
  String title;
  double min;
  double max;
  double amount;
  String unit;
  double percentOfDailyNeeds;
  IconData icon;

  Nutrient({
    this.title,
    this.min,
    this.max,
    this.amount,
    this.unit,
    this.percentOfDailyNeeds,
    this.icon,
  });

  factory Nutrient.newUser(String t, String u) => new Nutrient(
    title:  t,
    unit: u,
    min: null,
    max: null,
    amount: null,
    percentOfDailyNeeds: null,
    icon: getIcon(t),
  );

  factory Nutrient.fromJson(String str) => Nutrient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nutrient.fromMap(Map json) => new Nutrient(
    title: json["title"] == null ? null : json["title"],
    min: json["min"] == null ? null : dynamicToDouble(json["min"]),
    max: json["max"] == null ? null : dynamicToDouble(json["max"]),
    amount: json["amount"] == null ? null : dynamicToDouble(json["amount"]),
    unit: json["unit"] == null ? null : json["unit"],
    percentOfDailyNeeds: json["percentOfDailyNeeds"] == null ? null : dynamicToDouble(json["percentOfDailyNeeds"]),
    icon: json["title"] == null ? null : getIcon(json["title"]),
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

IconData getIcon(String title){
  switch(title){
    case "Fat":
      return CustomIcons.CustomIcons.fat;
      break;
    case "Saturated Fat":
      return CustomIcons.CustomIcons.saturated_fat;
      break;
    case "Caffeine":
      return CustomIcons.CustomIcons.caffiene;
      break;
    case "Calcium":
      return CustomIcons.CustomIcons.calcium;
      break;
    case "Calories":
      return CustomIcons.CustomIcons.calories;
      break;
    case "Carbohydrates":
      return CustomIcons.CustomIcons.carbohydrates;
      break;
    case "Copper":
      return CustomIcons.CustomIcons.copper;
      break;
    case "Fiber":
      return CustomIcons.CustomIcons.fiber;
      break;
    case "Folate":
      return CustomIcons.CustomIcons.folate;
      break;
    case "Iron":
      return CustomIcons.CustomIcons.iron;
      break;
    case "Magnesium":
      return CustomIcons.CustomIcons.magnesium;
      break;
    case "Manganese":
      return CustomIcons.CustomIcons.manganese;
      break;
    case "Phosphorous":
      return CustomIcons.CustomIcons.phosphorous;
      break;
    case "Potassium":
      return CustomIcons.CustomIcons.potassium;
      break;
    case "Protein":
      return CustomIcons.CustomIcons.protein;
      break;
    case "Selenium":
      return CustomIcons.CustomIcons.selenium;
      break;
    case "Sodium":
      return CustomIcons.CustomIcons.sodium;
      break;
    case "Sugar":
      return CustomIcons.CustomIcons.sugar;
      break;
    case "Cholestorol":
      return CustomIcons.CustomIcons.total_cholestorol;
      break;
    case "Vitamin B1":
      return CustomIcons.CustomIcons.vitamin_b1;
      break;
    case "Vitamin B2":
      return CustomIcons.CustomIcons.vitamin_b2;
      break;
    case "Vitamin B3":
      return CustomIcons.CustomIcons.vitamin_b3;
      break;
    case "Vitamin B5":
      return CustomIcons.CustomIcons.vitamin_b5;
      break;
    case "Vitamin B6":
      return CustomIcons.CustomIcons.vitamin_b6;
      break;
    case "Vitamin B12":
      return CustomIcons.CustomIcons.vitamin_b12;
      break;
    case "Vitamin E":
      return CustomIcons.CustomIcons.vitamin_e;
      break;
    case "Vitamin C":
      return CustomIcons.CustomIcons.vitamin_c;
      break;
    case "Zinc":
      return CustomIcons.CustomIcons.zinc;
      break;
  }
  return null;
}
