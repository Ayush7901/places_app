import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double longitude;
  final double latitude;
  String address;
  PlaceLocation(
    this.longitude,
    this.latitude,
  );
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
