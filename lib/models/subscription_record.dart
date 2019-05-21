// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

import 'dart:convert';

class SubscriptionRecord {
  int level;
  DateTime start;
  DateTime end;

  SubscriptionRecord({
    this.level,
    this.start,
    this.end,
  });

  factory SubscriptionRecord.newUser() => new SubscriptionRecord(
    level: 3,
    start: DateTime.now(),
    end: DateTime.now().add(new Duration(days: 14)),
  );

  factory SubscriptionRecord.fromJson(String str) => SubscriptionRecord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubscriptionRecord.fromMap(Map json) => new SubscriptionRecord(
    level: json["level"] == null ? null : json["level"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
  );

  Map<String, dynamic> toMap() => {
    "level": level == null ? null : level,
    "start": start == null ? null : start.toIso8601String(),
    "end": end == null ? null : end.toIso8601String(),
  };
}
