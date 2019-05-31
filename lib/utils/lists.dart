import 'dart:io';
import 'dart:async';
import 'dart:convert';

List<String> dietsList(){
  List<String> _ret = ["pescetarian", "lacto vegetarian", "ovo vegetarian", "vegan", "paleo", "primal", "vegetarian"];
  return _ret;
}

List<String> allergyList(){
  List<String> _ret = ["dairy", "egg", "gluten", "peanut", "sesame", "seafood", "shellfish", "soy", "sulfite", "tree nut", "wheat"];
  return _ret;
}

List<String> cuisineList(){
  List<String> _ret = [ "African", "American", "British", "Cajun", "Caribbean", "Chinese", "Eastern European", "French", "German", "Greek", "Indian", "Irish", "Italian", "Japanese", "Jewish", "Korean", "Latin American", "Mexican", "Middle Eastern", "Nordic", "Southern", "Spanish", "Thai", "Vietnamese"];
  return _ret;
}

Map<String, String> nutrientsList(){
  Map<String, String> _ret = {
    "Calories": "cal",
    "Fat": "g",
    "Protein": "g",
    "Carbs": "g",
    "Alcohol": "g",
    "Caffeine": "mg",
    "Copper": "mg",
    "Calcium": "mg",
    "Choline": "mg",
    "Cholesterol": "mg",
    "Fluoride": "mg",
    "Saturated Fat": "g",
    "Vitamin A": "IU",
    "Vitamin C": "mg",
    "Vitamin D": "µg",
    "Vitamin E": "mg",
    "Vitamin K": "µg",
    "Vitamin B1": "mg",
    "Vitamin B2": "mg",
    "Vitamin B3": "mg",
    "Vitamin B5": "mg",
    "Vitamin B6": "mg",
    "Vitamin B12": "µg",
    "Fiber": "mg",
    "Folate": "g",
    "Folic Acid": "g",
    "Iodine": "g",
    "Iron": "mg",
    "Magnesium": "mg",
    "Manganese": "mg",
    "Phosphorus": "mg",
    "Potassium": "mg",
    "Selenium": "g",
    "Sodium": "mg",
    "Sugar": "mg",
    "Zinc": "mg"
  };
  return _ret;
}

List<String> ingredientsList(){
  List<String> _ret = new List<String>();
  final File file = new File("lib/data/ingredients.csv");

  Stream<List> inputStream = file.openRead();

  inputStream
      .transform(utf8.decoder)       // Decode bytes to UTF-8.
      .transform(new LineSplitter()) // Convert stream to individual lines.
      .listen((String line) {        // Process results.

    List row = line.split(','); // split by comma

    String name = row[0];
    int id = int.parse(row[1]);

    print('$id, $name');
    _ret.add(name);
  },
      onDone: () { print('File is now closed.'); return _ret;},
      onError: (e) { print(e.toString()); });
}