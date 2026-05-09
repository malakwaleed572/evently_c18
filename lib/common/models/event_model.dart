import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

class EventModel {
  String? id;
  String userId;
  String title;
  String description;
  int catid;
  DateTime date;
  List<String>? wishlist;
  EventModel({
    required this.catid,
    required this.date,
    required this.description,
    this.id,
    required this.title,
    required this.userId,
    this.wishlist,
  });
  static EventModel fromJson(Map<String, dynamic> json) {
    return EventModel(
      catid: json["catid"],
      date: DateTime.fromMicrosecondsSinceEpoch(json["date"]),
      description: json["description"],
      title: json["title"],
      userId: json["userId"],
      id: json["id"],
      wishlist: json['wishlist'] is List
          ? (json['wishlist'] as List).map((e) => e.toString()).toList()
          : null,
    );
  }

  bool get isFav =>
      (wishlist ?? []).contains(FirebaseAuth.instance.currentUser!.uid);
  Map<String, Object?> toJson() {
    return {
      'catid': catid,
      'date': date.microsecondsSinceEpoch,
      'description': description,
      'title': title,
      'userId': userId,
      'id': id,
      'wishlist': wishlist ?? [],
    };
  }
}
