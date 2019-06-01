import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

String barcodeKey = "&key=";
String url = 'https://api.barcodelookup.com/v2/products?formatted=y&category=Food, Beverages & Tobacco';

Future<List<IngredientItem>> grocerySearch(String search){
  String _p = url + "&search=$search&$barcodeKey";
}

Future<IngredientItem> upcSearch(String upc){
  String _p = url + "&barcode=$upc&$barcodeKey";
}

