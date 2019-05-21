import 'dart:convert';

class IngredientItem {
  int id;
  String aisle;
  String image;
  String name;
  String originalName;
  int amount;
  String unit;
  Measures measures;
  List<GroceryItem> groceryItems;
  List<String> tips;

  IngredientItem({
    this.id,
    this.aisle,
    this.image,
    this.name,
    this.originalName,
    this.amount,
    this.unit,
    this.measures,
    this.groceryItems,
    this.tips,
  });

  factory IngredientItem.fromJson(String str) => IngredientItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IngredientItem.fromMap(Map<String, dynamic> json) => new IngredientItem(
    id: json["id"] == null ? null : json["id"],
    aisle: json["aisle"] == null ? null : json["aisle"],
    image: json["image"] == null ? null : json["image"],
    name: json["name"] == null ? null : json["name"],
    originalName: json["originalName"] == null ? null : json["originalName"],
    amount: json["amount"] == null ? null : json["amount"],
    unit: json["unit"] == null ? null : json["unit"],
    measures: json["measures"] == null ? null : Measures.fromMap(json["measures"]),
    groceryItems: json["grocery_items"] == null ? null : new List<GroceryItem>.from(json["grocery_items"].map((x) => GroceryItem.fromMap(x))),
    tips: json["tips"] == null ? null : new List<String>.from(json["tips"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "aisle": aisle == null ? null : aisle,
    "image": image == null ? null : image,
    "name": name == null ? null : name,
    "originalName": originalName == null ? null : originalName,
    "amount": amount == null ? null : amount,
    "unit": unit == null ? null : unit,
    "measures": measures == null ? null : measures.toMap(),
    "grocery_items": groceryItems == null ? null : new List<dynamic>.from(groceryItems.map((x) => x.toMap())),
    "tips": tips == null ? null : new List<dynamic>.from(tips.map((x) => x)),
  };
}

class GroceryItem {
  String barcodeNumber;
  String productName;
  String category;
  String brand;
  String packageQuantity;
  String size;
  String description;
  List<String> images;
  List<Store> stores;

  GroceryItem({
    this.barcodeNumber,
    this.productName,
    this.category,
    this.brand,
    this.packageQuantity,
    this.size,
    this.description,
    this.images,
    this.stores,
  });

  factory GroceryItem.fromJson(String str) => GroceryItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroceryItem.fromMap(Map<String, dynamic> json) => new GroceryItem(
    barcodeNumber: json["barcode_number"] == null ? null : json["barcode_number"],
    productName: json["product_name"] == null ? null : json["product_name"],
    category: json["category"] == null ? null : json["category"],
    brand: json["brand"] == null ? null : json["brand"],
    packageQuantity: json["package_quantity"] == null ? null : json["package_quantity"],
    size: json["size"] == null ? null : json["size"],
    description: json["description"] == null ? null : json["description"],
    images: json["images"] == null ? null : new List<String>.from(json["images"].map((x) => x)),
    stores: json["stores"] == null ? null : new List<Store>.from(json["stores"].map((x) => Store.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "barcode_number": barcodeNumber == null ? null : barcodeNumber,
    "product_name": productName == null ? null : productName,
    "category": category == null ? null : category,
    "brand": brand == null ? null : brand,
    "package_quantity": packageQuantity == null ? null : packageQuantity,
    "size": size == null ? null : size,
    "description": description == null ? null : description,
    "images": images == null ? null : new List<dynamic>.from(images.map((x) => x)),
    "stores": stores == null ? null : new List<dynamic>.from(stores.map((x) => x.toMap())),
  };
}

class Store {
  String storeName;
  String storePrice;
  String productUrl;
  String currencyCode;
  String currencySymbol;

  Store({
    this.storeName,
    this.storePrice,
    this.productUrl,
    this.currencyCode,
    this.currencySymbol,
  });

  factory Store.fromJson(String str) => Store.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Store.fromMap(Map<String, dynamic> json) => new Store(
    storeName: json["store_name"] == null ? null : json["store_name"],
    storePrice: json["store_price"] == null ? null : json["store_price"],
    productUrl: json["product_url"] == null ? null : json["product_url"],
    currencyCode: json["currency_code"] == null ? null : json["currency_code"],
    currencySymbol: json["currency_symbol"] == null ? null : json["currency_symbol"],
  );

  Map<String, dynamic> toMap() => {
    "store_name": storeName == null ? null : storeName,
    "store_price": storePrice == null ? null : storePrice,
    "product_url": productUrl == null ? null : productUrl,
    "currency_code": currencyCode == null ? null : currencyCode,
    "currency_symbol": currencySymbol == null ? null : currencySymbol,
  };
}

class Measures {
  Amount us;
  Amount metric;

  Measures({
    this.us,
    this.metric,
  });

  factory Measures.fromJson(String str) => Measures.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Measures.fromMap(Map<String, dynamic> json) => new Measures(
    us: json["us"] == null ? null : Amount.fromMap(json["us"]),
    metric: json["metric"] == null ? null : Amount.fromMap(json["metric"]),
  );

  Map<String, dynamic> toMap() => {
    "us": us == null ? null : us.toMap(),
    "metric": metric == null ? null : metric.toMap(),
  };
}

class Amount {
  int amount;
  String unitShort;
  String unitLong;

  Amount({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  factory Amount.fromJson(String str) => Amount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Amount.fromMap(Map<String, dynamic> json) => new Amount(
    amount: json["amount"] == null ? null : json["amount"],
    unitShort: json["unitShort"] == null ? null : json["unitShort"],
    unitLong: json["unitLong"] == null ? null : json["unitLong"],
  );

  Map<String, dynamic> toMap() => {
    "amount": amount == null ? null : amount,
    "unitShort": unitShort == null ? null : unitShort,
    "unitLong": unitLong == null ? null : unitLong,
  };
}