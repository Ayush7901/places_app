import 'dart:io';

import 'package:flutter/material.dart';
import 'package:place_app/helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async{
    final data = await DBHelper.getData('user_places');
    _items = data
        .map(
          (item) => Place(
            id: item['id'],
            image: File(item['image']),
            location: null,
            title: item['title'],
          ),
        )
        .toList();
        notifyListeners();
  }
}
