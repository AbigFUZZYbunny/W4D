// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

import 'dart:convert';
import 'ingredient_item.dart';
import 'nutrient.dart';
import 'package:whats4dinner/utils/double_convert.dart';

class Recipe {
  String recipeType;
  int weightWatcherSmartPoints;
  int preparationMinutes;
  int cookingMinutes;
  String sourceUrl;
  String creditText;
  double pricePerServing;
  List<IngredientItem> extendedIngredients;
  int id;
  String title;
  int readyInMinutes;
  int servings;
  String image;
  String imageType;
  Nutrition nutrition;
  List<String> cuisines;
  List<String> diets;
  List<AnalyzedInstruction> analyzedInstructions;
  String creditsText;

  Recipe({
    this.recipeType,
    this.weightWatcherSmartPoints,
    this.preparationMinutes,
    this.cookingMinutes,
    this.sourceUrl,
    this.creditText,
    this.pricePerServing,
    this.extendedIngredients,
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.image,
    this.imageType,
    this.nutrition,
    this.cuisines,
    this.diets,
    this.analyzedInstructions,
    this.creditsText,
  });

  factory Recipe.fromJson(String str) => Recipe.fromMap(json.decode(str));

  factory Recipe.fromSpoonacular(String str) {
    var j = json.decode(str);
    Recipe r = new Recipe.fromMap(j);
    r.extendedIngredients = List<IngredientItem>.from(j["extendedIngredients"].map((x) => IngredientItem.fromMap(x)))
    return r;
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromMap(Map json) => new Recipe(
    weightWatcherSmartPoints: json["weightWatcherSmartPoints"] == null ? null : json["weightWatcherSmartPoints"],
    preparationMinutes: json["preparationMinutes"] == null ? null : json["preparationMinutes"],
    cookingMinutes: json["cookingMinutes"] == null ? null : json["cookingMinutes"],
    sourceUrl: json["sourceUrl"] == null ? null : json["sourceUrl"],
    creditText: json["creditText"] == null ? null : json["creditText"],
    pricePerServing: json["pricePerServing"] == null ? null : Converter.dynamicToDouble(json["pricePerServing"]),
    extendedIngredients: new List<IngredientItem>(),
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    readyInMinutes: json["readyInMinutes"] == null ? null : json["readyInMinutes"],
    servings: json["servings"] == null ? null : json["servings"],
    image: json["image"] == null ? null : json["image"],
    imageType: json["imageType"] == null ? null : json["imageType"],
    nutrition: json["nutrition"] == null ? null : Nutrition.fromMap(json["nutrition"]),
    cuisines: json["cuisines"] == null ? null : new List<String>.from(json["cuisines"].map((x) => x)),
    diets: json["diets"] == null ? null : new List<String>.from(json["diets"].map((x) => x)),
    analyzedInstructions: json["analyzedInstructions"] == null ? null : new List<AnalyzedInstruction>.from(json["analyzedInstructions"].map((x) => AnalyzedInstruction.fromMap(x))),
    creditsText: json["creditsText"] == null ? null : json["creditsText"],
  );

  Map<String, dynamic> toMap() => {
    "weightWatcherSmartPoints": weightWatcherSmartPoints == null ? null : weightWatcherSmartPoints,
    "preparationMinutes": preparationMinutes == null ? null : preparationMinutes,
    "cookingMinutes": cookingMinutes == null ? null : cookingMinutes,
    "sourceUrl": sourceUrl == null ? null : sourceUrl,
    "creditText": creditText == null ? null : creditText,
    "pricePerServing": pricePerServing == null ? null : pricePerServing,
    "extendedIngredients": extendedIngredients == null ? null : new List<dynamic>.from(extendedIngredients.map((x) => x.toMap())),
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "readyInMinutes": readyInMinutes == null ? null : readyInMinutes,
    "servings": servings == null ? null : servings,
    "image": image == null ? null : image,
    "imageType": imageType == null ? null : imageType,
    "nutrition": nutrition == null ? null : nutrition.toMap(),
    "cuisines": cuisines == null ? null : new List<dynamic>.from(cuisines.map((x) => x)),
    "diets": diets == null ? null : new List<dynamic>.from(diets.map((x) => x)),
    "analyzedInstructions": analyzedInstructions == null ? null : new List<dynamic>.from(analyzedInstructions.map((x) => x.toMap())),
    "creditsText": creditsText == null ? null : creditsText,
  };
}

class AnalyzedInstruction {
  List<Step> steps;

  AnalyzedInstruction({
    this.steps,
  });

  factory AnalyzedInstruction.fromJson(String str) => AnalyzedInstruction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AnalyzedInstruction.fromMap(Map json) => new AnalyzedInstruction(
    steps: json["steps"] == null ? null : new List<Step>.from(json["steps"].map((x) => Step.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "steps": steps == null ? null : new List<dynamic>.from(steps.map((x) => x.toMap())),
  };
}

class Step {
  int number;
  String step;
  List<IngredientItem> ingredients;
  List<Equipment> equipment;
  Length length;

  Step({
    this.number,
    this.step,
    this.ingredients,
    this.equipment,
    this.length,
  });

  factory Step.fromJson(String str) => Step.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Step.fromMap(Map json) => new Step(
    number: json["number"] == null ? null : json["number"],
    step: json["step"] == null ? null : json["step"],
    ingredients: json["ingredients"] == null ? null : new List<IngredientItem>.from(json["ingredients"].map((x) => IngredientItem.fromMap(x))),
    equipment: json["equipment"] == null ? null : new List<Equipment>.from(json["equipment"].map((x) => Equipment.fromMap(x))),
    length: json["length"] == null ? null : Length.fromMap(json["length"]),
  );

  Map<String, dynamic> toMap() => {
    "number": number == null ? null : number,
    "step": step == null ? null : step,
    "ingredients": ingredients == null ? null : new List<dynamic>.from(ingredients.map((x) => x.toMap())),
    "equipment": equipment == null ? null : new List<dynamic>.from(equipment.map((x) => x.toMap())),
    "length": length == null ? null : length.toMap(),
  };
}

class Equipment {
  int id;
  String name;
  String image;

  Equipment({
    this.id,
    this.name,
    this.image,
  });

  factory Equipment.fromJson(String str) => Equipment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Equipment.fromMap(Map json) => new Equipment(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
  };
}

class Length {
  double number;
  String unit;

  Length({
    this.number,
    this.unit,
  });

  factory Length.fromJson(String str) => Length.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Length.fromMap(Map json) => new Length(
    number: json["number"] == null ? null : Converter.dynamicToDouble(json["number"]),
    unit: json["unit"] == null ? null : json["unit"],
  );

  Map<String, dynamic> toMap() => {
    "number": number == null ? null : number,
    "unit": unit == null ? null : unit,
  };
}

class Nutrition {
  List<Nutrient> nutrients;
  CaloricBreakdown caloricBreakdown;
  WeightPerServing weightPerServing;

  Nutrition({
    this.nutrients,
    this.caloricBreakdown,
    this.weightPerServing,
  });

  factory Nutrition.fromJson(String str) => Nutrition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nutrition.fromMap(Map json) => new Nutrition(
    nutrients: json["nutrients"] == null ? null : new List<Nutrient>.from(json["nutrients"].map((x) => Nutrient.fromMap(x))),
    caloricBreakdown: json["caloricBreakdown"] == null ? null : CaloricBreakdown.fromMap(json["caloricBreakdown"]),
    weightPerServing: json["weightPerServing"] == null ? null : WeightPerServing.fromMap(json["weightPerServing"]),
  );

  Map<String, dynamic> toMap() => {
    "nutrients": nutrients == null ? null : new List<dynamic>.from(nutrients.map((x) => x.toMap())),
    "caloricBreakdown": caloricBreakdown == null ? null : caloricBreakdown.toMap(),
    "weightPerServing": weightPerServing == null ? null : weightPerServing.toMap(),
  };
}

class CaloricBreakdown {
  double percentProtein;
  double percentFat;
  double percentCarbs;

  CaloricBreakdown({
    this.percentProtein,
    this.percentFat,
    this.percentCarbs,
  });

  factory CaloricBreakdown.fromJson(String str) => CaloricBreakdown.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CaloricBreakdown.fromMap(Map json) => new CaloricBreakdown(
    percentProtein: json["percentProtein"] == null ? null : Converter.dynamicToDouble(json["percentProtein"]),
    percentFat: json["percentFat"] == null ? null : Converter.dynamicToDouble(json["percentFat"]),
    percentCarbs: json["percentCarbs"] == null ? null : Converter.dynamicToDouble(json["percentCarbs"]),
  );

  Map<String, dynamic> toMap() => {
    "percentProtein": percentProtein == null ? null : percentProtein,
    "percentFat": percentFat == null ? null : percentFat,
    "percentCarbs": percentCarbs == null ? null : percentCarbs,
  };
}

class WeightPerServing {
  double amount;
  String unit;

  WeightPerServing({
    this.amount,
    this.unit,
  });

  factory WeightPerServing.fromJson(String str) => WeightPerServing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeightPerServing.fromMap(Map json) => new WeightPerServing(
    amount: json["amount"] == null ? null : Converter.dynamicToDouble(json["amount"]),
    unit: json["unit"] == null ? null : json["unit"],
  );

  Map<String, dynamic> toMap() => {
    "amount": amount == null ? null : amount,
    "unit": unit == null ? null : unit,
  };
}
